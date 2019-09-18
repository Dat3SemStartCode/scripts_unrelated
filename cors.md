# setup cors headers in rest project
Use these dependencies instead of jersey-bundle
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
 
 ```
 create a java class:
 ```java
@PreMatching
@Provider
public class CorsFilter implements ContainerResponseFilter {
  @Override
  public void filter( ContainerRequestContext requestCtx, ContainerResponseContext res )
    throws IOException {
    res.getHeaders().add("Access-Control-Allow-Origin", "*" );
    res.getHeaders().add("Access-Control-Allow-Credentials", "true" );
    res.getHeaders().add("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT" );
    res.getHeaders().add("Access-Control-Allow-Headers", "Origin, Accept, Content-Type, Authorization,x-access-token");
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