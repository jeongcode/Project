package vo;

public class ActionForward {
	private boolean isRedirect=false;
	private String path=null;
	
	public boolean isRedirect(){
		return isRedirect;
	}
	
	public String getPath(){
		return path;
	}
	
	public void setRedirect(boolean status){
		isRedirect = status;
	}
	
	public void setPath(String string){
		path = string;
	}
}