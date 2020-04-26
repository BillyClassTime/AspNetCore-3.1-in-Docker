using Microsoft.EntityFrameworkCore;

namespace iis.Data
{
    public class RazorPagesMovieContext : DbContext
    {
        public RazorPagesMovieContext (
            DbContextOptions<RazorPagesMovieContext> options)
            : base(options)
        {
        }

        public DbSet<iis.Models.Movie> Movie { get; set; }
    }
}