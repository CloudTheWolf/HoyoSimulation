using ImageMagick;
using ImageMagick.Drawing;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;


namespace HoyoSimulation.Lib
{
    internal class Image
    {
        /// <summary>
        /// Make the image for the Discord Embed
        /// </summary>
        /// <param name="items"></param>
        /// <returns></returns>
        internal static async Task<MagickImage> MakeWarpBanner(List<JToken> items,string game)
        {
            string background = "";

            if(game == "genshin")
            {
                background = Options.GenshinWarpBackground;
            }
            else if(game == "zenless")
            {
                background = Options.ZenlessWarpBackground;
            }
            else
            {
                background = Options.HsrWarpBackground;
            }
                //207 x 277 max size
                (int x, int y)[] positions =
                [
                    (407, 62),
                    (631, 62),
                    (856, 62),
                    (1306, 62),
                    (1081, 62),

                    (407, 392),
                    (631, 392),
                    (856, 392),
                    (1081, 392),
                    (1306, 392)
                ];
            // Download the main image
            var mainImage = await DownloadImageFromUrlAsync(background);
            var pos = 0;

            foreach (var item in items)
            {

                var overlay = await DownloadImageFromUrlAsync(item["image"].ToString());

                overlay.Density = mainImage.Density;
                overlay = ResizeImage(overlay, 200, item["name"].ToString());
                mainImage.Composite(overlay, x: positions[pos].x, y: positions[pos].y, CompositeOperator.SrcOver);
                overlay.Dispose();
                ++pos;
            }

            return mainImage;
        }

        /// <summary>
        /// Download an image from a URL
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        internal static async Task<MagickImage> DownloadImageFromUrlAsync(string url)
        {
            try
            {
                var client = new HttpClient();
                client.Timeout = TimeSpan.FromSeconds(30); // Set timeout as needed
                var response = await client.GetAsync(url);
                response.EnsureSuccessStatusCode();
                var stream = await response.Content.ReadAsStreamAsync();
                return new MagickImage(stream);
            }
            catch (Exception ex)
            {
                Logger.Log.LogError(new EventId(501, "ImageMagick Error"), ex, ex.Message);
                throw;
            }
        }

        /// <summary>
        /// Resize an image to a required width (Aspect Ration maintained)
        /// </summary>
        /// <param name="image"></param>
        /// <param name="maxWidth"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        internal static MagickImage ResizeImage(MagickImage image, uint maxWidth, string name)
        {
            // Resize the image
            uint newWidth = maxWidth;
            uint newHeight = (uint)(image.Height * ((float)maxWidth / image.Width));
            image.InterpolativeResize(newWidth, newHeight, PixelInterpolateMethod.Bilinear);

            // Split the text if necessary
            string text = name.Length > 15 ? name.Substring(0, 15) + "\n" + name.Substring(15) : name;

            // Create a text overlay image with a transparent background
            using (MagickImage TextOverlay = new MagickImage(MagickColors.Transparent, newWidth, newHeight + 100)) // Adjust height to accommodate text
            {
                // Calculate text placement coordinates
                uint textX = newWidth / 2;
                uint textY = newHeight + 40; // Adjust as needed for proper placement

                // Draw the text on the overlay
                new Drawables()
                  .FontPointSize(19)
                  .Font("Impact", FontStyleType.Italic, FontWeight.Bold, FontStretch.ExtraExpanded)
                  .StrokeColor(MagickColors.Black)
                  .StrokeWidth(1)
                  .FillColor(MagickColors.White)
                  .TextAlignment(TextAlignment.Center)
                  .Text(textX, textY, text)
                  .Draw(TextOverlay);

                // Create a final image to combine the resized image and the text overlay
                using (MagickImage finalImage = new MagickImage(MagickColors.Transparent, newWidth, newHeight + 100))
                {
                    finalImage.Composite(image, 0, 0, CompositeOperator.SrcOver);
                    finalImage.Composite(TextOverlay, 0, 0, CompositeOperator.SrcOver);
                    return (MagickImage)finalImage.Clone();
                }
            }
        }

    }
}
