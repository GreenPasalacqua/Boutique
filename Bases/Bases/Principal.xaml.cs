using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Bases
{
    /// <summary>
    /// Interaction logic for Principal.xaml
    /// </summary>
    public partial class Principal : Page
    {
        public Principal()
        {
            InitializeComponent();
        }

        private void Clientes_Click(object sender, RoutedEventArgs e)
        {
            Clientes paginaClientes = new Clientes();
            this.NavigationService.Navigate(paginaClientes);
        }
    }
}
