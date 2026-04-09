using System;
using System.Linq;
using System.Data.Entity;
using System.Web.Mvc;
using Library.Models;

namespace Library.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private LibraryEntities db = new LibraryEntities();

        public ActionResult Index()
        {
            var hoy = DateTime.Now;
            var inicioMes = new DateTime(hoy.Year, hoy.Month, 1);

            ViewBag.PrestamosActivos = db.Prestamoes.Count(p => p.estado == "Activo");

            ViewBag.PrestamosVencidos = db.Prestamoes.Count(p => p.estado == "Activo" && p.fecha_limite < hoy);

            ViewBag.VentasMes = db.Ventas
                .Where(v => v.fecha_venta >= inicioMes)
                .Select(v => v.total)
                .DefaultIfEmpty(0)
                .Sum();

            ViewBag.TotalLibros = db.Copias.Count(c => c.estado == "Disponible");

            var proximosVencer = db.Prestamoes
                .Include(p => p.Cliente)
                .Include(p => p.Copia.Libro)
                .Where(p => p.estado == "Activo")
                .OrderBy(p => p.fecha_limite)
                .Take(5)
                .ToList();

            return View(proximosVencer);
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
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