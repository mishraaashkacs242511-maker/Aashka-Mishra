import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
providedIn:'root'
})

export class StudentService{

api="http://localhost:5000/api/students";

constructor(private http:HttpClient){}

getStudents(){
return this.http.get<any[]>(this.api);
}

addStudent(data:any){
return this.http.post(this.api,data);
}

updateStudent(id:string,data:any){
return this.http.put(this.api+"/"+id,data);
}

deleteStudent(id:string){
return this.http.delete(this.api+"/"+id);
}
private apiUrl = 'https://hostel-backend-xxxx.onrender.com/api/students';
}