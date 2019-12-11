<template>
  <div id="app" class="columns">
    <div class="column">
      <ul>
        <li v-for="position in positions" v-bind:key="position.id">
          <router-link :to="{name: 'position_id', params: {id: position.id }}">
            {{ position.name }}
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>


<script>
  export default {
    data(){
      return {
        positions: []
      }
    },
    methods: {},
    mounted: function() {
      this.$store.dispatch('get_positions')
       .then((response) => this.positions = response.data)
       .catch(err => { console.log(err); })
    }
  }
</script>