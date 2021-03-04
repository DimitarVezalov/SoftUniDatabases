using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MusicHub.Data.Models
{
    public class Album
    {
        public Album()
        {
            this.Songs = new HashSet<Song>();
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public DateTime ReleaseDate  { get; set; }

        public decimal Price => this.Songs.Select(s => s.Price).Sum();

        public int? ProducerId { get; set; }

        public virtual Producer Producer { get; set; }

        public virtual ICollection<Song> Songs { get; set; }
    }
}
