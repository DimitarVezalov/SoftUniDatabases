using Microsoft.EntityFrameworkCore;
using P01_StudentSystem.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P01_StudentSystem.Data
{
    public class StudentSystemContext :DbContext
    {
        public StudentSystemContext()
        {

        }

        public StudentSystemContext(DbContextOptions options)
            :base(options)
        {

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=.;Database=StudentSystem;Integrated Security=true;");
            }
        }

        public DbSet<Student> Students { get; set; }
        public DbSet<Resource> Resources { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Homework> HomeworkSubmissions { get; set; }
        public DbSet<StudentCourse> StudentCourses { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Student>(entity =>
            {
                entity.Property(s => s.Name)
                .IsUnicode(true);

                entity.Property(s => s.PhoneNumber)
                .HasColumnType("CHAR(10)");

                entity.Property(s => s.Birthday)
                .IsRequired(false);
            });

            modelBuilder.Entity<Course>(entity =>
            {
                entity.Property(c => c.Name)
                .IsUnicode(true);

                entity.Property(c => c.Description)
                .IsUnicode(true);
            });

            modelBuilder.Entity<Resource>(entity =>
            {
                entity.Property(r => r.Name)
                .IsUnicode(true);

                entity.Property(r => r.Url)
                .IsUnicode(false);

                entity.HasOne(r => r.Course)
                .WithMany(c => c.Resources);
            });

            modelBuilder.Entity<Homework>(entity =>
            {
                entity.Property(h => h.Content)
                .IsUnicode(false);

                entity.HasOne(h => h.Student)
                .WithMany(s => s.HomeworkSubmissions);

                entity.HasOne(h => h.Course)
                .WithMany(c => c.HomeworkSubmissions);
            });

            modelBuilder.Entity<StudentCourse>(entity =>
            {
                entity.HasOne(sc => sc.Student)
                .WithMany(s => s.CourseEnrollments);

                entity.HasOne(sc => sc.Course)
                .WithMany(c => c.StudentsEnrolled);

                entity.HasKey(x => new { x.StudentId, x.CourseId });

            });
        }
    }
}
