<template>
  <div id="app" class="columns">
    <div class="column">
      <h1>{{ position.name }}</h1>
    </div>
  </div>
</template>


<script>
  export default {
    data(){
      return {
        position: {}
      }
    },
    mounted: function() {
      this.$store.dispatch('get_position_by_id', this.$route.params.id)
       .then((response) => this.position = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>