package com.mooplans.dao;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import com.mooplans.model.Dishes;
import com.mooplans.model.User;

public class EmailDAO {

	public static boolean sendMail(User user, int type){

		boolean emailSent = true;
		
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.host", "m.outlook.com");
		props.put("mail.smtp.auth", "true");

		final String username = "thecows@mooplans.com", password = "-1holbrook";
		try{
			Session session = Session.getDefaultInstance(props, new Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			});

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(user.getUser_email()));

			StringBuilder sb = new StringBuilder();
			sb.append("Hi "+user.getUser_firstname()+",\n");
			switch(type){

			case 1:
				sb.append("Thanks for joining MooPlans<br>");
				sb.append("You'll be happy to know that we deliver breakfast, lunch and dinner right to your<br>");
				sb.append("home, school, or office every day -- you've probably seen our Moo Plans swag<br>");
				sb.append("around already.<br><br>");
				sb.append("Food is ordered via our website, and we feature a new local restaurant every<br>");
				sb.append("day. Here's a video so you know what we're all about.<br>");
				sb.append("If you want one free week of food, check out your referral code.");
				sb.append("<br><br>Reply to this email if you have any questions");

				message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
				//message.setContent("<img src = \"http://i67.tinypic.com/v9c9x.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
				message.setSubject("Registration!");
				break;
			case 2:
				/*

				 * Do we have Order details in Session ? We need to use that to make the Order String 

				Assuming I get a HashMap 
				
				Key | Value
				User (Restaurant) Object | List of Items Ordered from the same

				 * */
				HashMap<User, List<Dishes>> map = new HashMap<>();
				
				sb.append("Thanks for using MooPlans to Order Food<br>");
				sb.append("Order Details:<br>");
				for(User u : map.keySet()){
					// Fill in from Cart Object
				}
			
				
				
				message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
				message.setSubject("Order Details");
				
				message.setSentDate(new Date());
				Transport.send(message);
				// Email sent to User
				
				// This is for Restaurants
				for(User u : map.keySet()){
					sb = new StringBuilder();
					message = new MimeMessage(session);
					message.setFrom(new InternetAddress(username));
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(u.getUser_email()));
					
					sb.append("Hi "+u.getUser_firstname()+",<br>");
					sb.append("One of our customers just placed an order!<br>");
					sb.append("Order details:<br>");
					
					ArrayList<Dishes> dishes = (ArrayList<Dishes>)map.get(u);
					
					for(Dishes dish : dishes){
						sb.append(dish.getDishName()+"<br>");
					}
					
					message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
					message.setSubject("Order Details");
					
					message.setSentDate(new Date());
					Transport.send(message);
				}
				
				return emailSent;
//				break;
			case 3:break;
			case 4:
				sb.append("You've successfully added points to your account. You now have:<br>");
				sb.append(user.getUser_points()+"<br><br>Happy Eating!");
				message.setSubject("Points Added!");
				break;
			}
			message.setSentDate(new Date());
			Transport.send(message);
			System.out.println("Sent");

			//Store the mail in Company's inbox as well
			//message.setFrom(new InternetAddress(username));
			//message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(username,false));
			//message.setSubject(subject + " From: " + user.getUser_address());
			//Transport.send(message);

		}catch (MessagingException e){ 
			e.printStackTrace();
			emailSent = false;
			return emailSent;
		}
		return emailSent;
	}
}



//public static void main(String[] args) {

//User user = new User();

//user.setUser_firstname("Fahad");

//user.setUser_email("fahad.spring2015@gmail.com");

//sendMail(user, 1);

//}