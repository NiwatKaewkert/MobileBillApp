<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Cabin" />
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Lato" />
<style>
table {
    font-family: Cabin;
    border-collapse: collapse;
    width: 70%;
    margin-left:15%; 
    margin-right:15%;
    box-shadow: 0px 0px 20px rgba(0,0,0,0.10),
     0px 10px 20px rgba(0,0,0,0.05),
     0px 20px 20px rgba(0,0,0,0.05),
     0px 30px 20px rgba(0,0,0,0.05);
}

td, th {
    border: 1px solid #f2f2f2;
    font-size: 14px;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

h1 {
	font-family: Cabin;
	font-size: 42px;
	font-style: normal;
	font-variant: normal;
	font-weight: 500;
	line-height: 26.4px;
	text-align: center;
}

p {
	font-family: Lato;
	font-size: 14px;
	font-style: normal;
	font-variant: normal;
	font-weight: 400;
	line-height: 20px;
}
</style>
<title>Mobile Billing Calculator</title>
</head>
<body>
	<%
	String path = application.getRealPath("/") + "promotion1.txt";
	ArrayList<String> arr = new ArrayList<String>();
	
 	File file = new File(path);

	try {
		BufferedReader br = new BufferedReader(new FileReader(file));
		String line;
		while ((line = br.readLine()) != null) {
			arr.add(line);
		}
		br.close();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	
	
	JSONObject info = new JSONObject();
	JSONArray arr_info = new JSONArray();
	String[] data;

	for(int i = 0 ; i < arr.size() ; i++){
		String[] start_time;
		String[] end_time;
		double hh = 0.0;
		double mm = 0.0;
		double ss = 0.0;
		double total_time = 0.0;
		double total_payment = 3.0;
		
		data = arr.get(i).toString().split("\\|");
			
		start_time = data[1].toString().split("\\:");
		end_time = data[2].toString().split("\\:");		
		
		hh = (Double.parseDouble(end_time[0]) - Double.parseDouble(start_time[0]))*60;
		mm = Double.parseDouble(end_time[1]) - Double.parseDouble(start_time[1]);
		ss = (Double.parseDouble(end_time[2]) - Double.parseDouble(start_time[2]))/60;
		
		total_time = total_time + hh + mm + ss;
			
		total_payment += (Math.round(total_time)-1);
				
		info.put("Phone_Number", data[3]);
		info.put("Minute", Math.round(total_time));
		info.put("Total", total_payment);

		arr_info.put(info.toString());
	}
	%>
	
	<h1>Mobile Bill</h1>
	
	<table>
		<tr bgcolor = "#9999ff">
			<th><h3>Telephone Number</h3></th>
			<th><h3>Time spent (Minute)</h3></th>
			<th><h3>Net payable</h3></th>
		</tr>
		<%
		for(int i = 0 ; i < arr_info.length() ; i++) {
			out.print("<tr>");
			out.print("<th>" + new JSONObject(arr_info.get(i).toString()).getString("Phone_Number") + "</th>");
			out.print("<th>" + new JSONObject(arr_info.get(i).toString()).getDouble("Minute") + "</th>");
			out.print("<th>" + new JSONObject(arr_info.get(i).toString()).getDouble("Total") + "</th>");
			out.print("</tr>");
		}
		%>
	</table>
	<p align = "center">Niwat Kaewkert || Assignment test from MFEC.</p><br>
</body>
</html>