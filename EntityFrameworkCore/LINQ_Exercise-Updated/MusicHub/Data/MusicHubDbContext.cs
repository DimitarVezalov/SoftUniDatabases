namespace MusicHub.Data
{
    using Microsoft.EntityFrameworkCore;
    using MusicHub.Data.Models;

    public class MusicHubDbContext : DbContext
    {
        public MusicHubDbContext()
        {
        }

        public MusicHubDbContext(DbContextOptions options)
            : base(options)
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder
                    .UseSqlServer(Configuration.ConnectionString);
            }
        }

        public DbSet<Album> Albums { get; set; }

        public DbSet<Performer> Performers { get; set; }

        public DbSet<Producer> Producers { get; set; }

        public DbSet<Song> Songs { get; set; }

        public DbSet<Writer> Writers { get; set; }

        public DbSet<SongPerformer> SongsPerformers { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Song>(entity =>
            {
                entity.Property(s => s.Name)
                .HasMaxLength(20)
                .IsRequired(true);

                entity.Property(s => s.Duration)
                .IsRequired(true);

                entity.Property(s => s.CreatedOn)
                .IsRequired(true);

                entity.Property(s => s.Genre)
                .IsRequired(true);

                entity.Property(s => s.WriterId)
                .IsRequired(true);

                entity.HasOne(s => s.Album)
                .WithMany(a => a.Songs);

                entity.HasOne(s => s.Writer)
                .WithMany(w => w.Songs);

                entity.Property(s => s.Price)
                .IsRequired(true);

            });


            builder.Entity<Album>(entity =>
            {
                entity.Property(a => a.Name)
                .HasMaxLength(40)
                .IsRequired(true);

                entity.Property(a => a.ReleaseDate)
                .IsRequired(true);

                entity.HasOne(a => a.Producer)
                .WithMany(p => p.Albums);

                entity.Property(a => a.ProducerId)
                .IsRequired(false);

            });


            builder.Entity<Performer>(entity =>
            {
                entity.Property(p => p.FirstName)
                .HasMaxLength(20)
                .IsRequired(true);

                entity.Property(p => p.LastName)
                .HasMaxLength(20)
                .IsRequired(true);

                entity.Property(p => p.Age)
                .IsRequired(true);

                entity.Property(p => p.NetWorth)
                .IsRequired(true);

            });


            builder.Entity<Producer>(entity =>
            {
                entity.Property(p => p.Name)
                .HasMaxLength(30)
                .IsRequired(true);
            });


            builder.Entity<Writer>(entity =>
            {
                entity.Property(w => w.Name)
                .HasMaxLength(20)
                .IsRequired(true);
            });


            builder.Entity<SongPerformer>(entity =>
            {
                entity.HasKey(x => new { x.SongId, x.PerformerId});
            });
        }
    }
}
