'use client';

import React, { useEffect, useState } from 'react';
import styles from '../styles/informeSolicitud.css';

interface Course {
    name: string;
    prof: string;
    prof_email: string;
    prof_phone: string;
    unit: string;
    contract: string;
    percentage: number;
}

interface CourseSectionData {
    code: string;
    courses: Course[];
}

const CourseSection: React.FC<CourseSectionData> = ({ code, courses }) => (
    <div className='courseSection'>
        <div className='codeRow'>código <span className='code'>{code}</span></div>
        <table className='table'>
            <thead>
                <tr>
                    <th className='header'>nombre</th>
                    <th className='header'>Prof</th>
                    <th className='header'>Email</th>
                    <th className='header'>Teléfono</th>
                    <th className='header'>unidad</th>
                    <th className='header'>contrato</th>
                    <th className='header'>%</th>
                </tr>
            </thead>
            <tbody>
                {courses.map((course, index) => (
                    <tr key={index}>
                        <td className='cell'>{course.name}</td>
                        <td className='cell'>{course.prof}</td>
                        <td className='cell'>{course.prof_email}</td>
                        <td className='cell'>{course.prof_phone}</td>
                        <td className='cell'>{course.unit}</td>
                        <td className='cell'>{course.contract}</td>
                        <td className='cell'>{course.percentage}</td>
                    </tr>
                ))}
            </tbody>
        </table>
    </div>
);

const InformeSolicitud: React.FC = () => {
    const [coursesData, setCoursesData] = useState<CourseSectionData[]>([]);

    useEffect(() => {
        const fetchCourses = async () => {
            try {
                const res = await fetch('/api/getCourses');
                const data: { code: string; name: string; prof: string; prof_email: string; prof_phone: string; unit: string; contract: string; percentage: number }[] = await res.json();

                // Agrupar los cursos por código
                const groupedCourses: Record<string, CourseSectionData> = {};
                data.forEach((course) => {
                    const { code, ...courseData } = course;
                    if (!groupedCourses[code]) groupedCourses[code] = { code, courses: [] };
                    groupedCourses[code].courses.push(courseData);
                });

                setCoursesData(Object.values(groupedCourses));
            } catch (error) {
                console.error('Error al obtener datos de cursos:', error);
            }
        };

        fetchCourses();
    }, []);

    const handleGeneratePDF = async () => {
        const res = await fetch('/api/generatePDF', {
            method: 'POST',
        });

        if (res.ok) {
            const blob = await res.blob();
            const url = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', 'cursos.pdf');
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        } else {
            console.error('Error al generar el PDF.');
        }
    };

    return (
        <div className='container'>
            {coursesData.map((section, index) => (
                <CourseSection key={index} code={section.code} courses={section.courses} />
            ))}
            <button onClick={handleGeneratePDF} className={styles.button}>Generar PDF</button>
        </div>
    );
};

export default InformeSolicitud;
