using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Library.ViewModels
{
    public class NuevoPrestamoViewModel
    {
        public int IdCliente { get; set; }
        public IEnumerable<SelectListItem> ClientesDisponibles { get; set; }

        public int IdCopiaSeleccionada { get; set; }
        public IEnumerable<SelectListItem> CopiasDisponibles { get; set; }

        // Agregamos la fecha límite para la devolución
        public DateTime FechaLimite { get; set; }
    }
}