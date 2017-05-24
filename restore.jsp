<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String accountId 		= nvl(request.getParameter("account"));
	String entityId	 		= nvl(request.getParameter("entityId"));
	String [] fieldNames 	= request.getParameterValues("fieldNames");
	String [] restoreValues = request.getParameterValues("restoreValues");
	try {
			out.println(restore(accountId, entityId,fieldNames, restoreValues));
	} catch (Exception e){
		out.println (e.toString());
	}
%><%!

	public String restore(String accountId, String entityId,
						 String[] fieldNames, String[] restoreValues) throws Exception {
		String dataSource     = "jdbc/development";
		
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		ResultSet			rs			= null;
		
		String status = "";
		try {
			conn = DBConnection.openConnection(dataSource);
			
			try {
			
				ps = conn.prepareStatement("update tnt_worksheet"
										  +"	set value = ?"
										  +"where accountId = ? and entityId = ?"
										  +"	and name = ?"
										  );
				ps.setString(2, accountId);
				ps.setString(3, entityId);
				
				for(int i =0; i < fieldNames.length; i++){
					ps.setString(1,	restoreValues[i]);
					ps.setString(4, fieldNames[i]);
					
				}
				
				
				status = "Successfully restored";
			} catch(Exception e){
				throw e;
			}
		
			
		} catch (Exception e) {
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
			try { rs.close(); } catch (Exception e){}
		}
		
		return status;
	}
%>