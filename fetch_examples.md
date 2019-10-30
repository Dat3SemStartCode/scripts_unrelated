# Examples of using fetch and promises:

## Fetch with GET
Using the fetch method returns a promise. A promise has a then method that takes a callback as argument.
The callback function will be called when the promise is resolved (the asyncronous function call returns a value):

```js
const promise1 = fetch('https://swapi.co/api/people/2');
const promise2 = promise1.then(function(response) {
   return response.json();
 })
promise2.then(function(data) {
   console.log(data.name);
});
```

The same code as above can be written with method chaining:
```js
fetch('https://swapi.co/api/people/1')
 .then(function(response) {
   return response.json();
 })
 .then(function(data) {
   console.log(data.name);
});
```
This is because the then() method returns a new promise (that has a then() method whenever the then() method has a return statement (like the first one does.))

## Fetch with POST, PUT, DELETE
Using POST and PUT we have data to send to the server to change the application state on the server.
POST is for creating new entity
PUT is for updating an existing entity

#### POST code example
```js 
let options = {
   method: "POST",
   headers: {
   'Accept': 'application/json',
   'Content-Type': 'application/json'
   },
   body: JSON.stringify({
     name: "liz Willson",
     age: 34,
     gender: "female",
     email: "lizabeth@mail.com"
   })
}

fetch("http://localhost:8080/myapp/api/user",options);
```
Above we are using a configuration object containing HTTP method (POST), Header object and data as body to the POST request made into a text string.

#### PUT code example
```js
let options = {
   method: "PUT",
   headers: {
   'Accept': 'application/json',
   'Content-Type': 'application/json'
   },
   body: JSON.stringify({
     name: "liz Williamson",
     age: 34,
     gender: "female",
     email: "lizabeth@mail.com"
   })
}

fetch("http://localhost:8080/myapp/api/user/102",options);

```
Above code shows how we update user 102 to change her last name to Williamson

Both the POST and the PUT method can return data. In that case we handle this with then() methods in the same way as with a GET request.

#### DELETE code example
```js
let options = {
   method: "DELETE",
   headers: {
   'Content-Type': 'application/json'
   }
}

fetch("http://localhost:8080/myapp/api/user/102",options);

```
Above code send a delete request to the server to delete user number 102 (Liz Williamson)

## Error handling
With fetch we need to reject the promise from the fetch call if http status code is above 400.
A helper method to do this:
```js
function fetchWithErrorCheck(res){
 if(!res.ok){
   return Promise.reject({status: res.status, fullError: res.json() })
 }
 return res.json();
}

fetch('https://swapi.co/api/people/999999999999')
 .then(res => fetchWithErrorCheck(res))
 .then(data => console.log(data.name))
 .catch(err => {
    if(err.status){
      err.fullError.then(e=> console.log(e.detail))
    }
    else{console.log("Network error"); }
 });

```
Above code uses the .catch method to execute when a promise was rejected (eg. the http response came back with a http status code of 400 or above. (some error happend))

## Utility methods for POST, PUT, DELETE requests
```js

function makeOptions(http_method, body) {
 var options =  {
   method: http_method,
   headers: {
     "Content-type": "application/json"
   }
 }
 if(body){
   options.body = JSON.stringify(body);
 }
 return options;
}
```
Above function can be used to make fetch calls like:
```js
const data = {age: 34,name: "liz Wilson", gender: "female",email: "liz@mail.com"};
const options = makeOptions("POST", data);

fetch("http://localhost:8080/myapp/api/user",options);
```
Or with PUT:
```js
const options = makeOptions("PUT", data);
fetch("http://localhost:8080/myapp/api/user/102",options);
```
Or DELETE:
```js
const options = makeOptions("DELETE");
fetch("http://localhost:8080/myapp/api/user/102",options);
```
