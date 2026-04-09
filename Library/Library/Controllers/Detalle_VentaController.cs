using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Library.Models;

namespace Library.Controllers
{
    [Authorize]
    public class Detalle_VentaController : Controller
    {
        private LibraryEntities db = new LibraryEntities();

        // GET: Detalle_Venta
        public ActionResult Index()
        {
            var detalle_Venta = db.Detalle_Venta.Include(d => d.Copia).Include(d => d.Venta);
            return View(detalle_Venta.ToList());
        }

        // GET: Detalle_Venta/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Detalle_Venta detalle_Venta = db.Detalle_Venta.Find(id);
            if (detalle_Venta == null)
            {
                return HttpNotFound();
            }
            return View(detalle_Venta);
        }

        // GET: Detalle_Venta/Create
        public ActionResult Create()
        {
            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo");
            ViewBag.id_venta = new SelectList(db.Ventas, "id_venta", "id_venta");
            return View();
        }

        // POST: Detalle_Venta/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_detalle,id_venta,id_copia,precio_unitario")] Detalle_Venta detalle_Venta)
        {
            if (ModelState.IsValid)
            {
                db.Detalle_Venta.Add(detalle_Venta);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo", detalle_Venta.id_copia);
            ViewBag.id_venta = new SelectList(db.Ventas, "id_venta", "id_venta", detalle_Venta.id_venta);
            return View(detalle_Venta);
        }

        // GET: Detalle_Venta/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Detalle_Venta detalle_Venta = db.Detalle_Venta.Find(id);
            if (detalle_Venta == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo", detalle_Venta.id_copia);
            ViewBag.id_venta = new SelectList(db.Ventas, "id_venta", "id_venta", detalle_Venta.id_venta);
            return View(detalle_Venta);
        }

        // POST: Detalle_Venta/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_detalle,id_venta,id_copia,precio_unitario")] Detalle_Venta detalle_Venta)
        {
            if (ModelState.IsValid)
            {
                db.Entry(detalle_Venta).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_copia = new SelectList(db.Copias, "id_copia", "tipo", detalle_Venta.id_copia);
            ViewBag.id_venta = new SelectList(db.Ventas, "id_venta", "id_venta", detalle_Venta.id_venta);
            return View(detalle_Venta);
        }

        // GET: Detalle_Venta/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Detalle_Venta detalle_Venta = db.Detalle_Venta.Find(id);
            if (detalle_Venta == null)
            {
                return HttpNotFound();
            }
            return View(detalle_Venta);
        }

        // POST: Detalle_Venta/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Detalle_Venta detalle_Venta = db.Detalle_Venta.Find(id);
            db.Detalle_Venta.Remove(detalle_Venta);
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
