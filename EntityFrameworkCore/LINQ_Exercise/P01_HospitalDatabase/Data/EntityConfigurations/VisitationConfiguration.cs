using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using P01_HospitalDatabase.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P01_HospitalDatabase.Data.EntityConfigurations
{
    public class VisitationConfiguration : IEntityTypeConfiguration<Visitation>
    {
        public void Configure(EntityTypeBuilder<Visitation> builder)
        {
            builder.Property(v => v.Date)
                .IsRequired();

            builder.Property(v => v.Comments)
            .HasMaxLength(250)
            .IsUnicode()
            .IsRequired(false);

            builder
            .HasOne(v => v.Patient)
            .WithMany(p => p.Visitations);

            builder
            .HasOne(v => v.Doctor)
            .WithMany(d => d.Visitations);
        }
    }
}
