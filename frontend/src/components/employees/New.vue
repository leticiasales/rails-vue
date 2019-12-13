<template>
 <div>
  <Form title="New Employee" submit="Create" :employee="null"/>
 </div>
</template>

<script>
import Form from './Form.vue';

export default {
  name: 'employee-new',
  components: {
    Form
  },
  methods: {
    submit: function (employee) {
      this.$store.dispatch('new_employee', employee)
     .then((response) => this.$router.push('/employees/' + response.data.id))
     .catch(err => console.log(err))
    }
  }
}
</script>
