$(function() {
  $('.rating').each(function() {
    $this = $(this);
    $this.raty({
      score: $this.data('rating'),
      scoreName: 'star',
      space: true
    });
  });
});
