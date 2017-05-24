<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	Entity [] entities = null;
	String accountId	  = nvl(request.getParameter("account"),"");
	try {
		entities			  = getEntity(accountId);
		out.println(toJson(entities));
	} catch (Exception e) {
		out.println (e.toString());
	}

%><%!

	public class Entity {
		public String entityId = null;
		public String name = null;
	}
	
	
	public Entity [] getEntity(String accountId) throws Exception {
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		ResultSet			rs			= null;
		
		List<Entity> entities = new ArrayList<Entity>();
		Entity 		 entity	  = null;
		String dataSource     = "jdbc/development";
		
		try {
			conn = DBConnection.openConnection(dataSource);
			try {
				ps = conn.prepareStatement("select name, entityid "
										  +" from tnt_entity"
										  +" where accountid =?"
										  +" group by name, entityid"
										  +" order by name"
										  );
										  
				ps.setString(1,accountId);
				rs = ps.executeQuery();
				
				if(!rs.isBeforeFirst()){
					entities.add(null);
				}
				
				while (rs.next()) {
					entity	= new Entity();
					entity.name = nvl(rs.getString("name"));
					entity.entityId = nvl(rs.getString("entityid"));
					entities.add(entity);
				}
			} catch (Exception e) {
				throw e;
			}
		
		} catch (Exception e){
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
			try { rs.close(); } catch (Exception e){}
		}
		
		
		Entity [] entityArr = entities.toArray(new Entity[entities.size()]);
		
		return entityArr ;
	}
%>