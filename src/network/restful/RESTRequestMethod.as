package network.restful 
{
	// Flash上でREST対応なHTTPRequestMethodを示す定数です
	public class RESTRequestMethod 
	{
		public static const POST : RESTRequestMethod = new RESTRequestMethod( );
		public static const GET : RESTRequestMethod = new RESTRequestMethod( );
		public static const PUT : RESTRequestMethod = new RESTRequestMethod( );
		public static const DELETE : RESTRequestMethod = new RESTRequestMethod( );
	}

}