<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String accountId		= nvl(request.getParameter("account"));
	String entityId			= nvl(request.getParameter("entity"));
	String [] year_status	= request.getParameterValues("dStatus");
	List<Status> statuses 	= new ArrayList<Status>();
	Status		 stt		= null;
	
	try {
		for (int i =0; i < year_status.length; i++){
			stt = new Status();
			stt.year = year_status[i].split(",")[0];
			stt.status = year_status[i].split(",")[1];
			statuses.add(stt);
		}
		
		out.println(changeStatus(accountId, entityId, statuses));
		
		
	} catch (Exception e) {
		out.println (e.toString());
	}
	
%><%!

	public class Status{
		public String year = null;
		public String status = null;
	}
	
	public String changeStatus(String accountId, String entityId, List<Status>statuses) throws Exception{
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		
		String dataSource     = "jdbc/development";
		
		String status = "";
		
		try {
			conn = conn = DBConnection.openConnection(dataSource);
			try {
				for(Status stt : statuses){
					if(stt.status.equals("Y")){
						ps = conn.prepareStatement("update tnt_entity"
										  +"	Set inactive = 'N'"
										  +"where accountid = ? and entityid = ?"
										  +"	and year = ?"
										   );
					} else {
						ps = conn.prepareStatement("update tnt_entity"
										  +"	Set inactive = 'Y'"
										  +"where accountid = ? and entityid = ?"
										  +"	and year = ?"
										   );
					
					}
					
					ps.setString(1,accountId);
					ps.setString(2,entityId);
					ps.setString(3,stt.year);
					ps.executeUpdate();
				}
				
			} catch (Exception e) {
				throw e;
			}
		
		} catch (Exception e) {
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
		}
		status = "Sucessfully changed status";
		return status;
	}
	
%>