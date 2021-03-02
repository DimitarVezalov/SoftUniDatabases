using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using P01_HospitalDatabase.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P01_HospitalDatabase.Data.EntityConfigurations
{
    public class PatientConfiguration : IEntityTypeConfiguration<Patient>
    {
        public void Configure(EntityTypeBuilder<Patient> builder)
        {
            builder.Property(p => p.FirstName)
                .HasMaxLength(50)
                .IsUnicode()
                .IsRequired();

            builder.Property(p => p.LastName)
            .HasMaxLength(50)
            .IsUnicode()
            .IsRequired();

            builder.Property(p => p.Address)
            .HasMaxLength(250)
            .IsUnicode()
            .IsRequired();

            builder.Property(p => p.Email)
            .HasMaxLength(80)
            .IsUnicode(false)
            .IsRequired();
        }
    }
}
