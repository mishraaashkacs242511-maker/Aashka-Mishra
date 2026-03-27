import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class StudentService {
  // ✅ Pointing to your live Render backend
  private apiUrl = 'https://hostel-backend-e2si.onrender.com/api/students';

  constructor(private http: HttpClient) {}

  getStudents() {
    return this.http.get<any[]>(this.apiUrl);
  }

  addStudent(data: any) {
    return this.http.post(this.apiUrl, data);
  }

  updateStudent(id: string, data: any) {
    return this.http.put(`${this.apiUrl}/${id}`, data);
  }

  deleteStudent(id: string) {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }
}