using Library.Models;
using Library.ViewModels;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;

namespace Library.Controllers
{
    [Authorize]
    public class VentasController : Controller
    {
        private LibraryEntities db = new LibraryEntities();

        // GET: Ventas
        public ActionResult Index(int page = 1)
        {
            int pageSize = 10; // cantidad de registros por página

            var ventasQuery = db.Ventas
                                .Include(v => v.Cliente)
                                .OrderBy(v => v.id_venta);

            // Obtener solo los registros de la página actual
            var ventas = ventasQuery
                         .Skip((page - 1) * pageSize)
                         .Take(pageSize)
                         .ToList();

            // Total de registros
            int totalRecords = ventasQuery.Count();

            // Total de páginas
            int totalPages = (int)System.Math.Ceiling((double)totalRecords / pageSize);

            // Enviar datos a la vista
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = totalPages;

            return View(ventas);
        }

        // GET: Ventas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Venta venta = db.Ventas.Find(id);
            if (venta == null)
            {
                return HttpNotFound();
            }
            return View(venta);
        }

        // GET: Ventas/Create
        public ActionResult Create()
        {
            var viewModel = new NuevaVentaViewModel
            {
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
                        Text = c.Libro.titulo + " - $" + c.precio.ToString()
                    }).ToList()
            };

            return View(viewModel);
        }

        [HttpPost]
        public JsonResult ProcesarVenta(int idCliente, List<int> idsCopias)
        {
            if (idsCopias == null || !idsCopias.Any())
            {
                return Json(new { success = false, message = "No se recibieron libros para procesar." });
            }

            // Usamos una transacción de EF explícita para asegurar que todo se guarde, o nada.
            using (var transaction = db.Database.BeginTransaction())
            {
                try
                {
                    // 1. Crear el Maestro (La tabla Venta)
                    decimal totalVenta = 0;
                    Venta nuevaVenta = new Venta
                    {
                        id_cliente = idCliente,
                        fecha_venta = System.DateTime.Now,
                        total = 0 // Lo calcularemos en el siguiente paso
                    };

                    db.Ventas.Add(nuevaVenta);
                    db.SaveChanges(); // Guardamos para que genere el id_venta (IDENTITY)

                    // 2. Procesar el Detalle y actualizar Copias
                    foreach (var idCopia in idsCopias)
                    {
                        // Buscar la copia en la BD
                        var copia = db.Copias.Find(idCopia);

                        if (copia == null || copia.estado != "Disponible")
                        {
                            throw new System.Exception($"La copia con ID {idCopia} ya no está disponible.");
                        }

                        // Crear el detalle de la venta
                        Detalle_Venta detalle = new Detalle_Venta
                        {
                            id_venta = nuevaVenta.id_venta,
                            id_copia = idCopia,
                            precio_unitario = copia.precio
                        };
                        db.Detalle_Venta.Add(detalle);

                        // Sumar al total general
                        totalVenta += copia.precio ?? 0;

                        // Actualizar estado de la copia (Inventario)
                        copia.estado = "Vendido";
                        db.Entry(copia).State = System.Data.Entity.EntityState.Modified;
                    }

                    // 3. Actualizar el total real en la tabla Venta
                    nuevaVenta.total = totalVenta;
                    db.Entry(nuevaVenta).State = System.Data.Entity.EntityState.Modified;

                    // Confirmar todos los cambios en la BD
                    db.SaveChanges();
                    transaction.Commit();

                    return Json(new { success = true });
                }
                catch (System.Exception ex)
                {
                    // Si algo falla, se deshacen los cambios (Rollback)
                    transaction.Rollback();
                    return Json(new { success = false, message = ex.Message });
                }
            }
        }

        // POST: Ventas/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_venta,id_cliente,fecha_venta,total")] Venta venta)
        {
            if (ModelState.IsValid)
            {
                db.Ventas.Add(venta);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_cliente = new SelectList(db.Clientes, "id_cliente", "nombre", venta.id_cliente);
            return View(venta);
        }

        // GET: Ventas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Venta venta = db.Ventas.Find(id);
            if (venta == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_cliente = new SelectList(db.Clientes, "id_cliente", "nombre", venta.id_cliente);
            return View(venta);
        }

        // POST: Ventas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_venta,id_cliente,fecha_venta,total")] Venta venta)
        {
            if (ModelState.IsValid)
            {
                db.Entry(venta).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_cliente = new SelectList(db.Clientes, "id_cliente", "nombre", venta.id_cliente);
            return View(venta);
        }

        // GET: Ventas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Venta venta = db.Ventas.Find(id);
            if (venta == null)
            {
                return HttpNotFound();
            }
            return View(venta);
        }

        // POST: Ventas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Venta venta = db.Ventas.Find(id);
            db.Ventas.Remove(venta);
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
