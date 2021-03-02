using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using P01_HospitalDatabase.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P01_HospitalDatabase.Data.EntityConfigurations
{
    public class PatientMedicamentConfiguration : IEntityTypeConfiguration<PatientMedicament>
    {
        public void Configure(EntityTypeBuilder<PatientMedicament> builder)
        {
            builder.HasOne(e => e.Patient)
                 .WithMany(p => p.Prescriptions);

            builder.HasOne(e => e.Medicament)
            .WithMany(m => m.Prescriptions);

            builder.HasKey(e => new { e.PatientId, e.MedicamentId });
        }
    }
}
