package mailtest;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("gkdl5559", "edetilocoshkzdso");
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
