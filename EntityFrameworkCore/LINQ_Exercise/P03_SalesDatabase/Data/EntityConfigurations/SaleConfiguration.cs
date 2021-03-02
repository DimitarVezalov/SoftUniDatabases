using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using P03_SalesDatabase.Data.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace P03_SalesDatabase.Data.EntityConfigurations
{
    public class SaleConfiguration : IEntityTypeConfiguration<Sale>
    {
        public void Configure(EntityTypeBuilder<Sale> builder)
        {
            builder.HasOne(s => s.Customer)
                .WithMany(c => c.Sales);

            builder.HasOne(s => s.Product)
                .WithMany(p => p.Sales);

            builder.HasOne(s => s.Store)
                .WithMany(st => st.Sales);

            builder.Property(s => s.Date)
                .HasDefaultValueSql("GETDATE()");
        }
    }
}
