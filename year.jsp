<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String accountId 		= nvl(request.getParameter("account"));
	String entityId		= nvl(request.getParameter("entity"));
	Entity [] years = null;
	try {
		years = getYears(accountId, entityId);
		out.println(toJson(years));
	} catch (Exception e){
		out.println (e.toString());
	}
%><%!

	public class Entity {
		public String entityId = null;
		public String name = null;
		public String year = null;
	}
	
	

	public Entity[] getYears(String accountId, String entityId) throws Exception {
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		ResultSet			rs			= null;
		
		String dataSource     = "jdbc/development";
		
		List<Entity> years	  = new ArrayList<Entity>();
		Entity		 year	  = null;
		
		
		try {
			conn =  DBConnection.openConnection(dataSource);
			try {
				ps = conn.prepareStatement("select year "
										  +" from tnt_entity "
										  +"where accountid = ? and entityid = ?"
										   );	
			
				ps.setString(1,accountId);
				ps.setString(2,entityId);
				
				rs = ps.executeQuery();
				
				if(!rs.isBeforeFirst()){
					years.add(null);
				}
				
				while(rs.next()){
					year = new Entity();
					year.year = nvl(rs.getString("year"));
					years.add(year);
				}
			
			} catch (Exception e) {
				throw e;
			}
		
		} catch (Exception e) {
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
			try { rs.close();} catch (Exception e){}
		}
		
		Entity [] yearArr	= years.toArray( new Entity[years.size()]);
		return yearArr;
	}
%>