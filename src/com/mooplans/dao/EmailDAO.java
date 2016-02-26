package com.mooplans.dao;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailDAO {
	
	public static void sendMail(String to, String subject, String message, String type){
		
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true");
	    props.put("mail.smtp.port", "587");
	    props.put("mail.smtp.host", "m.outlook.com");
	    props.put("mail.smtp.auth", "true");

		final String username = "thecows@mooplans.com";
		final String password = "-1holbrook";
		try{

			Session session = Session.getDefaultInstance(props, new Authenticator(){

				protected PasswordAuthentication getPasswordAuthentication() {

					return new PasswordAuthentication(username, password);
				}
			});

			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(username));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to,false));
			msg.setSubject(subject);
			msg.setText(message);
			msg.setSentDate(new Date());
			Transport.send(msg);


			// Store the mail in Company's inbox as well

			msg = new MimeMessage(session); // Create a new message
			msg.setFrom(new InternetAddress(username));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(username,false));
			msg.setSubject(subject + " From: " + to);
			msg.setText(to+" sent:\n"+message);
			msg.setSentDate(new Date());
			Transport.send(msg);

		}catch (MessagingException e){ 
			e.printStackTrace();
		}
	}

}