// pages/api/getCourses.ts
import { NextResponse } from 'next/server';
import { Pool } from 'pg';

const pool = new Pool({
    user: "postgres",
    host: "db",
    database: "soft-tech",
    password: "jera123",
    port: 5432,
});
export async function GET() {
    try {
        const result = await pool.query(`
            SELECT 
                cr."group",
                s.school_name,
                c.course_name AS name,
                c.credits,
                c.semester_id,
                c.code,
                t.teacher_id,
                CONCAT(t.first_name, ' ', t.last_name) AS prof,
                t.email AS prof_email,
                t.phone_number AS prof_phone,
                t.contract
            FROM 
                course_requests cr
            INNER JOIN 
                courses c ON cr.course_id = c.course_id
            INNER JOIN 
                schools s ON cr.school_id = s.school_id
            INNER JOIN 
                teachers t ON t.teacher_id = t.teacher_id;
        `);

        return NextResponse.json(result.rows);
    } catch (error) {
        console.error('Error fetching courses:', error);
        return NextResponse.json({ error: 'Error fetching courses' }, { status: 500 });
    }
}
