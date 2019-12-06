import { createLocalVue, mount } from "@vue/test-utils"
import VanillaVueInput from '@/components/VanillaVueInput.vue'

const localVue = createLocalVue()

describe('VanillaVueInput', () => {
  let wrapper

  beforeEach(() => {
    wrapper = mount(VanillaVueInput, {
      localVue,
      props: {
        id: "Foo"
      }
    })
  })

  it('renders the correct markup', () => {
    expect(wrapper.html()).toContain("<form>\n  <fieldset><input type=\"text\" placeholder=\"Type a value here...\"></fieldset>\n  <p>Value: </p>\n</form>")
  })
})
