using System.Collections.Generic;
using System.Web.Mvc;

namespace Library.ViewModels
{
    public class NuevaVentaViewModel
    {
        public int IdCliente { get; set; }

        public IEnumerable<SelectListItem> ClientesDisponibles { get; set; }

        public int IdCopiaSeleccionada { get; set; }

        public IEnumerable<SelectListItem> CopiasDisponibles { get; set; }

        public decimal Total { get; set; }
    }
}