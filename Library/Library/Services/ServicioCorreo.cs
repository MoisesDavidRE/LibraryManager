using System.Threading;
using System.Threading.Tasks;
using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Auth.OAuth2.Flows;
using Google.Apis.Auth.OAuth2.Responses;
using System.Configuration;

namespace Library.Services
{
    public class ServicioCorreo
    {
        private readonly string _remitente = ConfigurationManager.AppSettings["EmailRemitente"];
        private readonly string _clientId = ConfigurationManager.AppSettings["EmailClientId"];
        private readonly string _clientSecret = ConfigurationManager.AppSettings["EmailClientSecret"];
        private readonly string _refreshToken = ConfigurationManager.AppSettings["EmailRefreshToken"];

        public async Task EnviarCorreoBienvenidaAsync(string destinatario, string nombreUsuario)
        {
            var mensaje = new MimeMessage();
            mensaje.From.Add(new MailboxAddress("Sistema Librería", _remitente));
            mensaje.To.Add(new MailboxAddress(nombreUsuario, destinatario));
            mensaje.Subject = "¡Bienvenido al Sistema de Librería!";

            var builder = new BodyBuilder();
            builder.HtmlBody = $@"
                <div style='font-family: Arial, sans-serif; padding: 20px;'>
                    <h2 style='color: #2E86C1;'>¡Hola {nombreUsuario}!</h2>
                    <p>Tu cuenta ha sido creada exitosamente en nuestro sistema.</p>
                    <p>Ya puedes acceder para gestionar préstamos, ventas y nuestro catálogo.</p>
                    <br>
                    <p>Saludos,<br>El equipo de la Librería</p>
                </div>";

            mensaje.Body = builder.ToMessageBody();

            var clientSecrets = new ClientSecrets
            {
                ClientId = _clientId,
                ClientSecret = _clientSecret
            };

            var flow = new GoogleAuthorizationCodeFlow(new GoogleAuthorizationCodeFlow.Initializer
            {
                ClientSecrets = clientSecrets
            });

            var credential = new UserCredential(flow, "user", new TokenResponse
            {
                RefreshToken = _refreshToken
            });

            await credential.RefreshTokenAsync(CancellationToken.None);

            var oauth2 = new SaslMechanismOAuth2(_remitente, credential.Token.AccessToken);

            using (var client = new SmtpClient())
            {
                await client.ConnectAsync("smtp.gmail.com", 465, SecureSocketOptions.SslOnConnect);
                await client.AuthenticateAsync(oauth2);
                await client.SendAsync(mensaje);
                await client.DisconnectAsync(true);
            }
        }
    }
}