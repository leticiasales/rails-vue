<template>
 <div>
  <Form title="New Position" submit="Create" :position="null"/>
 </div>
</template>

<script>
// @ is an alias to /src
import Form from './Form.vue';

export default {
  name: 'position-new',
  components: {
    Form
  },
  methods: {
    submit: function (position) {
      this.$store.dispatch('new_position', position)
     .then((response) => this.$router.push('/positions/' + this.data.id))
     .catch(err => console.log(err))
    }
  }
}
</script>
