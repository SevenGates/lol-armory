class LoLA.Views.Home
  constructor: ->
    that = this

    $('.item').each -> $(this).popover { html: true, content: $(this).find('.item-tooltip').html(), trigger: 'hover' }

    $('.champion').on 'click', -> that.loadChampion($(this).data('id'))

  loadChampion: (id) ->
    $.ajax 'champions/' + id
      .error (response) ->
        throw new Error 'Champion could not be found'
      .success (response) =>
        @champion = response.champion
        @itemSet = response.recommended_item_set

        @updateMasthead()
        @loadItemSet()

  updateMasthead: ->
    $masthead = $('.champion.masthead')
    image = LoLA.Config.championImageURL(@champion['images'][0]['full'])
    roles = JSON.parse(@champion['tags']).join(', ')

    $masthead.find('.image').attr { src: image, alt: @champion['name'] }
    $masthead.find('.name').html(@champion['name'])
    $masthead.find('.title').html(@champion['title'])
    $masthead.find('.roles').html(roles)

  loadItemSet: ->
    $('.item-set').empty()

    $.each @itemSet['item_set_blocks'], (blockIndex, block) ->
      $('.item-set').append('<section class="block"><h1>' + block['block_type'].replace('_', ' ').replace('jungle', ' jungle') + '</h1></section>')

      $.each block['items'], (index, item) ->
        data =
          id:          item['id']
          name:        item['name']
          image:       LoLA.Config.itemImageURL(item['images'][0]['full'])
          cost:        item['cost']['total']
          description: item['description']

        html = JST['templates/item'](data)
        $('.item-set section').eq(blockIndex).append(html)

      $('.item').each -> $(this).popover { html: true, content: $(this).find('.item-tooltip').html(), trigger: 'hover' }
