package com.mooplans.dao;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

	public static boolean sendMail(User user, int type, float points){

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
				sb.append("<br><br>Thanks for registering on the Moo Plans website. Here is some useful information:<br>");
				sb.append("<br><br>Signing up for a meal plan is really easy. Just follow these three steps:<br><br>");
				sb.append("1. Go to www.mooplans.com<br>");
				sb.append("2. Select one of the price packages from the list of weekly, monthly, or semesterly subscriptions. If you have not logged in, you will be asked to do so before you can make a payment. (Just click 'Already a Member' in the registration page)<br>");
				sb.append("3 .Enjoy - your account will be credited immediately, but you won't be able to spend your meals until the beginning of the Fall semester. If you just reserved the plan, we'll remind you to get the full package over the summer.<br><br>");
				sb.append("You've probably already seen us around campus. Moo Plans is growing extremely fast in the Albany area! Apparently nobody really likes their current meal plans (As if that were a surprise). I hope that you enjoy Moo Plans as much as we do! Feel free to respond with any questions or concerns.<br><br>");
				sb.append("Best Regards,<br>");
				sb.append("The Moo Plans Team");

				message.setContent("<img src = \"http://i68.tinypic.com/157dn46.png\"/>"+"<br><br>"+sb.toString(), "text/html" );
				message.setSubject("Moo Plans - Registration!");
				break;


			case 2:
				sb.append("You've successfully added "+points+" points to your account.<br>");
				sb.append("You have total "+user.getUser_points()+" points.<br><br>Happy Eating!");
				message.setContent("<img src = \"http://i68.tinypic.com/157dn46.png\"/>"+"<br><br>"+sb.toString(), "text/html" );
				message.setSubject("Moo Plans - Points Added!");
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

	public static void sendOrderMailUser(User user, HashMap<String, Float> items, int orderId, String paymentMode){

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
			sb.append("Thanks for using MooPlans to Order Food<br>");
			sb.append("<br>Your Order Summary:<br><br>");
			sb.append("<table><thead><tr><th>Food Item</th><th>Price</th></tr></thead><tbody>");

			float total = 0;		
			for(String key: items.keySet()){
				total += items.get(key); 
				sb.append("<tr><td>"+key+"</td><td>"+items.get(key)+"</td></tr>");
				System.out.println("In EmailDAO Key"+key+" value="+items.get(key));
			}
			sb.append("<tr><td>Total Price</td><td>"+total+"</td></tr>");
			sb.append("</tbody></table>");
			sb.append("<br><br>Payment Mode: <strong>" +paymentMode+"</strong>");
			sb.append("<br><br>Delivery Address<br>" +user.getUser_address());
			sb.append("<br>Phone: "+user.getUser_phone());

			message.setContent("<img src = \"http://i68.tinypic.com/157dn46.png\"/>"+"<br><br>"+sb.toString(), "text/html" );
			message.setSubject("Moo Plans Order #"+orderId);
			message.setSentDate(new Date());
			Transport.send(message);
			System.out.println("Order details email sent to User "+user.getUser_firstname());
		}catch (MessagingException e){ 
			e.printStackTrace();
		}
	}


	public static void sendOrderMailRest(User user, HashMap<Integer, Dishes> items, int orderId, HashMap<Integer, String> notes, String paymentMode){

		final String INIT = "Customer "+user.getUser_firstname()+",\nhas ordered food from MooPlans<br>"
				+"<br>Order Summary:<br><br>"
				+"<table><thead><tr><th>Food Item</th><th>Price</th></tr></thead><tbody>";

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

			// This is for Restaurants
			float total = 0;
			Dishes dishes;
			HashMap<String, ArrayList<Dishes>> finalRestList = new HashMap<>();
			/*
			 * Creating new HashMap to Store the following
			 * Key | Value
			 * Rest Email | List < Dishes Ordered >
			 * 
			 * */

			for(int key : items.keySet()){
				//dishes = PayPalDAO.getDishDetails(key); // 
				String dishNote = notes.get(key);
				dishes = items.get(key);
				String email = dishes.getRestEmail();
				dishes.setComments(dishNote);

				if(finalRestList.containsKey(email)){
					ArrayList<Dishes> l1 = finalRestList.get(email);
					l1.add(dishes);
				}else{
					ArrayList<Dishes> l2 = new ArrayList<>();
					l2.add(dishes);
					finalRestList.put(email, l2);
				}
			}

			for(String email : finalRestList.keySet()){
				message =  new MimeMessage(session);
				message.setFrom(new InternetAddress(username));
				StringBuilder sbb = new StringBuilder(INIT);

				ArrayList<Dishes> itemList = finalRestList.get(email);
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

				for(Dishes dish : itemList){
					if(paymentMode.equals("points")){
						total += dish.getDishPrice();
						sbb.append("<tr><td>"+dish.getDishName()+"</td><td>"+dish.getDishPrice()+"</td></tr>");
					}else{
						total += dish.getDishFullPrice();
						sbb.append("<tr><td>"+dish.getDishName()+"</td><td>"+dish.getDishFullPrice()+"</td></tr>");
					}
					 
					String cmnt = dish.getComments();
					if(cmnt == null || cmnt.equals("")){
						cmnt = "no comments";
					}
					sbb.append("<tr colspan=2><td>  <i>Comments: "+cmnt+"</i></td></tr>");
				}
				sbb.append("<tr><td>Total Price</td><td>"+total+"</td></tr>");
				sbb.append("</tbody></table>");
				sbb.append("<br><br>Payment Mode: <strong>" +paymentMode+"</strong>");
				sbb.append("<br><br>Please delivery food at Address:<br>" +user.getUser_address());
				sbb.append("<br>Phone: "+user.getUser_phone());

				message.setContent("<img src = \"http://i68.tinypic.com/157dn46.png\"/>"+"<br><br>"+sbb.toString(), "text/html" );
				message.setSubject("Moo Plans Order #"+orderId);
				message.setSentDate(new Date());
				Transport.send(message);
				total = 0;
				System.out.println("Order details email sent to restaurant: "+email);
			}
		}catch (MessagingException e){ 
			e.printStackTrace();
		}
		System.out.println("Order details email sent to all Restaurants");
	}
}