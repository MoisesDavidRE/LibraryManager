using Library.Models;
using Library.ViewModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;

namespace Library.Controllers
{
    [Authorize]
    public class PrestamoesController : Controller
    {
        private LibraryEntities db = new LibraryEntities();

        // GET: Prestamoes
        public ActionResult Index()
        {
            var prestamoes = db.Prestamoes.Include(p => p.Cliente).Include(p => p.Copia);
            return View(prestamoes.ToList());
        }

        // GET: Prestamoes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestamo prestamo = db.Prestamoes.Find(id);
            if (prestamo == null)
            {
                return HttpNotFound();
            }
            return View(prestamo);
        }

        public ActionResult Devoluciones()
        {
            var prestamosActivos = db.Prestamoes
                .Include(p => p.Cliente)
                .Include(p => p.Copia)
                .Include(p => p.Copia.Libro)
                .Where(p => p.estado == "Activo")
                .ToList();

            return View(prestamosActivos);
        }

        [HttpPost]
        public JsonResult ProcesarDevolucion(int idPrestamo)
        {
            using (var transaction = db.Database.BeginTransaction())
            {
                try
                {
                    var prestamo = db.Prestamoes.Find(idPrestamo);
                    if (prestamo == null || prestamo.estado != "Activo")
                    {
                        return Json(new { success = false, message = "Préstamo no válido o ya devuelto." });
                    }

                    prestamo.estado = "Devuelto";
                    prestamo.fecha_devolucion = DateTime.Now;
                    db.Entry(prestamo).State = EntityState.Modified;

                    var copia = db.Copias.Find(prestamo.id_copia);
                    if (copia != null)
                    {
                        copia.estado = "Disponible";
                        db.Entry(copia).State = EntityState.Modified;
                    }

                    db.SaveChanges();
                    transaction.Commit();

                    return Json(new { success = true });
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return Json(new { success = false, message = ex.Message });
                }
            }
        }
        public ActionResult Create()
        {
            var viewModel = new NuevoPrestamoViewModel
            {
                // Por defecto, sugerimos que el préstamo dure 7 días
                FechaLimite = DateTime.Now.AddDays(7),

                ClientesDisponibles = db.Clientes.Select(c => new SelectListItem
                {
                    Value = c.id_cliente.ToString(),
                    Text = c.nombre
                }).ToList(),

                CopiasDisponibles = db.Copias
                    .Where(c => c.estado == "Disponible")
                    .Select(c => new SelectListItem
                    {
                        Value = c.id_copia.ToString(),
                        // Mostramos el título y si es Física o Digital
                        Text = c.Libro.titulo + " (" + c.tipo + ")"
                    }).ToList()
            };

            return View(viewModel);
        }

        // POST AJAX: Procesar los préstamos
        [HttpPost]
        public JsonResult ProcesarPrestamos(int idCliente, DateTime fechaLimite, List<int> idsCopias)
        {
            if (idsCopias == null || !idsCopias.Any())
            {
                return Json(new { success = false, message = "No se recibieron libros para procesar." });
            }

            using (var transaction = db.Database.BeginTransaction())
            {
                try
                {
                    foreach (var idCopia in idsCopias)
                    {
                        var copia = db.Copias.Find(idCopia);

                        if (copia == null || copia.estado != "Disponible")
                        {
                            throw new Exception($"La copia seleccionada ya no está disponible.");
                        }

                        // Se crea un registro de préstamo por CADA libro
                        Prestamo nuevoPrestamo = new Prestamo
                        {
                            id_cliente = idCliente,
                            id_copia = idCopia,
                            fecha_prestamo = DateTime.Now,
                            fecha_limite = fechaLimite,
                            estado = "Activo" // Estado por defecto
                        };

                        db.Prestamoes.Add(nuevoPrestamo);

                        // Actualizar estado de la copia (Inventario) a "Prestado"
                        copia.estado = "Prestado";
                        db.Entry(copia).State = System.Data.Entity.EntityState.Modified;
                    }

                    db.SaveChanges();
                    transaction.Commit();

                    return Json(new { success = true });
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return Json(new { success = false, message = ex.Message });
                }
            }
        }

        // POST: Prestamoes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_prestamo,id_cliente,id_copia,fecha_prestamo,fecha_limite,fecha_devolucion,estado")] Prestamo prestamo)
        {
            if (ModelState.IsValid)
            {
                db.Prestamoes.Add(prestamo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_cliente = new SelectList(db.Clientes, "id_cliente", "nombre", prestamo.id_cliente);
            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo", prestamo.id_copia);
            return View(prestamo);
        }

        // GET: Prestamoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestamo prestamo = db.Prestamoes.Find(id);
            if (prestamo == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_cliente = new SelectList(db.Clientes, "id_cliente", "nombre", prestamo.id_cliente);
            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo", prestamo.id_copia);
            return View(prestamo);
        }

        // POST: Prestamoes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_prestamo,id_cliente,id_copia,fecha_prestamo,fecha_limite,fecha_devolucion,estado")] Prestamo prestamo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(prestamo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_cliente = new SelectList(db.Clientes, "id_cliente", "nombre", prestamo.id_cliente);
            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo", prestamo.id_copia);
            return View(prestamo);
        }

        // GET: Prestamoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Prestamo prestamo = db.Prestamoes.Find(id);
            if (prestamo == null)
            {
                return HttpNotFound();
            }
            return View(prestamo);
        }

        // POST: Prestamoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Prestamo prestamo = db.Prestamoes.Find(id);
            db.Prestamoes.Remove(prestamo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
