using Library.Models;
using Library.ViewModels;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;

namespace Library.Controllers
{
    public class CuentaController : Controller
    {
        private LibraryEntities db = new LibraryEntities();

        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }

            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var usuario = db.Usuarios.FirstOrDefault(u => u.email == model.Email);

            if (usuario != null && BCrypt.Net.BCrypt.Verify(model.Password, usuario.password))
            {
                FormsAuthentication.SetAuthCookie(usuario.email, model.Recordarme);

                if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                    && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                {
                    return Redirect(returnUrl);
                }

                return RedirectToAction("Index", "Home");
            }

            ModelState.AddModelError("", "Correo o contraseña incorrectos.");
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Cuenta");
        }
        [AllowAnonymous]
        public ActionResult Registro()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Registro(RegistroViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            if (db.Usuarios.Any(u => u.email == model.Email))
            {
                ModelState.AddModelError("Email", "Este correo ya está registrado.");
                return View(model);
            }

            Usuario nuevoUsuario = new Usuario
            {
                nombre = model.Nombre,
                email = model.Email,
                password = BCrypt.Net.BCrypt.HashPassword(model.Password),
                id_rol = 2
            };

            db.Usuarios.Add(nuevoUsuario);
            db.SaveChanges();

            return RedirectToAction("Login", "Cuenta");
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing) db.Dispose();
            base.Dispose(disposing);
        }
    }
}