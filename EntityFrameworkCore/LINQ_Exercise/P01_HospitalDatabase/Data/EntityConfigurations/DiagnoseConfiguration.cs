using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using P01_HospitalDatabase.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P01_HospitalDatabase.Data.EntityConfigurations
{
    public class DiagnoseConfiguration : IEntityTypeConfiguration<Diagnose>
    {
        public void Configure(EntityTypeBuilder<Diagnose> builder)
        {
            builder.Property(d => d.Name)
                .HasMaxLength(50)
                .IsUnicode()
                .IsRequired();

            builder.Property(d => d.Comments)
            .HasMaxLength(250)
            .IsUnicode()
            .IsRequired(false);

            builder
            .HasOne(d => d.Patient)
            .WithMany(p => p.Diagnoses);
        }
    }
}
