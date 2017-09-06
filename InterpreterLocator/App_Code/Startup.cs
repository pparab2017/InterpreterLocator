using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(InterpreterLocator.Startup))]
namespace InterpreterLocator
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
