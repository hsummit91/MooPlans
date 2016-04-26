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
				sb.append("Thanks for joining MooPlans<br>");
				sb.append("You'll be happy to know that we deliver breakfast, lunch and dinner right to your<br>");
				sb.append("home, school, or office every day -- you've probably seen our Moo Plans swag<br>");
				sb.append("around already.<br><br>");
				sb.append("Food is ordered via our website, and we feature a new local restaurant every<br>");
				sb.append("day. Here's a video so you know what we're all about.<br>");
				sb.append("If you want one free week of food, check out your referral code.");
				sb.append("<br><br>Reply to this email if you have any questions");

				message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
				message.setSubject("Registration!");
				break;


			case 2:
				sb.append("You've successfully added "+points+" points to your account.<br>");
				sb.append("You have total "+user.getUser_points()+" points.<br><br>Happy Eating!");
				message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
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

	public static void sendOrderMailUser(User user, HashMap<Integer, String> items, int orderId){

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
			sb.append("<table><thead><tr><th>Food Item</th><th>Points</th></tr></thead><tbody>");

			float total = 0;		
			for(Integer key: items.keySet()){
				float points = PayPalDAO.getBill(key);
				total += points; 
				sb.append("<tr><td>"+items.get(key)+"</td><td>"+points+"</td></tr>");
				System.out.println("In EmailDAO Key"+items.get(key)+" value="+key);
			}
			sb.append("<tr><td>Total Points</td><td>"+total+"</td></tr>");
			sb.append("</tbody></table>");
			sb.append("<br><br>Delivery Address<br>" +user.getUser_address());

			message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sb.toString(), "text/html" );
			message.setSubject("Moo Plans Order #"+orderId);
			message.setSentDate(new Date());
			Transport.send(message);
			System.out.println("Order details email sent to User "+user.getUser_firstname());
		}catch (MessagingException e){ 
			e.printStackTrace();
		}
	}


	public static void sendOrderMailRest(User user, HashMap<Integer, String> items, int orderId){

		final String INIT = "Customer, "+user.getUser_firstname()+",\nhas ordered food from MooPlans<br>"
				+"<br>Order Summary:<br><br>"
				+"<table><thead><tr><th>Food Item</th><th>Points</th></tr></thead><tbody>";

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
				dishes = PayPalDAO.getDishDetails(key);
				String email = dishes.getRestEmail();

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
					total += dish.getDishPrice(); 
					sbb.append("<tr><td>"+dish.getDishName()+"</td><td>"+dish.getDishPrice()+"</td></tr>");
				}
				sbb.append("<tr><td>Total Points</td><td>"+total+"</td></tr>");
				sbb.append("</tbody></table>");
				sbb.append("<br><br>Please delivery food at Address:<br>" +user.getUser_address());

				message.setContent("<img src = \"http://i65.tinypic.com/j9buo4.jpg\"/>"+"<br><br>"+sbb.toString(), "text/html" );
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