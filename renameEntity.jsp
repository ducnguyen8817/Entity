<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String accountId 		= nvl(request.getParameter("account"));
	String entityId			= nvl(request.getParameter("entity"));
	String newEntityName	= nvl(request.getParameter("newEntityName"));
	
	try {
			out.println(updateEntityName(accountId, entityId, newEntityName));
			
	} catch (Exception e){
		out.println (e.toString());
	}
%><%!

	public String updateEntityName(String accountId, String entityId, String newName) throws Exception {
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		
		String dataSource     = "jdbc/development";
		
		String status = "";
		
		try {
			conn = conn = DBConnection.openConnection(dataSource);
			try {
				ps = conn.prepareStatement("update tnt_entity"
										  +"	Set name = ?"
										  +"where accountid = ? and entityid = ?"
										  );
				ps.setString(1,newName);
				ps.setString(2,accountId);
				ps.setString(3,entityId);
				
				ps.executeUpdate();
				status = "Sucessfully updated the entity name";
			} catch (Exception e) {
				throw e;
			}
		
		} catch (Exception e) {
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
		}
		
		return status;
	}
%>