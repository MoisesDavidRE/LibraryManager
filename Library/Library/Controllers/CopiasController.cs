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
    public class CopiasController : Controller
    {
        private LibraryEntities db = new LibraryEntities();

        // GET: Copias
        public ActionResult Index(int page = 1)
        {
            int pageSize = 10;

            var copiasQuery = db.Copias
                                .Include(c => c.Libro)
                                .OrderBy(c => c.id_copia);

            var copias = copiasQuery
                         .Skip((page - 1) * pageSize)
                         .Take(pageSize)
                         .ToList();

            int totalRecords = copiasQuery.Count();
            int totalPages = (int)Math.Ceiling((double)totalRecords / pageSize);

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = totalPages;

            return View(copias);
        }

        // GET: Copias/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Copia copia = db.Copias.Find(id);
            if (copia == null)
            {
                return HttpNotFound();
            }
            return View(copia);
        }

        // GET: Copias/Create
        public ActionResult Create()
        {
            ViewBag.id_libro = new SelectList(db.Libroes, "id_libro", "titulo");
            return View();
        }

        // POST: Copias/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_copia,id_libro,tipo,estado,precio")] Copia copia)
        {
            if (ModelState.IsValid)
            {
                db.Copias.Add(copia);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_libro = new SelectList(db.Libroes, "id_libro", "titulo", copia.id_libro);
            return View(copia);
        }

        // GET: Copias/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Copia copia = db.Copias.Find(id);
            if (copia == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_libro = new SelectList(db.Libroes, "id_libro", "titulo", copia.id_libro);
            return View(copia);
        }

        // POST: Copias/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_copia,id_libro,tipo,estado,precio")] Copia copia)
        {
            if (ModelState.IsValid)
            {
                db.Entry(copia).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_libro = new SelectList(db.Libroes, "id_libro", "titulo", copia.id_libro);
            return View(copia);
        }

        // GET: Copias/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Copia copia = db.Copias.Find(id);
            if (copia == null)
            {
                return HttpNotFound();
            }
            return View(copia);
        }

        // POST: Copias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Copia copia = db.Copias.Find(id);
            db.Copias.Remove(copia);
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
