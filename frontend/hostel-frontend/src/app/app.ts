import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { StudentService } from './student.service';

/* ✅ INTERFACES */
interface Student { _id?: string; name: string; email: string; phone: string; course: string; roomNumber: string; feeStatus: 'Paid' | 'Pending'; present?: boolean; }
interface Complaint { id: number; studentName: string; issue: string; status: 'Pending' | 'Resolved'; date: string; }
interface Visitor { name: string; studentToVisit: string; timeIn: string; date: string; }
interface FoodItem { name: string; price: number; category: string; }
interface Sport { game: string; student: string; time: string; status: 'Active' | 'Completed'; }
interface Book { title: string; borrower: string; issueDate: string; dueDate: string; returned: boolean; }
interface EventItem { name: string; date: string; type: 'Social' | 'Academic' | 'Maintenance'; }

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
<div [class.dark-theme]="isDarkMode" class="theme-wrapper">
  
  <div *ngIf="!loggedIn" class="login-container">
    <div class="login-card">
      <div class="login-header">
        <div class="logo-circle">🏨</div>
        <h2>Hostel Pro</h2>
        <p class="sub">Management Portal v2.0</p>
      </div>
      
      <div class="login-body">
        <div class="input-group-modern">
          <label>Admin Username</label>
          <input type="text" placeholder="Enter username" [(ngModel)]="username">
        </div>
        <div class="input-group-modern">
          <label>Password</label>
          <input type="password" placeholder="••••••••" [(ngModel)]="password">
        </div>
        <button class="pretty-login-btn" (click)="login()">Sign In</button>
      </div>
      
      <div class="login-footer">
        <small>System Security Enabled</small>
      </div>
    </div>
  </div>

  <div *ngIf="loggedIn" class="app">
    <nav class="sidebar">
      <div class="sidebar-top">
        <div class="sidebar-header">
          <span class="logo">🏨 HostelPro</span>
        </div>
        <div class="nav-links">
          <button [class.active]="page=='dashboard'" (click)="page='dashboard'">
            <span class="icon-span">📊</span> <span>Dashboard</span>
          </button>
          <button [class.active]="page=='students'" (click)="page='students'">
            <span class="icon-span">👨‍🎓</span> <span>Students</span>
          </button>
          <button [class.active]="page=='rooms'" (click)="page='rooms'">
            <span class="icon-span">🔑</span> <span>Rooms</span>
          </button>
          <button [class.active]="page=='attendance'" (click)="page='attendance'">
            <span class="icon-span">📝</span> <span>Attendance</span>
          </button>
          <button [class.active]="page=='complaints'" (click)="page='complaints'">
            <span class="icon-span">🔧</span> <span>Complaints</span>
          </button>
          <button [class.active]="page=='visitors'" (click)="page='visitors'">
            <span class="icon-span">👥</span> <span>Visitors</span>
          </button>
          <button [class.active]="page=='canteen'" (click)="page='canteen'">
            <span class="icon-span">🍕</span> <span>Canteen</span>
          </button>
          <button [class.active]="page=='sports'" (click)="page='sports'">
            <span class="icon-span">⚽</span> <span>Sports</span>
          </button>
          <button [class.active]="page=='library'" (click)="page='library'">
            <span class="icon-span">📚</span> <span>Library</span>
          </button>
          <button [class.active]="page=='schedule'" (click)="page='schedule'">
            <span class="icon-span">📅</span> <span>Events</span>
          </button>
        </div>
      </div>
      
      <div class="sidebar-footer">
        <button class="theme-toggle" (click)="toggleDarkMode()">
          {{isDarkMode ? '☀️ Switch to Light' : '🌙 Switch to Dark'}}
        </button>
        <button class="logout-btn" (click)="logout()">Logout</button>
      </div>
    </nav>

    <main class="content">
      <header class="main-header">
        <div class="title-area">
          <h1>{{page | titlecase}}</h1>
          <p class="date-now">{{today | date:'fullDate'}}</p>
        </div>
        <div class="header-tools">
          <input type="text" [(ngModel)]="searchTerm" placeholder="Search..." class="search-bar">
          <div class="user-profile">Admin</div>
        </div>
      </header>

      <div *ngIf="page=='dashboard'" class="fade-in">
        <div class="stats-grid">
          <div class="stat-card blue">
            <span class="icon">👥</span>
            <div class="stat-content"><h4>Total Students</h4><p>{{students.length}}</p></div>
          </div>
          <div class="stat-card green">
            <span class="icon">🏠</span>
            <div class="stat-content"><h4>Occupied</h4><p>{{occupiedRoomsCount}} / {{totalRooms}}</p></div>
          </div>
          <div class="stat-card orange">
            <span class="icon">💰</span>
            <div class="stat-content"><h4>Unpaid Fees</h4><p>{{pendingCount}}</p></div>
          </div>
          <div class="stat-card red">
            <span class="icon">⚠️</span>
            <div class="stat-content"><h4>Active Issues</h4><p>{{openComplaintsCount}}</p></div>
          </div>
        </div>

        <div class="dashboard-details">
          <div class="section-card">
            <h3>Fee Collection Overview</h3>
            <div class="progress-container">
              <div class="progress-bar"><div class="progress" [style.width]="paidPercent+'%'"></div></div>
              <span class="muted-text"><strong>{{paidPercent | number:'1.0-0'}}%</strong> Collected</span>
            </div>
          </div>
          <div class="section-card">
            <h3>Live Status</h3>
            <div class="mini-list">
              <p>⚽ Active Sports: <strong>{{activeSportsCount}}</strong></p>
              <p>📚 Overdue Books: <strong>{{overdueBooksCount}}</strong></p>
            </div>
          </div>
        </div>
      </div>

      <div *ngIf="page=='students'" class="section-card fade-in">
        <div class="form-row">
          <div class="input-field">
            <label>Name</label>
            <input placeholder="Student Name" [(ngModel)]="student.name">
          </div>
          <div class="input-field">
            <label>Room #</label>
            <input placeholder="e.g. 101" [(ngModel)]="student.roomNumber">
          </div>
          <div class="input-field">
            <label>Fee Status</label>
            <select [(ngModel)]="student.feeStatus">
              <option value="Paid">Paid</option>
              <option value="Pending">Pending</option>
            </select>
          </div>
          <button (click)="editMode ? updateStudent() : addStudent()" class="primary-btn">
            {{editMode ? 'Update' : 'Add Student'}}
          </button>
        </div>

        <div class="table-container">
          <table class="modern-table">
            <thead><tr><th>Name</th><th>Room</th><th>Fee Status</th><th>Actions</th></tr></thead>
            <tbody>
              <tr *ngFor="let s of filteredStudents">
                <td><strong>{{s.name}}</strong></td>
                <td>{{s.roomNumber}}</td>
                <td><span [class]="'badge ' + s.feeStatus.toLowerCase()">{{s.feeStatus}}</span></td>
                <td>
                  <button class="btn-icon" (click)="editStudent(s)">✏️</button>
                  <button class="btn-icon red" (click)="deleteStudent(s._id!)">🗑️</button>
                </td>
              </tr>
              <tr *ngIf="filteredStudents.length === 0"><td colspan="4" class="empty-state">No students found.</td></tr>
            </tbody>
          </table>
        </div>
      </div>

      <div *ngIf="page=='rooms'" class="fade-in">
        <div class="room-stats-summary section-card">
          <p>Displaying <strong>{{roomList.length}}</strong> total rooms. Rooms in <span class="indicator-blue">Blue</span> are occupied.</p>
        </div>
        <div class="room-grid">
          <div *ngFor="let room of roomList" class="room-card" [class.is-occupied]="isRoomOccupied(room)">
            <div class="room-num">{{room}}</div>
            <div class="room-info">
               <div *ngIf="isRoomOccupied(room)">
                  <span *ngFor="let name of getStudentsInRoom(room)" class="occ-tag">{{name}}</span>
               </div>
               <span *ngIf="!isRoomOccupied(room)" class="vacant-text">Vacant</span>
            </div>
          </div>
        </div>
      </div>

      <div *ngIf="page=='attendance'" class="section-card fade-in">
        <h3>Nightly Roll Call</h3>
        <table class="modern-table">
          <thead><tr><th>Student</th><th>Room</th><th>Status</th></tr></thead>
          <tbody>
            <tr *ngFor="let s of students">
              <td>{{s.name}}</td><td>{{s.roomNumber}}</td>
              <td>
                <label class="attendance-check">
                  <input type="checkbox" [(ngModel)]="s.present">
                  <span class="status-pill" [class.present]="s.present">{{s.present ? 'Present' : 'Absent'}}</span>
                </label>
              </td>
            </tr>
          </tbody>
        </table>
        <button (click)="saveAttendance()" class="primary-btn mt-20">Save Attendance</button>
      </div>

      <div *ngIf="page=='canteen'" class="canteen-layout fade-in">
        <div class="menu-section">
          <div class="section-card">
            <h3>Menu</h3>
            <div class="food-grid">
              <div *ngFor="let item of foodMenu" class="food-item" (click)="addToBill(item)">
                <span>{{item.name}}</span>
                <strong>₹{{item.price}}</strong>
              </div>
            </div>
          </div>
        </div>
        <div class="bill-section">
          <div class="section-card">
            <h3>Current Bill</h3>
            <div class="bill-list">
              <div *ngFor="let b of currentBill; let i = index" class="bill-item">
                <span class="bill-text">{{b.name}}</span>
                <span class="bill-text">₹{{b.price}} <button (click)="removeFromBill(i)">×</button></span>
              </div>
            </div>
            <div class="bill-footer">
              <div class="total">Total: ₹{{billTotal}}</div>
              <button class="checkout-btn" [disabled]="!currentBill.length" (click)="checkoutBill()">Checkout</button>
            </div>
          </div>
        </div>
      </div>

      <div *ngIf="page=='complaints'" class="section-card fade-in">
        <div class="form-row">
          <div class="input-field">
            <label>Student Name</label>
            <input placeholder="Student Name" [(ngModel)]="newComplaint.studentName">
          </div>
          <div class="input-field" style="flex: 2">
            <label>Describe issue</label>
            <input placeholder="Issue description" [(ngModel)]="newComplaint.issue">
          </div>
          <button (click)="addComplaint()" class="primary-btn">Report</button>
        </div>
        <table class="modern-table">
          <thead><tr><th>Student</th><th>Issue</th><th>Status</th><th>Action</th></tr></thead>
          <tbody>
            <tr *ngFor="let c of complaints">
              <td>{{c.studentName}}</td><td>{{c.issue}}</td>
              <td><span [class]="'badge ' + c.status.toLowerCase()">{{c.status}}</span></td>
              <td><button *ngIf="c.status=='Pending'" (click)="resolveComplaint(c)" class="action-btn">Resolve</button></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div *ngIf="page=='visitors'" class="section-card fade-in">
        <div class="form-row">
          <div class="input-field">
            <label>Visitor Name</label>
            <input placeholder="Visitor Name" [(ngModel)]="newVisitor.name">
          </div>
          <div class="input-field">
            <label>Visiting Student</label>
            <input placeholder="Visiting Student" [(ngModel)]="newVisitor.studentToVisit">
          </div>
          <button (click)="addVisitor()" class="primary-btn">Log Entry</button>
        </div>
        <table class="modern-table">
          <thead><tr><th>Visitor</th><th>Visiting Student</th><th>Time</th><th>Date</th></tr></thead>
          <tbody>
            <tr *ngFor="let v of visitors">
              <td>{{v.name}}</td><td>{{v.studentToVisit}}</td><td>{{v.timeIn}}</td><td>{{v.date}}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div *ngIf="page=='sports'" class="section-card fade-in">
        <div class="form-row">
          <div class="input-field">
            <label>Game</label>
            <select [(ngModel)]="newSport.game"><option value="">Select Game</option><option *ngFor="let g of availableGames">{{g}}</option></select>
          </div>
          <div class="input-field">
            <label>Student Name</label>
            <input placeholder="Student Name" [(ngModel)]="newSport.student">
          </div>
          <button (click)="bookSport()" class="primary-btn">Book Slot</button>
        </div>
        <table class="modern-table">
          <thead><tr><th>Game</th><th>Student</th><th>Status</th></tr></thead>
          <tbody>
            <tr *ngFor="let s of sportsBookings">
              <td>{{s.game}}</td><td>{{s.student}}</td>
              <td><span [class]="'badge ' + s.status.toLowerCase()">{{s.status}}</span></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div *ngIf="page=='library'" class="section-card fade-in">
        <div class="form-row">
          <div class="input-field">
            <label>Book Title</label>
            <input placeholder="Book Title" [(ngModel)]="newBook.title">
          </div>
          <div class="input-field">
            <label>Borrower</label>
            <input placeholder="Borrower" [(ngModel)]="newBook.borrower">
          </div>
          <div class="input-field">
            <label>Due Date</label>
            <input type="date" [(ngModel)]="newBook.dueDate">
          </div>
          <button (click)="issueBook()" class="primary-btn">Issue</button>
        </div>
        <table class="modern-table">
          <thead><tr><th>Book</th><th>Borrower</th><th>Due Date</th><th>Status</th></tr></thead>
          <tbody>
            <tr *ngFor="let b of libraryBooks">
              <td>{{b.title}}</td><td>{{b.borrower}}</td><td>{{b.dueDate | date}}</td>
              <td><span [class]="isBookOverdue(b.dueDate) ? 'red-txt' : 'green-txt'">{{isBookOverdue(b.dueDate) ? 'Overdue' : 'Issued'}}</span></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div *ngIf="page=='schedule'" class="section-card fade-in">
        <div class="form-row">
          <div class="input-field">
            <label>Event Name</label>
            <input placeholder="Event Name" [(ngModel)]="newEvent.name">
          </div>
          <div class="input-field">
            <label>Date</label>
            <input type="date" [(ngModel)]="newEvent.date">
          </div>
          <button (click)="addEvent()" class="primary-btn">Add Event</button>
        </div>
        <div class="timeline">
          <div *ngFor="let e of events" class="timeline-item section-card">
            <div class="t-date">{{e.date | date:'MMM dd'}}</div>
            <div class="t-info"><strong>{{e.name}}</strong> <small>{{e.type}}</small></div>
            <button (click)="deleteEvent(e)" class="del-icon">×</button>
          </div>
        </div>
      </div>

    </main>
  </div>
</div>
`,
  styles: [`
    /* ✅ CORE THEME SETTINGS (Balanced Contrast) */
    :root {
      --primary: #4f46e5;
      --bg-page: #f1f5f9;       
      --bg-card: #ffffff;
      --text-main: #0f172a;     
      --text-muted: #334155;
      --border: #cbd5e1;        
      --sidebar-bg: #ffffff;
      --sidebar-txt: #1e293b;
      --sidebar-border: #e2e8f0;
    }

    .dark-theme {
      --primary: #818cf8;
      --bg-page: #020617;       
      --bg-card: #0f172a;       
      --text-main: #f8fafc;     
      --text-muted: #94a3b8;
      --border: #334155;
      --sidebar-bg: #0f172a;
      --sidebar-txt: #cbd5e1;
      --sidebar-border: #1e293b;
    }

    html, body { margin: 0; padding: 0; height: 100%; overflow: hidden; }
    * { box-sizing: border-box; transition: background 0.3s; }
    body { font-family: 'Inter', system-ui, sans-serif; background: var(--bg-page); color: var(--text-main); }
    .theme-wrapper { height: 100vh; width: 100vw; background: var(--bg-page); overflow: hidden; }

    /* ✅ PRETTY LOGIN */
    .login-container { 
      height: 100vh; width: 100vw; display: flex; align-items: center; justify-content: center; 
      background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%); 
      position: fixed; top: 0; left: 0; z-index: 2000;
    }
    .login-card { 
      background: #ffffff; padding: 50px 40px; border-radius: 32px; width: 440px; 
      box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5); text-align: center;
      display: flex; flex-direction: column; align-items: center;
      animation: loginFadeUp 0.8s cubic-bezier(0.23, 1, 0.32, 1);
    }
    @keyframes loginFadeUp { from { opacity: 0; transform: translateY(40px); } to { opacity: 1; transform: translateY(0); } }
    .logo-circle { font-size: 3.5rem; margin-bottom: 12px; }
    .login-header h2 { margin: 0; color: #1e293b; font-size: 2.2rem; font-weight: 900; }
    .login-header p.sub { color: #64748b; margin: 8px 0 35px 0; font-weight: 600; }
    .login-body { width: 100%; }
    .login-body .input-group-modern { margin-bottom: 24px; text-align: left; width: 100%; }
    .login-body label { font-weight: 800; color: #475569; display: block; margin-bottom: 10px; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; }
    .login-body input { width: 100%; padding: 16px; border-radius: 16px; border: 2px solid #e2e8f0; font-weight: 700; color: #1e293b; outline: none; background: #f8fafc; }
    .pretty-login-btn { width: 100%; background: #4f46e5; color: #ffffff; padding: 18px; border: none; border-radius: 16px; font-weight: 900; font-size: 1.1rem; cursor: pointer; transition: all 0.3s; box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.3); }

    /* ✅ SIDEBAR (ANCHORED & FIT) */
    .app { display: flex; height: 100vh; width: 100vw; overflow: hidden; }
    .sidebar { 
      width: 260px; min-width: 260px; background: var(--sidebar-bg); 
      border-right: 2px solid var(--sidebar-border); 
      display: flex; flex-direction: column; height: 100vh; z-index: 100;
    }
    .sidebar-top { flex: 1; overflow-y: auto; padding: 24px; }
    .logo { font-size: 1.4rem; font-weight: 900; color: var(--primary); margin-bottom: 30px; display: block; }
    .nav-links { display: flex; flex-direction: column; gap: 8px; }
    .nav-links button { background: transparent; color: var(--sidebar-txt) !important; border: none; padding: 12px 16px; text-align: left; border-radius: 10px; cursor: pointer; font-weight: 800; font-size: 1rem; display: flex; align-items: center; gap: 14px; transition: 0.2s; }
    .icon-span { display: inline-flex; align-items: center; justify-content: center; width: 24px; }
    .nav-links button.active { background-color: var(--primary) !important; color: #ffffff !important; box-shadow: 0 4px 12px rgba(79, 70, 229, 0.4); }
    .sidebar-footer { padding: 24px; border-top: 2px solid var(--sidebar-border); display: flex; flex-direction: column; gap: 10px; }
    .theme-toggle { background: var(--bg-page); color: var(--text-main); border: 2px solid var(--border); padding: 12px; border-radius: 10px; cursor: pointer; font-weight: 800; }
    .logout-btn { background: #dc2626; color: white; border: none; padding: 14px; border-radius: 10px; cursor: pointer; font-weight: 900; width: 100%; }

    /* ✅ CONTENT (INDEPENDENT SCROLL) */
    .content { flex: 1; height: 100vh; overflow-y: auto; padding: 40px; position: relative; }
    .main-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 40px; border-bottom: 3px solid var(--border); padding-bottom: 15px; }
    .main-header h1 { margin: 0; font-size: 2.6rem; font-weight: 900; color: var(--text-main); }
    .date-now { color: var(--text-muted); font-weight: 800; margin-top: 5px; }
    .search-bar { padding: 14px 20px; border-radius: 14px; border: 2.5px solid var(--border); background: var(--bg-card); color: var(--text-main); width: 320px; font-weight: 800; }

    /* ✅ VISIBILITY OVERRIDES FOR DARK MODE */
    .stats-grid .stat-card p, .stats-grid .stat-card h4, .vacant-text { color: #ffffff !important; }
    .mini-list p, .mini-list strong, .room-stats-summary p, .room-card .room-num, .bill-text, .muted-text, .section-card h3 { color: var(--text-main) !important; font-weight: 900 !important; }

    /* Cards & Form Alignment */
    .section-card { background: var(--bg-card); border-radius: 24px; padding: 30px; border: 2px solid var(--border); box-shadow: 6px 6px 0px rgba(0,0,0,0.1); margin-bottom: 30px; }
    .form-row { display: flex; gap: 20px; margin-bottom: 30px; flex-wrap: wrap; align-items: flex-end; }
    .input-field { display: flex; flex-direction: column; gap: 8px; }
    .form-row input, .form-row select { padding: 14px 18px; border-radius: 12px; border: 2.5px solid var(--border) !important; background: #ffffff !important; color: #000000 !important; font-weight: 800; min-width: 220px; }
    .primary-btn { background-color: #4f46e5 !important; color: #ffffff !important; border: 2px solid #1e293b; padding: 14px 30px; border-radius: 12px; cursor: pointer; font-weight: 900; box-shadow: 4px 4px 0px #1e293b; height: 51px; display: inline-flex; align-items: center; justify-content: center; }

    /* Stats Grid */
    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 24px; margin-bottom: 30px; }
    .stat-card { padding: 24px; border-radius: 20px; color: white; display: flex; align-items: center; gap: 20px; border: 2.5px solid #1e293b; box-shadow: 6px 6px 0px #1e293b; }
    .blue { background: #4f46e5; } .green { background: #059669; } .orange { background: #d97706; } .red { background: #dc2626; }

    /* Rooms Grid */
    .room-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 20px; }
    .room-card { background: var(--bg-card); border: 2.5px solid var(--border); border-radius: 20px; padding: 25px; text-align: center; box-shadow: 4px 4px 0px var(--border); min-height: 140px; display: flex; flex-direction: column; justify-content: center; }
    .room-card.is-occupied { border-color: var(--primary); background: rgba(79, 70, 229, 0.05); box-shadow: 4px 4px 0px var(--primary); }
    .occ-tag { background: var(--primary); color: white; font-size: 0.75rem; padding: 3px 10px; border-radius: 6px; display: inline-block; margin: 3px; font-weight: 800; }

    /* ✅ REVERTED CANTEEN STYLES */
    .canteen-layout { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
    .food-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 15px; }
    .food-item { background: var(--bg-card); border: 2px solid var(--border); padding: 15px; border-radius: 12px; cursor: pointer; text-align: center; display: flex; flex-direction: column; gap: 5px; box-shadow: 3px 3px 0px var(--border); color: var(--text-main); }
    .food-item span { font-weight: 800; }
    .food-item strong { color: var(--primary); }
    .bill-list { display: flex; flex-direction: column; gap: 10px; margin-bottom: 20px; }
    .bill-item { display: flex; justify-content: space-between; padding: 10px; border-bottom: 1.5px solid var(--border); }
    .bill-footer .total { font-size: 1.5rem; font-weight: 900; margin-bottom: 15px; color: var(--text-main); }
    .checkout-btn { width: 100%; background: var(--primary); color: white; border: 2px solid var(--border); padding: 15px; border-radius: 12px; font-weight: 900; box-shadow: 4px 4px 0px var(--border); cursor: pointer; }

    /* Tables */
    .modern-table { width: 100%; border-collapse: collapse; }
    .modern-table th { text-align: left; padding: 14px; color: var(--text-main); border-bottom: 4px solid var(--border); font-size: 0.9rem; font-weight: 900; text-transform: uppercase; background: rgba(0,0,0,0.02); }
    .modern-table td { padding: 18px 14px; border-bottom: 2px solid var(--border); color: var(--text-main); font-weight: 800; }
    .status-pill { padding: 8px 16px; border-radius: 20px; font-size: 0.9rem; font-weight: 900; background: #fee2e2; color: #991b1b; border: 2px solid #991b1b; }
    .status-pill.present { background: #dcfce7; color: #166534; border: 2px solid #166534; }

    .fade-in { animation: fadeIn 0.4s ease-out; }
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  `]
})
export class App implements OnInit {
  constructor(private studentService: StudentService) {}

  username = ""; password = ""; loggedIn = false;
  page = "dashboard"; isDarkMode = false; searchTerm = "";
  today = new Date(); totalRooms = 30;

  students: Student[] = [];
  student: Student = { name: '', roomNumber: '', feeStatus: 'Pending', email: '', phone: '', course: '' };
  editMode = false; editId = "";
  roomList = Array.from({length: 30}, (_, i) => (101 + i).toString());

  complaints: Complaint[] = [];
  newComplaint: any = { studentName: '', issue: '' };

  visitors: Visitor[] = [];
  newVisitor: any = { name: '', studentToVisit: '' };

  foodMenu: FoodItem[] = [
    { name: 'Tea', price: 10, category: 'Drink' }, { name: 'Coffee', price: 20, category: 'Drink' },
    { name: 'Samosa', price: 15, category: 'Snack' }, { name: 'Maggi', price: 40, category: 'Meal' },
    { name: 'Thali', price: 90, category: 'Meal' }, { name: 'Bread Omelette', price: 35, category: 'Snack' }
  ];
  currentBill: FoodItem[] = []; billTotal = 0;

  availableGames = ['Cricket', 'Gym', 'Table Tennis', 'Badminton'];
  timeSlots = ['6AM-7AM', '7AM-8AM', '5PM-6PM', '6PM-7PM'];
  sportsBookings: Sport[] = [];
  newSport: any = { game: '', student: '', time: '' };
  sportError = "";

  libraryBooks: Book[] = [];
  newBook: any = { title: '', borrower: '', dueDate: '' };

  events: EventItem[] = [];
  newEvent: any = { name: '', date: '', type: 'Social' };

  ngOnInit() {
    this.isDarkMode = localStorage.getItem('darkMode') === 'true';
    if (localStorage.getItem('isLoggedIn') === 'true') {
      this.loggedIn = true;
      this.loadAllData();
    }
  }

  get filteredStudents() {
    return this.students.filter(s => 
      s.name.toLowerCase().includes(this.searchTerm.toLowerCase()) || 
      s.roomNumber.toString().includes(this.searchTerm)
    );
  }
  get occupiedRoomsCount() { 
    return new Set(this.students.map(s => s.roomNumber.toString().trim())).size; 
  }
  get pendingCount() { return this.students.filter(s => s.feeStatus === 'Pending').length; }
  get openComplaintsCount() { return this.complaints.filter(c => c.status === 'Pending').length; }
  get paidPercent() { return this.students.length ? (this.students.filter(s => s.feeStatus === "Paid").length / this.students.length) * 100 : 0; }
  get activeSportsCount() { return this.sportsBookings.filter(s => s.status === 'Active').length; }
  get overdueBooksCount() { return this.libraryBooks.filter(b => !b.returned && this.isBookOverdue(b.dueDate)).length; }

  isRoomOccupied(room: string): boolean { 
    return this.students.some(s => s.roomNumber?.toString().trim() === room.trim()); 
  }

  getStudentsInRoom(room: string): string[] { 
    return this.students
      .filter(s => s.roomNumber?.toString().trim() === room.trim())
      .map(s => s.name);
  }

  login() {
    if (this.username === "admin" && this.password === "admin") {
      this.loggedIn = true;
      localStorage.setItem('isLoggedIn', 'true');
      this.loadAllData();
    } else {
      alert("Invalid Credentials");
    }
  }
  logout() { this.loggedIn = false; localStorage.removeItem('isLoggedIn'); }
  toggleDarkMode() { 
    this.isDarkMode = !this.isDarkMode; 
    localStorage.setItem('darkMode', this.isDarkMode.toString()); 
  }

  loadAllData() {
    this.studentService.getStudents().subscribe((data: any) => {
      this.students = data.map((s: any) => ({
        ...s,
        roomNumber: s.roomNumber?.toString().trim() || ""
      }));
    });
    this.complaints = JSON.parse(localStorage.getItem('complaints') || '[]');
    this.visitors = JSON.parse(localStorage.getItem('visitors') || '[]');
    this.sportsBookings = JSON.parse(localStorage.getItem('sports') || '[]');
    this.libraryBooks = JSON.parse(localStorage.getItem('library') || '[]');
    this.events = JSON.parse(localStorage.getItem('events') || '[]');
  }

  saveLocal() {
    localStorage.setItem('complaints', JSON.stringify(this.complaints));
    localStorage.setItem('visitors', JSON.stringify(this.visitors));
    localStorage.setItem('sports', JSON.stringify(this.sportsBookings));
    localStorage.setItem('library', JSON.stringify(this.libraryBooks));
    localStorage.setItem('events', JSON.stringify(this.events));
  }

  addStudent() {
    if (!this.student.name || !this.student.roomNumber) return;
    this.student.roomNumber = this.student.roomNumber.toString().trim();
    this.studentService.addStudent(this.student).subscribe(() => {
      this.loadAllData();
      this.student = { name: '', roomNumber: '', feeStatus: 'Pending', email: '', phone: '', course: '' };
    });
  }

  editStudent(s: Student) { this.student = { ...s }; this.editMode = true; this.editId = s._id!; }
  cancelEdit() { this.editMode = false; this.student = { name: '', roomNumber: '', feeStatus: 'Pending', email: '', phone: '', course: '' }; }
  
  updateStudent() {
    this.student.roomNumber = this.student.roomNumber.toString().trim();
    this.studentService.updateStudent(this.editId, this.student).subscribe(() => {
      this.editMode = false;
      this.loadAllData();
      this.cancelEdit();
    });
  }

  deleteStudent(id: string) { if(confirm("Delete this student?")) this.studentService.deleteStudent(id).subscribe(() => this.loadAllData()); }

  addToBill(item: FoodItem) { this.currentBill.push(item); this.billTotal += item.price; }
  removeFromBill(index: number) { this.billTotal -= this.currentBill[index].price; this.currentBill.splice(index, 1); }
  clearBill() { this.currentBill = []; this.billTotal = 0; }
  checkoutBill() { alert("Transaction Success! Total: ₹" + this.billTotal); this.clearBill(); }

  addComplaint() {
    if(!this.newComplaint.issue) return;
    this.complaints.unshift({ id: Date.now(), studentName: this.newComplaint.studentName || 'Anonymous', issue: this.newComplaint.issue, status: 'Pending', date: new Date().toISOString() });
    this.saveLocal(); this.newComplaint = { studentName: '', issue: '' };
  }
  resolveComplaint(c: Complaint) { c.status = 'Resolved'; this.saveLocal(); }

  bookSport() {
    if(!this.newSport.game) return;
    this.sportsBookings.unshift({ ...this.newSport, status: 'Active', time: new Date().toLocaleTimeString() });
    this.saveLocal(); this.newSport = { game: '', student: '', time: '' };
  }

  issueBook() {
    if(!this.newBook.title) return;
    this.libraryBooks.unshift({ ...this.newBook, issueDate: new Date().toISOString(), returned: false });
    this.saveLocal(); this.newBook = { title: '', borrower: '', dueDate: '' };
  }
  isBookOverdue(date: string) { return date ? (new Date(date) < new Date()) : false; }

  saveAttendance() { alert("Attendance Saved Successfully!"); }

  addEvent() {
    if(!this.newEvent.name || !this.newEvent.date) return;
    this.events.push({ ...this.newEvent });
    this.events.sort((a,b) => new Date(a.date).getTime() - new Date(b.date).getTime());
    this.saveLocal(); this.newEvent = { name: '', date: '', type: 'Social' };
  }
  deleteEvent(e: EventItem) { this.events = this.events.filter(event => event !== e); this.saveLocal(); }

  addVisitor() {
    this.visitors.unshift({ ...this.newVisitor, timeIn: new Date().toLocaleTimeString(), date: new Date().toLocaleDateString() });
    this.saveLocal(); this.newVisitor = { name: '', studentToVisit: '' };
  }
}