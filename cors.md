 # Setup cors headers in rest project
 Create a package called "cors" in your project, and add classes:

## The light-weight version 
Create these two java classes in the cors package:

### Request filter
 
 ```java
@Provider  //This will ensure that the filter is used "automatically"
@PreMatching
public class CorsRequestFilter implements ContainerRequestFilter {
  private final static Logger log = Logger.getLogger(CorsRequestFilter.class.getName());
  @Override
  public void filter(ContainerRequestContext requestCtx) throws IOException {
    // When HttpMethod comes as OPTIONS, just acknowledge that it accepts...
    if (requestCtx.getRequest().getMethod().equals("OPTIONS")) {
      log.info("HTTP Method (OPTIONS) - Detected!");
      // Just send a OK response back to the browser.
      // The response goes through the chain of applicable response filters.
      requestCtx.abortWith(Response.status(Response.Status.OK).build());
    }
  }
} 
}
 ```
 ### Response filter
 
 ```java
@Provider
@PreMatching
public class CorsResponseFilter implements ContainerResponseFilter {
  private final static Logger LOG = Logger.getLogger(CorsResponseFilter.class.getName());
  @Override
  public void filter( ContainerRequestContext requestCtx, ContainerResponseContext res )
    throws IOException {
    LOG.info( "Executing REST response filter" );
    res.getHeaders().add("Access-Control-Allow-Origin", "*" );
    res.getHeaders().add("Access-Control-Allow-Credentials", "true" );
    res.getHeaders().add("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT" );
    res.getHeaders().add("Access-Control-Allow-Headers", "Origin, Accept, Content-Type");
  }
}
 ```
 the @Provider annotation ensures that Jax-rs registers the filter and put these headers on all responses from the rest services.

 ## Alternative - allow on a single endpoint:
 ```java
 @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getPersons() {
        //TODO return proper representation object
        return Response.ok()
                .header("Access-Control-Allow-Origin", "*")
                .header("Access-Control-Allow-Credentials", "true")
                .header("Access-Control-Allow-Headers","origin, content-type, accept, authorization")
                .header("Access-Control-Allow-Methods","GET, POST, PUT, DELETE, OPTIONS, HEAD")
                .entity(gson.toJson(df.getAllPersons())).build();
    }
 ``` 

### Fix dependencies i pom-file
Use these dependencies instead of jersey-bundle (if the above doesn't work). This will probably not be necessary.
 ```xml
 <dependency>
    <groupId>org.glassfish.jersey.containers</groupId>
    <artifactId>jersey-container-servlet</artifactId>
    <version>2.26</version>
</dependency>
<dependency>
    <groupId>org.glassfish.jersey.inject</groupId>
    <artifactId>jersey-hk2</artifactId>
    <version>2.26</version>
</dependency>
