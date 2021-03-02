using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using P01_HospitalDatabase.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P01_HospitalDatabase.Data.EntityConfigurations
{
    public class DoctorConfiguration : IEntityTypeConfiguration<Doctor>
    {
        public void Configure(EntityTypeBuilder<Doctor> builder)
        {
            builder.Property(d => d.Name)
            .IsRequired()
            .HasMaxLength(100)
            .IsUnicode();

            builder.Property(d => d.Specialty)
           .IsRequired()
           .HasMaxLength(100)
           .IsUnicode();
        }
    }
}
