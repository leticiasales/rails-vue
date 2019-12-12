<template>
 <div>
  <Form title="Edit Position" submit="Save" :position="this.position">
  </Form>
 </div>
</template>

<script>
// @ is an alias to /src
import Form from './Form.vue';

export default {
  name: 'position-edit',
  components: {
    Form
  },
  props: {
    id: Number
  },
  data(){
    return {
      position: {}
    }
  },
  mounted: function() {
    this.$store.dispatch('get_position_by_id', this.$route.params.id)
     .then((response) => this.position = response.data)
     .catch(err => { console.log(err); })
  },
  methods: {
    submit: function (position) {
      this.$store.dispatch('edit_position', position)
     .then((response) => this.$router.push('/positions/' + this.data.id))
     .catch(err => console.log(err))
    }
  }
}
</script>
