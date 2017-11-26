using System.Windows;

namespace Bases
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow
    {
        public MainWindow()
        {
            InitializeComponent();

            Principal paginaPrincipal = new Principal();
            mainFrame.NavigationService.Navigate(paginaPrincipal);
        }
    }
}