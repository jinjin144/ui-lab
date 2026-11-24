# ตรวจงานก่อนส่ง

สถานะ: เผยแพร่ GitHub แล้วตามคำสั่งผู้ใช้ https://github.com/jinjin144/ui-lab ยังไม่ได้ส่ง MyCourses

- เลือก Part 3 Robot Framework และ Part 4 Cypress
- อ่านผล Part 0 และตารางผลจริงใน `RESULTS.md` โดยเฉพาะขั้น 7 ของรันผ่านหน้าเว็บที่ไม่พบพิซซ่าใน admin
- ตรวจ `robot/results/run1/report.html` และ `robot/results/run2/report.html` พร้อมภาพใน log
- ตรวจภาพและวิดีโอใน `cypress/cypress/` และผลสองรอบใน `evidence/cypress-run1.txt` กับ `cypress-run2.txt`
- หลักฐาน intentional failure ถูกแยกจากชุดทดสอบที่แก้แล้ว และยังเก็บข้อผิดพลาดจริงไว้
- คำตอบ Part B เป็นร่างจากผลที่รันจริง ควรตรวจให้ตรงกับความเข้าใจของคุณก่อนส่ง
- เวลาที่บันทึกเป็น Asia/Bangkok (UTC+7)
- ขั้น OPTIONAL ไม่ได้ทำ และ Section 5 ใช้เป็นแนวทางสำหรับ Project 2

หลังตรวจและอนุมัติแล้ว จึงสร้าง public repository ชื่อ `ui-lab`, push โค้ดและหลักฐาน และส่งลิงก์บน MyCourses โดยตรวจ deadline ที่นั่น
