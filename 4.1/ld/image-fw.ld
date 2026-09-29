/* Размещение сегмента fw_code.  Сгенерировано gen_layout.py. */
SECTIONS
{
  .text.reset 0x008c0000 : { KEEP(*(.text.reset)) }
  ASSERT(SIZEOF(.text.reset) <= 8, "блок reset не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_01 0x008c0008 : { KEEP(*(.text.interrupt_vector_01)) }
  ASSERT(SIZEOF(.text.interrupt_vector_01) <= 8, "блок interrupt_vector_01 не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_02 0x008c0010 : { KEEP(*(.text.interrupt_vector_02)) }
  ASSERT(SIZEOF(.text.interrupt_vector_02) <= 8, "блок interrupt_vector_02 не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_03 0x008c0018 : { KEEP(*(.text.interrupt_vector_03)) }
  ASSERT(SIZEOF(.text.interrupt_vector_03) <= 8, "блок interrupt_vector_03 не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_04 0x008c0020 : { KEEP(*(.text.interrupt_vector_04)) }
  ASSERT(SIZEOF(.text.interrupt_vector_04) <= 8, "блок interrupt_vector_04 не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_05 0x008c0028 : { KEEP(*(.text.interrupt_vector_05)) }
  ASSERT(SIZEOF(.text.interrupt_vector_05) <= 8, "блок interrupt_vector_05 не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_06 0x008c0030 : { KEEP(*(.text.interrupt_vector_06)) }
  ASSERT(SIZEOF(.text.interrupt_vector_06) <= 8, "блок interrupt_vector_06 не влезает в отведённые ему 8 байт")
  .text.interrupt_vector_07 0x008c0038 : { KEEP(*(.text.interrupt_vector_07)) }
  ASSERT(SIZEOF(.text.interrupt_vector_07) <= 8, "блок interrupt_vector_07 не влезает в отведённые ему 8 байт")
  .text.interrupt_vectors 0x008c0040 : { KEEP(*(.text.interrupt_vectors)) }
  ASSERT(SIZEOF(.text.interrupt_vectors) <= 212, "блок interrupt_vectors не влезает в отведённые ему 212 байт")
  .text.init_globals_sweep 0x008c0114 : { KEEP(*(.text.init_globals_sweep)) }
  ASSERT(SIZEOF(.text.init_globals_sweep) <= 232, "блок init_globals_sweep не влезает в отведённые ему 232 байт")
  .text.halt_loop 0x008c01fc : { KEEP(*(.text.halt_loop)) }
  ASSERT(SIZEOF(.text.halt_loop) <= 4, "блок halt_loop не влезает в отведённые ему 4 байт")
  .text.cpu_reset_init 0x008c0200 : { KEEP(*(.text.cpu_reset_init)) }
  ASSERT(SIZEOF(.text.cpu_reset_init) <= 148, "блок cpu_reset_init не влезает в отведённые ему 148 байт")
  .text.__st_gp_to_r13 0x008c0294 : { KEEP(*(.text.__st_gp_to_r13)) }
  ASSERT(SIZEOF(.text.__st_gp_to_r13) <= 4, "блок __st_gp_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r25_to_r13 0x008c0298 : { KEEP(*(.text.__st_r25_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r25_to_r13) <= 4, "блок __st_r25_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r24_to_r13 0x008c029c : { KEEP(*(.text.__st_r24_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r24_to_r13) <= 4, "блок __st_r24_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r23_to_r13 0x008c02a0 : { KEEP(*(.text.__st_r23_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r23_to_r13) <= 4, "блок __st_r23_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r22_to_r13 0x008c02a4 : { KEEP(*(.text.__st_r22_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r22_to_r13) <= 4, "блок __st_r22_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r21_to_r13 0x008c02a8 : { KEEP(*(.text.__st_r21_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r21_to_r13) <= 4, "блок __st_r21_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r20_to_r13 0x008c02ac : { KEEP(*(.text.__st_r20_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r20_to_r13) <= 4, "блок __st_r20_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r19_to_r13 0x008c02b0 : { KEEP(*(.text.__st_r19_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r19_to_r13) <= 4, "блок __st_r19_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r18_to_r13 0x008c02b4 : { KEEP(*(.text.__st_r18_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r18_to_r13) <= 4, "блок __st_r18_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r17_to_r13 0x008c02b8 : { KEEP(*(.text.__st_r17_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r17_to_r13) <= 4, "блок __st_r17_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r16_to_r13 0x008c02bc : { KEEP(*(.text.__st_r16_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r16_to_r13) <= 4, "блок __st_r16_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r15_to_r13 0x008c02c0 : { KEEP(*(.text.__st_r15_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r15_to_r13) <= 4, "блок __st_r15_to_r13 не влезает в отведённые ему 4 байт")
  .text.__st_r14_to_r13 0x008c02c4 : { KEEP(*(.text.__st_r14_to_r13)) }
  ASSERT(SIZEOF(.text.__st_r14_to_r13) <= 16, "блок __st_r14_to_r13 не влезает в отведённые ему 16 байт")
  .text.__ld_gp_to_r13_ret 0x008c02d4 : { KEEP(*(.text.__ld_gp_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_gp_to_r13_ret) <= 4, "блок __ld_gp_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c02d8 0x008c02d8 : { KEEP(*(.text.tail_8c02d8)) }
  ASSERT(SIZEOF(.text.tail_8c02d8) <= 4, "блок tail_8c02d8 не влезает в отведённые ему 4 байт")
  .text.__ld_r25_to_r13_ret 0x008c02dc : { KEEP(*(.text.__ld_r25_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r25_to_r13_ret) <= 4, "блок __ld_r25_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c02e0 0x008c02e0 : { KEEP(*(.text.tail_8c02e0)) }
  ASSERT(SIZEOF(.text.tail_8c02e0) <= 4, "блок tail_8c02e0 не влезает в отведённые ему 4 байт")
  .text.__ld_r24_to_r13_ret 0x008c02e4 : { KEEP(*(.text.__ld_r24_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r24_to_r13_ret) <= 4, "блок __ld_r24_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c02e8 0x008c02e8 : { KEEP(*(.text.tail_8c02e8)) }
  ASSERT(SIZEOF(.text.tail_8c02e8) <= 4, "блок tail_8c02e8 не влезает в отведённые ему 4 байт")
  .text.__ld_r23_to_r13_ret 0x008c02ec : { KEEP(*(.text.__ld_r23_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r23_to_r13_ret) <= 4, "блок __ld_r23_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c02f0 0x008c02f0 : { KEEP(*(.text.tail_8c02f0)) }
  ASSERT(SIZEOF(.text.tail_8c02f0) <= 4, "блок tail_8c02f0 не влезает в отведённые ему 4 байт")
  .text.__ld_r22_to_r13_ret 0x008c02f4 : { KEEP(*(.text.__ld_r22_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r22_to_r13_ret) <= 4, "блок __ld_r22_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c02f8 0x008c02f8 : { KEEP(*(.text.tail_8c02f8)) }
  ASSERT(SIZEOF(.text.tail_8c02f8) <= 4, "блок tail_8c02f8 не влезает в отведённые ему 4 байт")
  .text.__ld_r21_to_r13_ret 0x008c02fc : { KEEP(*(.text.__ld_r21_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r21_to_r13_ret) <= 4, "блок __ld_r21_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c0300 0x008c0300 : { KEEP(*(.text.tail_8c0300)) }
  ASSERT(SIZEOF(.text.tail_8c0300) <= 4, "блок tail_8c0300 не влезает в отведённые ему 4 байт")
  .text.__ld_r20_to_r13_ret 0x008c0304 : { KEEP(*(.text.__ld_r20_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r20_to_r13_ret) <= 4, "блок __ld_r20_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c0308 0x008c0308 : { KEEP(*(.text.tail_8c0308)) }
  ASSERT(SIZEOF(.text.tail_8c0308) <= 4, "блок tail_8c0308 не влезает в отведённые ему 4 байт")
  .text.__ld_r19_to_r13_ret 0x008c030c : { KEEP(*(.text.__ld_r19_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r19_to_r13_ret) <= 4, "блок __ld_r19_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c0310 0x008c0310 : { KEEP(*(.text.tail_8c0310)) }
  ASSERT(SIZEOF(.text.tail_8c0310) <= 4, "блок tail_8c0310 не влезает в отведённые ему 4 байт")
  .text.__ld_r18_to_r13_ret 0x008c0314 : { KEEP(*(.text.__ld_r18_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r18_to_r13_ret) <= 4, "блок __ld_r18_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c0318 0x008c0318 : { KEEP(*(.text.tail_8c0318)) }
  ASSERT(SIZEOF(.text.tail_8c0318) <= 4, "блок tail_8c0318 не влезает в отведённые ему 4 байт")
  .text.__ld_r17_to_r13_ret 0x008c031c : { KEEP(*(.text.__ld_r17_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r17_to_r13_ret) <= 8, "блок __ld_r17_to_r13_ret не влезает в отведённые ему 8 байт")
  .text.__ld_r16_to_r13_ret 0x008c0324 : { KEEP(*(.text.__ld_r16_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r16_to_r13_ret) <= 8, "блок __ld_r16_to_r13_ret не влезает в отведённые ему 8 байт")
  .text.__ld_r15_to_r13_ret 0x008c032c : { KEEP(*(.text.__ld_r15_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r15_to_r13_ret) <= 4, "блок __ld_r15_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c0330 0x008c0330 : { KEEP(*(.text.tail_8c0330)) }
  ASSERT(SIZEOF(.text.tail_8c0330) <= 4, "блок tail_8c0330 не влезает в отведённые ему 4 байт")
  .text.__ld_r14_to_r13_ret 0x008c0334 : { KEEP(*(.text.__ld_r14_to_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r14_to_r13_ret) <= 4, "блок __ld_r14_to_r13_ret не влезает в отведённые ему 4 байт")
  .text.tail_8c0338 0x008c0338 : { KEEP(*(.text.tail_8c0338)) }
  ASSERT(SIZEOF(.text.tail_8c0338) <= 4, "блок tail_8c0338 не влезает в отведённые ему 4 байт")
  .text.__ld_r13_ret 0x008c033c : { KEEP(*(.text.__ld_r13_ret)) }
  ASSERT(SIZEOF(.text.__ld_r13_ret) <= 8, "блок __ld_r13_ret не влезает в отведённые ему 8 байт")
  .text.__ld_blink_ret 0x008c0344 : { KEEP(*(.text.__ld_blink_ret)) }
  ASSERT(SIZEOF(.text.__ld_blink_ret) <= 4, "блок __ld_blink_ret не влезает в отведённые ему 4 байт")
  .text.__ld_regs_tail 0x008c0348 : { KEEP(*(.text.__ld_regs_tail)) }
  ASSERT(SIZEOF(.text.__ld_regs_tail) <= 60, "блок __ld_regs_tail не влезает в отведённые ему 60 байт")
  .text.irq_enable 0x008c0384 : { KEEP(*(.text.irq_enable)) }
  ASSERT(SIZEOF(.text.irq_enable) <= 16, "блок irq_enable не влезает в отведённые ему 16 байт")
  .text.irq_enable_e1 0x008c0394 : { KEEP(*(.text.irq_enable_e1)) }
  ASSERT(SIZEOF(.text.irq_enable_e1) <= 16, "блок irq_enable_e1 не влезает в отведённые ему 16 байт")
  .text.irq_enable_e2 0x008c03a4 : { KEEP(*(.text.irq_enable_e2)) }
  ASSERT(SIZEOF(.text.irq_enable_e2) <= 16, "блок irq_enable_e2 не влезает в отведённые ему 16 байт")
  .text.fw_div_unsigned 0x008c03b4 : { KEEP(*(.text.fw_div_unsigned)) }
  ASSERT(SIZEOF(.text.fw_div_unsigned) <= 8, "блок fw_div_unsigned не влезает в отведённые ему 8 байт")
  .text.fw_divmod_signed 0x008c03bc : { KEEP(*(.text.fw_divmod_signed)) }
  ASSERT(SIZEOF(.text.fw_divmod_signed) <= 112, "блок fw_divmod_signed не влезает в отведённые ему 112 байт")
  .text.irq_disable_all 0x008c042c : { KEEP(*(.text.irq_disable_all)) }
  ASSERT(SIZEOF(.text.irq_disable_all) <= 16, "блок irq_disable_all не влезает в отведённые ему 16 байт")
  .text.irq_disable_e1 0x008c043c : { KEEP(*(.text.irq_disable_e1)) }
  ASSERT(SIZEOF(.text.irq_disable_e1) <= 16, "блок irq_disable_e1 не влезает в отведённые ему 16 байт")
  .text.irq_disable_e2 0x008c044c : { KEEP(*(.text.irq_disable_e2)) }
  ASSERT(SIZEOF(.text.irq_disable_e2) <= 16, "блок irq_disable_e2 не влезает в отведённые ему 16 байт")
  .text.epi_8c045c 0x008c045c : { KEEP(*(.text.epi_8c045c)) }
  ASSERT(SIZEOF(.text.epi_8c045c) <= 4, "блок epi_8c045c не влезает в отведённые ему 4 байт")
  .text.memcpy_fw 0x008c0460 : { KEEP(*(.text.memcpy_fw)) }
  ASSERT(SIZEOF(.text.memcpy_fw) <= 176, "блок memcpy_fw не влезает в отведённые ему 176 байт")
  .text.__lshrdi3 0x008c0510 : { KEEP(*(.text.__lshrdi3)) }
  ASSERT(SIZEOF(.text.__lshrdi3) <= 44, "блок __lshrdi3 не влезает в отведённые ему 44 байт")
  .text.shl64_fw 0x008c053c : { KEEP(*(.text.shl64_fw)) }
  ASSERT(SIZEOF(.text.shl64_fw) <= 44, "блок shl64_fw не влезает в отведённые ему 44 байт")
  .text.arith64_op 0x008c0568 : { KEEP(*(.text.arith64_op)) }
  ASSERT(SIZEOF(.text.arith64_op) <= 376, "блок arith64_op не влезает в отведённые ему 376 байт")
  .text.sar64_fw 0x008c06e0 : { KEEP(*(.text.sar64_fw)) }
  ASSERT(SIZEOF(.text.sar64_fw) <= 44, "блок sar64_fw не влезает в отведённые ему 44 байт")
  .text.umul64_fw 0x008c070c : { KEEP(*(.text.umul64_fw)) }
  ASSERT(SIZEOF(.text.umul64_fw) <= 28, "блок umul64_fw не влезает в отведённые ему 28 байт")
  .text.frag_8c0728 0x008c0728 : { KEEP(*(.text.frag_8c0728)) }
  ASSERT(SIZEOF(.text.frag_8c0728) <= 28, "блок frag_8c0728 не влезает в отведённые ему 28 байт")
  .text.set_reg_880b00_8c0744 0x008c0744 : { KEEP(*(.text.set_reg_880b00_8c0744)) }
  ASSERT(SIZEOF(.text.set_reg_880b00_8c0744) <= 24, "блок set_reg_880b00_8c0744 не влезает в отведённые ему 24 байт")
  .text.rladder__mark_invalid 0x008c075c : { KEEP(*(.text.rladder__mark_invalid)) }
  ASSERT(SIZEOF(.text.rladder__mark_invalid) <= 20, "блок rladder__mark_invalid не влезает в отведённые ему 20 байт")
  .text.stub_ret_8c0770 0x008c0770 : { KEEP(*(.text.stub_ret_8c0770)) }
  ASSERT(SIZEOF(.text.stub_ret_8c0770) <= 4, "блок stub_ret_8c0770 не влезает в отведённые ему 4 байт")
  .text.isr_instruction_error 0x008c0774 : { KEEP(*(.text.isr_instruction_error)) }
  ASSERT(SIZEOF(.text.isr_instruction_error) <= 176, "блок isr_instruction_error не влезает в отведённые ему 176 байт")
  .text.isr_icr_887000_mask 0x008c0824 : { KEEP(*(.text.isr_icr_887000_mask)) }
  ASSERT(SIZEOF(.text.isr_icr_887000_mask) <= 160, "блок isr_icr_887000_mask не влезает в отведённые ему 160 байт")
  .text.isr_icr_88701c_mask 0x008c08c4 : { KEEP(*(.text.isr_icr_88701c_mask)) }
  ASSERT(SIZEOF(.text.isr_icr_88701c_mask) <= 160, "блок isr_icr_88701c_mask не влезает в отведённые ему 160 байт")
  .text.isr_mac_886028 0x008c0964 : { KEEP(*(.text.isr_mac_886028)) }
  ASSERT(SIZEOF(.text.isr_mac_886028) <= 188, "блок isr_mac_886028 не влезает в отведённые ему 188 байт")
  .text.isr_pll_unlock 0x008c0a20 : { KEEP(*(.text.isr_pll_unlock)) }
  ASSERT(SIZEOF(.text.isr_pll_unlock) <= 264, "блок isr_pll_unlock не влезает в отведённые ему 264 байт")
  .text.frag_8c0b28 0x008c0b28 : { KEEP(*(.text.frag_8c0b28)) }
  ASSERT(SIZEOF(.text.frag_8c0b28) <= 4, "блок frag_8c0b28 не влезает в отведённые ему 4 байт")
  .text.isr_return_only 0x008c0b2c : { KEEP(*(.text.isr_return_only)) }
  ASSERT(SIZEOF(.text.isr_return_only) <= 4, "блок isr_return_only не влезает в отведённые ему 4 байт")
  .text.isr_pcie_debug 0x008c0b30 : { KEEP(*(.text.isr_pcie_debug)) }
  ASSERT(SIZEOF(.text.isr_pcie_debug) <= 284, "блок isr_pcie_debug не влезает в отведённые ему 284 байт")
  .text.isr_pcie_main 0x008c0c4c : { KEEP(*(.text.isr_pcie_main)) }
  ASSERT(SIZEOF(.text.isr_pcie_main) <= 672, "блок isr_pcie_main не влезает в отведённые ему 672 байт")
  .text.interrupt_handlers__isrs 0x008c0eec : { KEEP(*(.text.interrupt_handlers__isrs)) }
  ASSERT(SIZEOF(.text.interrupt_handlers__isrs) <= 8, "блок interrupt_handlers__isrs не влезает в отведённые ему 8 байт")
  .text.isr_pcie_ltssm_dbg 0x008c0ef4 : { KEEP(*(.text.isr_pcie_ltssm_dbg)) }
  ASSERT(SIZEOF(.text.isr_pcie_ltssm_dbg) <= 268, "блок isr_pcie_ltssm_dbg не влезает в отведённые ему 268 байт")
  .text.isr_awake_tsf_led 0x008c1000 : { KEEP(*(.text.isr_awake_tsf_led)) }
  ASSERT(SIZEOF(.text.isr_awake_tsf_led) <= 152, "блок isr_awake_tsf_led не влезает в отведённые ему 152 байт")
  .text.isr_txrx_manager 0x008c1098 : { KEEP(*(.text.isr_txrx_manager)) }
  ASSERT(SIZEOF(.text.isr_txrx_manager) <= 152, "блок isr_txrx_manager не влезает в отведённые ему 152 байт")
  .text.isr_ucode_fault 0x008c1130 : { KEEP(*(.text.isr_ucode_fault)) }
  ASSERT(SIZEOF(.text.isr_ucode_fault) <= 316, "блок isr_ucode_fault не влезает в отведённые ему 316 байт")
  .text.isr_pring_dma 0x008c126c : { KEEP(*(.text.isr_pring_dma)) }
  ASSERT(SIZEOF(.text.isr_pring_dma) <= 152, "блок isr_pring_dma не влезает в отведённые ему 152 байт")
  .text.isr_vring_dma 0x008c1304 : { KEEP(*(.text.isr_vring_dma)) }
  ASSERT(SIZEOF(.text.isr_vring_dma) <= 156, "блок isr_vring_dma не влезает в отведённые ему 156 байт")
  .text.isr_memory_error 0x008c13a0 : { KEEP(*(.text.isr_memory_error)) }
  ASSERT(SIZEOF(.text.isr_memory_error) <= 224, "блок isr_memory_error не влезает в отведённые ему 224 байт")
  .text.set_reg_880b00_8c1480 0x008c1480 : { KEEP(*(.text.set_reg_880b00_8c1480)) }
  ASSERT(SIZEOF(.text.set_reg_880b00_8c1480) <= 24, "блок set_reg_880b00_8c1480 не влезает в отведённые ему 24 байт")
  .text.mac_enable_bcast_ring 0x008c1498 : { KEEP(*(.text.mac_enable_bcast_ring)) }
  ASSERT(SIZEOF(.text.mac_enable_bcast_ring) <= 28, "блок mac_enable_bcast_ring не влезает в отведённые ему 28 байт")
  .text.hwf_rladder_scan 0x008c14b4 : { KEEP(*(.text.hwf_rladder_scan)) }
  ASSERT(SIZEOF(.text.hwf_rladder_scan) <= 252, "блок hwf_rladder_scan не влезает в отведённые ему 252 байт")
  .text.rladder__step_code 0x008c15b0 : { KEEP(*(.text.rladder__step_code)) }
  ASSERT(SIZEOF(.text.rladder__step_code) <= 32, "блок rladder__step_code не влезает в отведённые ему 32 байт")
  .text.set_reg_880b00_8c15d0 0x008c15d0 : { KEEP(*(.text.set_reg_880b00_8c15d0)) }
  ASSERT(SIZEOF(.text.set_reg_880b00_8c15d0) <= 24, "блок set_reg_880b00_8c15d0 не влезает в отведённые ему 24 байт")
  .text.isr_880b50__dispatch_causes 0x008c15e8 : { KEEP(*(.text.isr_880b50__dispatch_causes)) }
  ASSERT(SIZEOF(.text.isr_880b50__dispatch_causes) <= 116, "блок isr_880b50__dispatch_causes не влезает в отведённые ему 116 байт")
  .text.fw_boot__clear_bss 0x008c165c : { KEEP(*(.text.fw_boot__clear_bss)) }
  ASSERT(SIZEOF(.text.fw_boot__clear_bss) <= 112, "блок fw_boot__clear_bss не влезает в отведённые ему 112 байт")
  .text.stub_ret_8c16cc 0x008c16cc : { KEEP(*(.text.stub_ret_8c16cc)) }
  ASSERT(SIZEOF(.text.stub_ret_8c16cc) <= 4, "блок stub_ret_8c16cc не влезает в отведённые ему 4 байт")
  .text.mem_pool__create 0x008c16d0 : { KEEP(*(.text.mem_pool__create)) }
  ASSERT(SIZEOF(.text.mem_pool__create) <= 156, "блок mem_pool__create не влезает в отведённые ему 156 байт")
  .text.obj__store3_wrap 0x008c176c : { KEEP(*(.text.obj__store3_wrap)) }
  ASSERT(SIZEOF(.text.obj__store3_wrap) <= 8, "блок obj__store3_wrap не влезает в отведённые ему 8 байт")
  .text.frag_8c1774 0x008c1774 : { KEEP(*(.text.frag_8c1774)) }
  ASSERT(SIZEOF(.text.frag_8c1774) <= 36, "блок frag_8c1774 не влезает в отведённые ему 36 байт")
  .text.obj__set_vtable_80058c 0x008c1798 : { KEEP(*(.text.obj__set_vtable_80058c)) }
  ASSERT(SIZEOF(.text.obj__set_vtable_80058c) <= 20, "блок obj__set_vtable_80058c не влезает в отведённые ему 20 байт")
  .text.boot__clear_object_48 0x008c17ac : { KEEP(*(.text.boot__clear_object_48)) }
  ASSERT(SIZEOF(.text.boot__clear_object_48) <= 12, "блок boot__clear_object_48 не влезает в отведённые ему 12 байт")
  .text.boot__clear_object_tail 0x008c17b8 : { KEEP(*(.text.boot__clear_object_tail)) }
  ASSERT(SIZEOF(.text.boot__clear_object_tail) <= 16, "блок boot__clear_object_tail не влезает в отведённые ему 16 байт")
  .text.boot__clear_object_4_a 0x008c17c8 : { KEEP(*(.text.boot__clear_object_4_a)) }
  ASSERT(SIZEOF(.text.boot__clear_object_4_a) <= 12, "блок boot__clear_object_4_a не влезает в отведённые ему 12 байт")
  .text.boot__clear_object_4_b 0x008c17d4 : { KEEP(*(.text.boot__clear_object_4_b)) }
  ASSERT(SIZEOF(.text.boot__clear_object_4_b) <= 12, "блок boot__clear_object_4_b не влезает в отведённые ему 12 байт")
  .text.tail_brd_if__clear_block_info 0x008c17e0 : { KEEP(*(.text.tail_brd_if__clear_block_info)) }
  ASSERT(SIZEOF(.text.tail_brd_if__clear_block_info) <= 4, "блок tail_brd_if__clear_block_info не влезает в отведённые ему 4 байт")
  .text.tail_brd_if__clear_section_info 0x008c17e4 : { KEEP(*(.text.tail_brd_if__clear_section_info)) }
  ASSERT(SIZEOF(.text.tail_brd_if__clear_section_info) <= 4, "блок tail_brd_if__clear_section_info не влезает в отведённые ему 4 байт")
  .text.table_8430b0__install_pointers 0x008c17e8 : { KEEP(*(.text.table_8430b0__install_pointers)) }
  ASSERT(SIZEOF(.text.table_8430b0__install_pointers) <= 56, "блок table_8430b0__install_pointers не влезает в отведённые ему 56 байт")
  .text.set_g_8002dc 0x008c1820 : { KEEP(*(.text.set_g_8002dc)) }
  ASSERT(SIZEOF(.text.set_g_8002dc) <= 24, "блок set_g_8002dc не влезает в отведённые ему 24 байт")
  .text.set_g_8034f8_x2 0x008c1838 : { KEEP(*(.text.set_g_8034f8_x2)) }
  ASSERT(SIZEOF(.text.set_g_8034f8_x2) <= 24, "блок set_g_8034f8_x2 не влезает в отведённые ему 24 байт")
  .text.set_mem_84ee20 0x008c1850 : { KEEP(*(.text.set_mem_84ee20)) }
  ASSERT(SIZEOF(.text.set_mem_84ee20) <= 28, "блок set_mem_84ee20 не влезает в отведённые ему 28 байт")
  .text.set_mem_842aa0_x2 0x008c186c : { KEEP(*(.text.set_mem_842aa0_x2)) }
  ASSERT(SIZEOF(.text.set_mem_842aa0_x2) <= 24, "блок set_mem_842aa0_x2 не влезает в отведённые ему 24 байт")
  .text.boot__init_803e30 0x008c1884 : { KEEP(*(.text.boot__init_803e30)) }
  ASSERT(SIZEOF(.text.boot__init_803e30) <= 44, "блок boot__init_803e30 не влезает в отведённые ему 44 байт")
  .text.get_g_80045c 0x008c18b0 : { KEEP(*(.text.get_g_80045c)) }
  ASSERT(SIZEOF(.text.get_g_80045c) <= 16, "блок get_g_80045c не влезает в отведённые ему 16 байт")
  .text.frag_8c18c0 0x008c18c0 : { KEEP(*(.text.frag_8c18c0)) }
  ASSERT(SIZEOF(.text.frag_8c18c0) <= 32, "блок frag_8c18c0 не влезает в отведённые ему 32 байт")
  .text.boot__init_8042ac_objects 0x008c18e0 : { KEEP(*(.text.boot__init_8042ac_objects)) }
  ASSERT(SIZEOF(.text.boot__init_8042ac_objects) <= 52, "блок boot__init_8042ac_objects не влезает в отведённые ему 52 байт")
  .text.frag_8c1914 0x008c1914 : { KEEP(*(.text.frag_8c1914)) }
  ASSERT(SIZEOF(.text.frag_8c1914) <= 20, "блок frag_8c1914 не влезает в отведённые ему 20 байт")
  .text.set_g_8062c4 0x008c1928 : { KEEP(*(.text.set_g_8062c4)) }
  ASSERT(SIZEOF(.text.set_g_8062c4) <= 16, "блок set_g_8062c4 не влезает в отведённые ему 16 байт")
  .text.vring_ctx__install_pointers 0x008c1938 : { KEEP(*(.text.vring_ctx__install_pointers)) }
  ASSERT(SIZEOF(.text.vring_ctx__install_pointers) <= 56, "блок vring_ctx__install_pointers не влезает в отведённые ему 56 байт")
  .text.set_mem_843084 0x008c1970 : { KEEP(*(.text.set_mem_843084)) }
  ASSERT(SIZEOF(.text.set_mem_843084) <= 16, "блок set_mem_843084 не влезает в отведённые ему 16 байт")
  .text.mem_pool__init_8053b0 0x008c1980 : { KEEP(*(.text.mem_pool__init_8053b0)) }
  ASSERT(SIZEOF(.text.mem_pool__init_8053b0) <= 40, "блок mem_pool__init_8053b0 не влезает в отведённые ему 40 байт")
  .text.frag_8c19a8 0x008c19a8 : { KEEP(*(.text.frag_8c19a8)) }
  ASSERT(SIZEOF(.text.frag_8c19a8) <= 20, "блок frag_8c19a8 не влезает в отведённые ему 20 байт")
  .text.boot__install_80353c_vtbl 0x008c19bc : { KEEP(*(.text.boot__install_80353c_vtbl)) }
  ASSERT(SIZEOF(.text.boot__install_80353c_vtbl) <= 40, "блок boot__install_80353c_vtbl не влезает в отведённые ему 40 байт")
  .text.mem_pool__init_847df0 0x008c19e4 : { KEEP(*(.text.mem_pool__init_847df0)) }
  ASSERT(SIZEOF(.text.mem_pool__init_847df0) <= 48, "блок mem_pool__init_847df0 не влезает в отведённые ему 48 байт")
  .text.boot__init_once_80055c 0x008c1a14 : { KEEP(*(.text.boot__init_once_80055c)) }
  ASSERT(SIZEOF(.text.boot__init_once_80055c) <= 44, "блок boot__init_once_80055c не влезает в отведённые ему 44 байт")
  .text.list_80182c__drain_and_run 0x008c1a40 : { KEEP(*(.text.list_80182c__drain_and_run)) }
  ASSERT(SIZEOF(.text.list_80182c__drain_and_run) <= 28, "блок list_80182c__drain_and_run не влезает в отведённые ему 28 байт")
  .text.frag_8c1a5c 0x008c1a5c : { KEEP(*(.text.frag_8c1a5c)) }
  ASSERT(SIZEOF(.text.frag_8c1a5c) <= 4, "блок frag_8c1a5c не влезает в отведённые ему 4 байт")
  .text.list_80182c__insert_obj 0x008c1a60 : { KEEP(*(.text.list_80182c__insert_obj)) }
  ASSERT(SIZEOF(.text.list_80182c__insert_obj) <= 16, "блок list_80182c__insert_obj не влезает в отведённые ему 16 байт")
  .text.tail_stub_ret_8c1a74 0x008c1a70 : { KEEP(*(.text.tail_stub_ret_8c1a74)) }
  ASSERT(SIZEOF(.text.tail_stub_ret_8c1a74) <= 4, "блок tail_stub_ret_8c1a74 не влезает в отведённые ему 4 байт")
  .text.stub_ret_8c1a74 0x008c1a74 : { KEEP(*(.text.stub_ret_8c1a74)) }
  ASSERT(SIZEOF(.text.stub_ret_8c1a74) <= 4, "блок stub_ret_8c1a74 не влезает в отведённые ему 4 байт")
  .text.memset0_words 0x008c1a78 : { KEEP(*(.text.memset0_words)) }
  ASSERT(SIZEOF(.text.memset0_words) <= 148, "блок memset0_words не влезает в отведённые ему 148 байт")
  .text.fw_boot__jump_reset 0x008c1b0c : { KEEP(*(.text.fw_boot__jump_reset)) }
  ASSERT(SIZEOF(.text.fw_boot__jump_reset) <= 8, "блок fw_boot__jump_reset не влезает в отведённые ему 8 байт")
  .text.calib_engine__on_abort 0x008c1b14 : { KEEP(*(.text.calib_engine__on_abort)) }
  ASSERT(SIZEOF(.text.calib_engine__on_abort) <= 36, "блок calib_engine__on_abort не влезает в отведённые ему 36 байт")
  .text.tail_basic_sm__inject_event 0x008c1b38 : { KEEP(*(.text.tail_basic_sm__inject_event)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event) <= 12, "блок tail_basic_sm__inject_event не влезает в отведённые ему 12 байт")
  .text.stream_mgr__rx_action 0x008c1b44 : { KEEP(*(.text.stream_mgr__rx_action)) }
  ASSERT(SIZEOF(.text.stream_mgr__rx_action) <= 536, "блок stream_mgr__rx_action не влезает в отведённые ему 536 байт")
  .text.rx_mgmt__action_no_ack 0x008c1d5c : { KEEP(*(.text.rx_mgmt__action_no_ack)) }
  ASSERT(SIZEOF(.text.rx_mgmt__action_no_ack) <= 80, "блок rx_mgmt__action_no_ack не влезает в отведённые ему 80 байт")
  .text.vring_schd__alloc_pring 0x008c1dac : { KEEP(*(.text.vring_schd__alloc_pring)) }
  ASSERT(SIZEOF(.text.vring_schd__alloc_pring) <= 68, "блок vring_schd__alloc_pring не влезает в отведённые ему 68 байт")
  .text.conn_mgr__activate_conn 0x008c1df0 : { KEEP(*(.text.conn_mgr__activate_conn)) }
  ASSERT(SIZEOF(.text.conn_mgr__activate_conn) <= 84, "блок conn_mgr__activate_conn не влезает в отведённые ему 84 байт")
  .text.vring_schd__move_to_ready 0x008c1e44 : { KEEP(*(.text.vring_schd__move_to_ready)) }
  ASSERT(SIZEOF(.text.vring_schd__move_to_ready) <= 300, "блок vring_schd__move_to_ready не влезает в отведённые ему 300 байт")
  .text.sorted_llist__unlink 0x008c1f70 : { KEEP(*(.text.sorted_llist__unlink)) }
  ASSERT(SIZEOF(.text.sorted_llist__unlink) <= 84, "блок sorted_llist__unlink не влезает в отведённые ему 84 байт")
  .text.llist__insert 0x008c1fc4 : { KEEP(*(.text.llist__insert)) }
  ASSERT(SIZEOF(.text.llist__insert) <= 84, "блок llist__insert не влезает в отведённые ему 84 байт")
  .text.sorted_llist__insert 0x008c2018 : { KEEP(*(.text.sorted_llist__insert)) }
  ASSERT(SIZEOF(.text.sorted_llist__insert) <= 140, "блок sorted_llist__insert не влезает в отведённые ему 140 байт")
  .text.llist__insert_after 0x008c20a4 : { KEEP(*(.text.llist__insert_after)) }
  ASSERT(SIZEOF(.text.llist__insert_after) <= 148, "блок llist__insert_after не влезает в отведённые ему 148 байт")
  .text.stream_mgr__add_bcast_vring 0x008c2138 : { KEEP(*(.text.stream_mgr__add_bcast_vring)) }
  ASSERT(SIZEOF(.text.stream_mgr__add_bcast_vring) <= 88, "блок stream_mgr__add_bcast_vring не влезает в отведённые ему 88 байт")
  .text.tx_bcon__update_bcon 0x008c2190 : { KEEP(*(.text.tx_bcon__update_bcon)) }
  ASSERT(SIZEOF(.text.tx_bcon__update_bcon) <= 204, "блок tx_bcon__update_bcon не влезает в отведённые ему 204 байт")
  .text.find_mng__add_bcon 0x008c225c : { KEEP(*(.text.find_mng__add_bcon)) }
  ASSERT(SIZEOF(.text.find_mng__add_bcon) <= 76, "блок find_mng__add_bcon не влезает в отведённые ему 76 байт")
  .text.conn__on_bf_results 0x008c22a8 : { KEEP(*(.text.conn__on_bf_results)) }
  ASSERT(SIZEOF(.text.conn__on_bf_results) <= 8, "блок conn__on_bf_results не влезает в отведённые ему 8 байт")
  .text.frag_8c22b0 0x008c22b0 : { KEEP(*(.text.frag_8c22b0)) }
  ASSERT(SIZEOF(.text.frag_8c22b0) <= 52, "блок frag_8c22b0 не влезает в отведённые ему 52 байт")
  .text.add_discovery_bcon 0x008c22e4 : { KEEP(*(.text.add_discovery_bcon)) }
  ASSERT(SIZEOF(.text.add_discovery_bcon) <= 212, "блок add_discovery_bcon не влезает в отведённые ему 212 байт")
  .text.FWQ_TX_AVAILABILITY__add_packet 0x008c23b8 : { KEEP(*(.text.FWQ_TX_AVAILABILITY__add_packet)) }
  ASSERT(SIZEOF(.text.FWQ_TX_AVAILABILITY__add_packet) <= 168, "блок FWQ_TX_AVAILABILITY__add_packet не влезает в отведённые ему 168 байт")
  .text.fwq_tx__enqueue 0x008c2460 : { KEEP(*(.text.fwq_tx__enqueue)) }
  ASSERT(SIZEOF(.text.fwq_tx__enqueue) <= 56, "блок fwq_tx__enqueue не влезает в отведённые ему 56 байт")
  .text.add_pbss_dmg_capinfo_list 0x008c2498 : { KEEP(*(.text.add_pbss_dmg_capinfo_list)) }
  ASSERT(SIZEOF(.text.add_pbss_dmg_capinfo_list) <= 208, "блок add_pbss_dmg_capinfo_list не влезает в отведённые ему 208 байт")
  .text.vring_schd__add_sniffer_vring 0x008c2568 : { KEEP(*(.text.vring_schd__add_sniffer_vring)) }
  ASSERT(SIZEOF(.text.vring_schd__add_sniffer_vring) <= 80, "блок vring_schd__add_sniffer_vring не влезает в отведённые ему 80 байт")
  .text.rs_done__snapshot_stats 0x008c25b8 : { KEEP(*(.text.rs_done__snapshot_stats)) }
  ASSERT(SIZEOF(.text.rs_done__snapshot_stats) <= 44, "блок rs_done__snapshot_stats не влезает в отведённые ему 44 байт")
  .text.conn_mgr__add_to_rinking_list 0x008c25e4 : { KEEP(*(.text.conn_mgr__add_to_rinking_list)) }
  ASSERT(SIZEOF(.text.conn_mgr__add_to_rinking_list) <= 88, "блок conn_mgr__add_to_rinking_list не влезает в отведённые ему 88 байт")
  .text.STREAM_MGR__ADD 0x008c263c : { KEEP(*(.text.STREAM_MGR__ADD)) }
  ASSERT(SIZEOF(.text.STREAM_MGR__ADD) <= 304, "блок STREAM_MGR__ADD не влезает в отведённые ему 304 байт")
  .text.vring_schd__add_vring 0x008c276c : { KEEP(*(.text.vring_schd__add_vring)) }
  ASSERT(SIZEOF(.text.vring_schd__add_vring) <= 220, "блок vring_schd__add_vring не влезает в отведённые ему 220 байт")
  .text.stream_mgr__addba_req_to_host 0x008c2848 : { KEEP(*(.text.stream_mgr__addba_req_to_host)) }
  ASSERT(SIZEOF(.text.stream_mgr__addba_req_to_host) <= 164, "блок stream_mgr__addba_req_to_host не влезает в отведённые ему 164 байт")
  .text.stream_mgr__addba_req_tx_complete 0x008c28ec : { KEEP(*(.text.stream_mgr__addba_req_tx_complete)) }
  ASSERT(SIZEOF(.text.stream_mgr__addba_req_tx_complete) <= 64, "блок stream_mgr__addba_req_tx_complete не влезает в отведённые ему 64 байт")
  .text.frag_8c292c 0x008c292c : { KEEP(*(.text.frag_8c292c)) }
  ASSERT(SIZEOF(.text.frag_8c292c) <= 4, "блок frag_8c292c не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_addbareq_tx_complete 0x008c2930 : { KEEP(*(.text.ba_sm__on_addbareq_tx_complete)) }
  ASSERT(SIZEOF(.text.ba_sm__on_addbareq_tx_complete) <= 20, "блок ba_sm__on_addbareq_tx_complete не влезает в отведённые ему 20 байт")
  .text.stream_mgr__on_delba 0x008c2944 : { KEEP(*(.text.stream_mgr__on_delba)) }
  ASSERT(SIZEOF(.text.stream_mgr__on_delba) <= 64, "блок stream_mgr__on_delba не влезает в отведённые ему 64 байт")
  .text.addba_rsp_handler 0x008c2984 : { KEEP(*(.text.addba_rsp_handler)) }
  ASSERT(SIZEOF(.text.addba_rsp_handler) <= 48, "блок addba_rsp_handler не влезает в отведённые ему 48 байт")
  .text.tx_macq__set_ba_win 0x008c29b4 : { KEEP(*(.text.tx_macq__set_ba_win)) }
  ASSERT(SIZEOF(.text.tx_macq__set_ba_win) <= 24, "блок tx_macq__set_ba_win не влезает в отведённые ему 24 байт")
  .text.tx_macq__config_queue 0x008c29cc : { KEEP(*(.text.tx_macq__config_queue)) }
  ASSERT(SIZEOF(.text.tx_macq__config_queue) <= 32, "блок tx_macq__config_queue не влезает в отведённые ему 32 байт")
  .text.epi_8c29ec 0x008c29ec : { KEEP(*(.text.epi_8c29ec)) }
  ASSERT(SIZEOF(.text.epi_8c29ec) <= 4, "блок epi_8c29ec не влезает в отведённые ему 4 байт")
  .text.sta_psc_sm__on_agreed 0x008c29f0 : { KEEP(*(.text.sta_psc_sm__on_agreed)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__on_agreed) <= 4, "блок sta_psc_sm__on_agreed не влезает в отведённые ему 4 байт")
  .text.sm_pring__all_wb_done_evt 0x008c29f4 : { KEEP(*(.text.sm_pring__all_wb_done_evt)) }
  ASSERT(SIZEOF(.text.sm_pring__all_wb_done_evt) <= 208, "блок sm_pring__all_wb_done_evt не влезает в отведённые ему 208 байт")
  .text.frag_8c2ac4 0x008c2ac4 : { KEEP(*(.text.frag_8c2ac4)) }
  ASSERT(SIZEOF(.text.frag_8c2ac4) <= 4, "блок frag_8c2ac4 не влезает в отведённые ему 4 байт")
  .text.u_schd__add 0x008c2ac8 : { KEEP(*(.text.u_schd__add)) }
  ASSERT(SIZEOF(.text.u_schd__add) <= 68, "блок u_schd__add не влезает в отведённые ему 68 байт")
  .text.lmac_mbox__alloc_slot 0x008c2b0c : { KEEP(*(.text.lmac_mbox__alloc_slot)) }
  ASSERT(SIZEOF(.text.lmac_mbox__alloc_slot) <= 12, "блок lmac_mbox__alloc_slot не влезает в отведённые ему 12 байт")
  .text.conn_mgr__alloc_cid 0x008c2b18 : { KEEP(*(.text.conn_mgr__alloc_cid)) }
  ASSERT(SIZEOF(.text.conn_mgr__alloc_cid) <= 80, "блок conn_mgr__alloc_cid не влезает в отведённые ему 80 байт")
  .text.operational_if__alloc_evt 0x008c2b68 : { KEEP(*(.text.operational_if__alloc_evt)) }
  ASSERT(SIZEOF(.text.operational_if__alloc_evt) <= 16, "блок operational_if__alloc_evt не влезает в отведённые ему 16 байт")
  .text.lmac_echo__alloc_mbox_slot 0x008c2b78 : { KEEP(*(.text.lmac_echo__alloc_mbox_slot)) }
  ASSERT(SIZEOF(.text.lmac_echo__alloc_mbox_slot) <= 16, "блок lmac_echo__alloc_mbox_slot не влезает в отведённые ему 16 байт")
  .text.u_schd__alloc_entry 0x008c2b88 : { KEEP(*(.text.u_schd__alloc_entry)) }
  ASSERT(SIZEOF(.text.u_schd__alloc_entry) <= 72, "блок u_schd__alloc_entry не влезает в отведённые ему 72 байт")
  .text.rx_mgmt__find_free_ei 0x008c2bd0 : { KEEP(*(.text.rx_mgmt__find_free_ei)) }
  ASSERT(SIZEOF(.text.rx_mgmt__find_free_ei) <= 36, "блок rx_mgmt__find_free_ei не влезает в отведённые ему 36 байт")
  .text.rx_api__alloc_rx_buffer 0x008c2bf4 : { KEEP(*(.text.rx_api__alloc_rx_buffer)) }
  ASSERT(SIZEOF(.text.rx_api__alloc_rx_buffer) <= 68, "блок rx_api__alloc_rx_buffer не влезает в отведённые ему 68 байт")
  .text.basic_if__alloc_mbox_slot 0x008c2c38 : { KEEP(*(.text.basic_if__alloc_mbox_slot)) }
  ASSERT(SIZEOF(.text.basic_if__alloc_mbox_slot) <= 72, "блок basic_if__alloc_mbox_slot не влезает в отведённые ему 72 байт")
  .text.TX_API__alloc_tx_payload 0x008c2c80 : { KEEP(*(.text.TX_API__alloc_tx_payload)) }
  ASSERT(SIZEOF(.text.TX_API__alloc_tx_payload) <= 132, "блок TX_API__alloc_tx_payload не влезает в отведённые ему 132 байт")
  .text.stream_mgr__alloc_pring 0x008c2d04 : { KEEP(*(.text.stream_mgr__alloc_pring)) }
  ASSERT(SIZEOF(.text.stream_mgr__alloc_pring) <= 48, "блок stream_mgr__alloc_pring не влезает в отведённые ему 48 байт")
  .text.mbox__alloc_from_pool 0x008c2d34 : { KEEP(*(.text.mbox__alloc_from_pool)) }
  ASSERT(SIZEOF(.text.mbox__alloc_from_pool) <= 24, "блок mbox__alloc_from_pool не влезает в отведённые ему 24 байт")
  .text.mid__open 0x008c2d4c : { KEEP(*(.text.mid__open)) }
  ASSERT(SIZEOF(.text.mid__open) <= 124, "блок mid__open не влезает в отведённые ему 124 байт")
  .text.mem_pool__allocate 0x008c2dc8 : { KEEP(*(.text.mem_pool__allocate)) }
  ASSERT(SIZEOF(.text.mem_pool__allocate) <= 444, "блок mem_pool__allocate не влезает в отведённые ему 444 байт")
  .text.conn_mgr__allocate_cid_db_element 0x008c2f84 : { KEEP(*(.text.conn_mgr__allocate_cid_db_element)) }
  ASSERT(SIZEOF(.text.conn_mgr__allocate_cid_db_element) <= 96, "блок conn_mgr__allocate_cid_db_element не влезает в отведённые ему 96 байт")
  .text.vring_schd__find_runnable 0x008c2fe4 : { KEEP(*(.text.vring_schd__find_runnable)) }
  ASSERT(SIZEOF(.text.vring_schd__find_runnable) <= 152, "блок vring_schd__find_runnable не влезает в отведённые ему 152 байт")
  .text.mid_list__any_in_state2 0x008c307c : { KEEP(*(.text.mid_list__any_in_state2)) }
  ASSERT(SIZEOF(.text.mid_list__any_in_state2) <= 64, "блок mid_list__any_in_state2 не влезает в отведённые ему 64 байт")
  .text.fw_mailbox__has_pending 0x008c30bc : { KEEP(*(.text.fw_mailbox__has_pending)) }
  ASSERT(SIZEOF(.text.fw_mailbox__has_pending) <= 20, "блок fw_mailbox__has_pending не влезает в отведённые ему 20 байт")
  .text.pring__is_idle 0x008c30d0 : { KEEP(*(.text.pring__is_idle)) }
  ASSERT(SIZEOF(.text.pring__is_idle) <= 44, "блок pring__is_idle не влезает в отведённые ему 44 байт")
  .text.mid__update_aw_ie 0x008c30fc : { KEEP(*(.text.mid__update_aw_ie)) }
  ASSERT(SIZEOF(.text.mid__update_aw_ie) <= 100, "блок mid__update_aw_ie не влезает в отведённые ему 100 байт")
  .text.conn_mgr__apply_default_link_maintain_cfg 0x008c3160 : { KEEP(*(.text.conn_mgr__apply_default_link_maintain_cfg)) }
  ASSERT(SIZEOF(.text.conn_mgr__apply_default_link_maintain_cfg) <= 104, "блок conn_mgr__apply_default_link_maintain_cfg не влезает в отведённые ему 104 байт")
  .text.rm_ch_switch__program_mac 0x008c31c8 : { KEEP(*(.text.rm_ch_switch__program_mac)) }
  ASSERT(SIZEOF(.text.rm_ch_switch__program_mac) <= 48, "блок rm_ch_switch__program_mac не влезает в отведённые ему 48 байт")
  .text.irq_set_level 0x008c31f8 : { KEEP(*(.text.irq_set_level)) }
  ASSERT(SIZEOF(.text.irq_set_level) <= 20, "блок irq_set_level не влезает в отведённые ему 20 байт")
  .text.tail_set_reg_88024c 0x008c320c : { KEEP(*(.text.tail_set_reg_88024c)) }
  ASSERT(SIZEOF(.text.tail_set_reg_88024c) <= 4, "блок tail_set_reg_88024c не влезает в отведённые ему 4 байт")
  .text.conn_main_sm__send_assoc_resp_pbss 0x008c3210 : { KEEP(*(.text.conn_main_sm__send_assoc_resp_pbss)) }
  ASSERT(SIZEOF(.text.conn_main_sm__send_assoc_resp_pbss) <= 132, "блок conn_main_sm__send_assoc_resp_pbss не влезает в отведённые ему 132 байт")
  .text.pcp_ap__set_aid 0x008c3294 : { KEEP(*(.text.pcp_ap__set_aid)) }
  ASSERT(SIZEOF(.text.pcp_ap__set_aid) <= 116, "блок pcp_ap__set_aid не влезает в отведённые ему 116 байт")
  .text.PS_CONNECTION__assoc_ntf 0x008c3308 : { KEEP(*(.text.PS_CONNECTION__assoc_ntf)) }
  ASSERT(SIZEOF(.text.PS_CONNECTION__assoc_ntf) <= 128, "блок PS_CONNECTION__assoc_ntf не влезает в отведённые ему 128 байт")
  .text.ps_connection_mgr__on_assoc 0x008c3388 : { KEEP(*(.text.ps_connection_mgr__on_assoc)) }
  ASSERT(SIZEOF(.text.ps_connection_mgr__on_assoc) <= 108, "блок ps_connection_mgr__on_assoc не влезает в отведённые ему 108 байт")
  .text.assoc_ready_check_trig 0x008c33f4 : { KEEP(*(.text.assoc_ready_check_trig)) }
  ASSERT(SIZEOF(.text.assoc_ready_check_trig) <= 244, "блок assoc_ready_check_trig не влезает в отведённые ему 244 байт")
  .text.get_g_800118_8c34e8 0x008c34e8 : { KEEP(*(.text.get_g_800118_8c34e8)) }
  ASSERT(SIZEOF(.text.get_g_800118_8c34e8) <= 12, "блок get_g_800118_8c34e8 не влезает в отведённые ему 12 байт")
  .text.ps_assoc_mgr__aw_ie_reception 0x008c34f4 : { KEEP(*(.text.ps_assoc_mgr__aw_ie_reception)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__aw_ie_reception) <= 108, "блок ps_assoc_mgr__aw_ie_reception не влезает в отведённые ему 108 байт")
  .text.g_dbg_psc_transition 0x008c3560 : { KEEP(*(.text.g_dbg_psc_transition)) }
  ASSERT(SIZEOF(.text.g_dbg_psc_transition) <= 164, "блок g_dbg_psc_transition не влезает в отведённые ему 164 байт")
  .text.ps__store_awake_count 0x008c3604 : { KEEP(*(.text.ps__store_awake_count)) }
  ASSERT(SIZEOF(.text.ps__store_awake_count) <= 16, "блок ps__store_awake_count не влезает в отведённые ему 16 байт")
  .text.ps_conn_mgr__report_psc_transitions 0x008c3614 : { KEEP(*(.text.ps_conn_mgr__report_psc_transitions)) }
  ASSERT(SIZEOF(.text.ps_conn_mgr__report_psc_transitions) <= 68, "блок ps_conn_mgr__report_psc_transitions не влезает в отведённые ему 68 байт")
  .text.TX_API__awake_peer_ntf 0x008c3658 : { KEEP(*(.text.TX_API__awake_peer_ntf)) }
  ASSERT(SIZEOF(.text.TX_API__awake_peer_ntf) <= 136, "блок TX_API__awake_peer_ntf не влезает в отведённые ему 136 байт")
  .text.conn_mgr__awake_peer_ntf 0x008c36e0 : { KEEP(*(.text.conn_mgr__awake_peer_ntf)) }
  ASSERT(SIZEOF(.text.conn_mgr__awake_peer_ntf) <= 64, "блок conn_mgr__awake_peer_ntf не влезает в отведённые ему 64 байт")
  .text.get_g_80040c 0x008c3720 : { KEEP(*(.text.get_g_80040c)) }
  ASSERT(SIZEOF(.text.get_g_80040c) <= 4, "блок get_g_80040c не влезает в отведённые ему 4 байт")
  .text.sw_vring__ba_agreed 0x008c3724 : { KEEP(*(.text.sw_vring__ba_agreed)) }
  ASSERT(SIZEOF(.text.sw_vring__ba_agreed) <= 228, "блок sw_vring__ba_agreed не влезает в отведённые ему 228 байт")
  .text.ba__report_and_resume 0x008c3808 : { KEEP(*(.text.ba__report_and_resume)) }
  ASSERT(SIZEOF(.text.ba__report_and_resume) <= 44, "блок ba__report_and_resume не влезает в отведённые ему 44 байт")
  .text.frag_8c3834 0x008c3834 : { KEEP(*(.text.frag_8c3834)) }
  ASSERT(SIZEOF(.text.frag_8c3834) <= 4, "блок frag_8c3834 не влезает в отведённые ему 4 байт")
  .text.stream_mgr__ba_disable 0x008c3838 : { KEEP(*(.text.stream_mgr__ba_disable)) }
  ASSERT(SIZEOF(.text.stream_mgr__ba_disable) <= 76, "блок stream_mgr__ba_disable не влезает в отведённые ему 76 байт")
  .text.vring_ba_en__race_check 0x008c3884 : { KEEP(*(.text.vring_ba_en__race_check)) }
  ASSERT(SIZEOF(.text.vring_ba_en__race_check) <= 72, "блок vring_ba_en__race_check не влезает в отведённые ему 72 байт")
  .text.ba__send_status_from_rec 0x008c38cc : { KEEP(*(.text.ba__send_status_from_rec)) }
  ASSERT(SIZEOF(.text.ba__send_status_from_rec) <= 16, "блок ba__send_status_from_rec не влезает в отведённые ему 16 байт")
  .text.ba__send_addba_resp 0x008c38dc : { KEEP(*(.text.ba__send_addba_resp)) }
  ASSERT(SIZEOF(.text.ba__send_addba_resp) <= 116, "блок ba__send_addba_resp не влезает в отведённые ему 116 байт")
  .text.ba_sm__setup_result 0x008c3950 : { KEEP(*(.text.ba_sm__setup_result)) }
  ASSERT(SIZEOF(.text.ba_sm__setup_result) <= 132, "блок ba_sm__setup_result не влезает в отведённые ему 132 байт")
  .text.frag_8c39d4 0x008c39d4 : { KEEP(*(.text.frag_8c39d4)) }
  ASSERT(SIZEOF(.text.frag_8c39d4) <= 4, "блок frag_8c39d4 не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_remove_stream 0x008c39d8 : { KEEP(*(.text.ba_sm__on_remove_stream)) }
  ASSERT(SIZEOF(.text.ba_sm__on_remove_stream) <= 12, "блок ba_sm__on_remove_stream не влезает в отведённые ему 12 байт")
  .text.frag_8c39e4 0x008c39e4 : { KEEP(*(.text.frag_8c39e4)) }
  ASSERT(SIZEOF(.text.frag_8c39e4) <= 4, "блок frag_8c39e4 не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_ba_setup_sm_abort_done 0x008c39e8 : { KEEP(*(.text.ba_sm__on_ba_setup_sm_abort_done)) }
  ASSERT(SIZEOF(.text.ba_sm__on_ba_setup_sm_abort_done) <= 12, "блок ba_sm__on_ba_setup_sm_abort_done не влезает в отведённые ему 12 байт")
  .text.vtbl__call_212_4 0x008c39f4 : { KEEP(*(.text.vtbl__call_212_4)) }
  ASSERT(SIZEOF(.text.vtbl__call_212_4) <= 12, "блок vtbl__call_212_4 не влезает в отведённые ему 12 байт")
  .text.vring__wait_macq_delete 0x008c3a00 : { KEEP(*(.text.vring__wait_macq_delete)) }
  ASSERT(SIZEOF(.text.vring__wait_macq_delete) <= 208, "блок vring__wait_macq_delete не влезает в отведённые ему 208 байт")
  .text.epi_8c3ad0 0x008c3ad0 : { KEEP(*(.text.epi_8c3ad0)) }
  ASSERT(SIZEOF(.text.epi_8c3ad0) <= 4, "блок epi_8c3ad0 не влезает в отведённые ему 4 байт")
  .text.instruction_error__report 0x008c3ad4 : { KEEP(*(.text.instruction_error__report)) }
  ASSERT(SIZEOF(.text.instruction_error__report) <= 116, "блок instruction_error__report не влезает в отведённые ему 116 байт")
  .text.rx_chain__configure 0x008c3b48 : { KEEP(*(.text.rx_chain__configure)) }
  ASSERT(SIZEOF(.text.rx_chain__configure) <= 76, "блок rx_chain__configure не влезает в отведённые ему 76 байт")
  .text.rx_chain__configure_b 0x008c3b94 : { KEEP(*(.text.rx_chain__configure_b)) }
  ASSERT(SIZEOF(.text.rx_chain__configure_b) <= 56, "блок rx_chain__configure_b не влезает в отведённые ему 56 байт")
  .text.tx_macq__config_queue_b 0x008c3bcc : { KEEP(*(.text.tx_macq__config_queue_b)) }
  ASSERT(SIZEOF(.text.tx_macq__config_queue_b) <= 72, "блок tx_macq__config_queue_b не влезает в отведённые ему 72 байт")
  .text.vring__wait_drain 0x008c3c14 : { KEEP(*(.text.vring__wait_drain)) }
  ASSERT(SIZEOF(.text.vring__wait_drain) <= 132, "блок vring__wait_drain не влезает в отведённые ему 132 байт")
  .text.bcn_tx_init_bi_cfg 0x008c3c98 : { KEEP(*(.text.bcn_tx_init_bi_cfg)) }
  ASSERT(SIZEOF(.text.bcn_tx_init_bi_cfg) <= 148, "блок bcn_tx_init_bi_cfg не влезает в отведённые ему 148 байт")
  .text.bcn_tx_init_ss_params 0x008c3d2c : { KEEP(*(.text.bcn_tx_init_ss_params)) }
  ASSERT(SIZEOF(.text.bcn_tx_init_ss_params) <= 276, "блок bcn_tx_init_ss_params не влезает в отведённые ему 276 байт")
  .text.linkup__check_pcp_assoc_ready 0x008c3e40 : { KEEP(*(.text.linkup__check_pcp_assoc_ready)) }
  ASSERT(SIZEOF(.text.linkup__check_pcp_assoc_ready) <= 140, "блок linkup__check_pcp_assoc_ready не влезает в отведённые ему 140 байт")
  .text.discovery__inject_sm_event 0x008c3ecc : { KEEP(*(.text.discovery__inject_sm_event)) }
  ASSERT(SIZEOF(.text.discovery__inject_sm_event) <= 32, "блок discovery__inject_sm_event не влезает в отведённые ему 32 байт")
  .text.frag_8c3eec 0x008c3eec : { KEEP(*(.text.frag_8c3eec)) }
  ASSERT(SIZEOF(.text.frag_8c3eec) <= 4, "блок frag_8c3eec не влезает в отведённые ему 4 байт")
  .text.conn_main_sm__bcon_rx_timeout_evt 0x008c3ef0 : { KEEP(*(.text.conn_main_sm__bcon_rx_timeout_evt)) }
  ASSERT(SIZEOF(.text.conn_main_sm__bcon_rx_timeout_evt) <= 44, "блок conn_main_sm__bcon_rx_timeout_evt не влезает в отведённые ему 44 байт")
  .text.stub_ret_8c3f1c 0x008c3f1c : { KEEP(*(.text.stub_ret_8c3f1c)) }
  ASSERT(SIZEOF(.text.stub_ret_8c3f1c) <= 4, "блок stub_ret_8c3f1c не влезает в отведённые ему 4 байт")
  .text.conn_main_sm__bf_ntf 0x008c3f20 : { KEEP(*(.text.conn_main_sm__bf_ntf)) }
  ASSERT(SIZEOF(.text.conn_main_sm__bf_ntf) <= 44, "блок conn_main_sm__bf_ntf не влезает в отведённые ему 44 байт")
  .text.find_mngr__link_up 0x008c3f4c : { KEEP(*(.text.find_mngr__link_up)) }
  ASSERT(SIZEOF(.text.find_mngr__link_up) <= 52, "блок find_mngr__link_up не влезает в отведённые ему 52 байт")
  .text.bf__fail_retrying 0x008c3f80 : { KEEP(*(.text.bf__fail_retrying)) }
  ASSERT(SIZEOF(.text.bf__fail_retrying) <= 92, "блок bf__fail_retrying не влезает в отведённые ему 92 байт")
  .text.sm_pring__bind_vring 0x008c3fdc : { KEEP(*(.text.sm_pring__bind_vring)) }
  ASSERT(SIZEOF(.text.sm_pring__bind_vring) <= 700, "блок sm_pring__bind_vring не влезает в отведённые ему 700 байт")
  .text.bss_bi_ctrl_PCP_ready_set 0x008c4298 : { KEEP(*(.text.bss_bi_ctrl_PCP_ready_set)) }
  ASSERT(SIZEOF(.text.bss_bi_ctrl_PCP_ready_set) <= 60, "блок bss_bi_ctrl_PCP_ready_set не влезает в отведённые ему 60 байт")
  .text.bcon_tx_build_step 0x008c42d4 : { KEEP(*(.text.bcon_tx_build_step)) }
  ASSERT(SIZEOF(.text.bcon_tx_build_step) <= 184, "блок bcon_tx_build_step не влезает в отведённые ему 184 байт")
  .text.bss_set_mode__capinfo 0x008c438c : { KEEP(*(.text.bss_set_mode__capinfo)) }
  ASSERT(SIZEOF(.text.bss_set_mode__capinfo) <= 80, "блок bss_set_mode__capinfo не влезает в отведённые ему 80 байт")
  .text.l2mgr_mac_start_step 0x008c43dc : { KEEP(*(.text.l2mgr_mac_start_step)) }
  ASSERT(SIZEOF(.text.l2mgr_mac_start_step) <= 188, "блок l2mgr_mac_start_step не влезает в отведённые ему 188 байт")
  .text.mid__reset_ssid 0x008c4498 : { KEEP(*(.text.mid__reset_ssid)) }
  ASSERT(SIZEOF(.text.mid__reset_ssid) <= 12, "блок mid__reset_ssid не влезает в отведённые ему 12 байт")
  .text.mid__reset_10b_at_248 0x008c44a4 : { KEEP(*(.text.mid__reset_10b_at_248)) }
  ASSERT(SIZEOF(.text.mid__reset_10b_at_248) <= 28, "блок mid__reset_10b_at_248 не влезает в отведённые ему 28 байт")
  .text.mid__reset_ie_area 0x008c44c0 : { KEEP(*(.text.mid__reset_ie_area)) }
  ASSERT(SIZEOF(.text.mid__reset_ie_area) <= 44, "блок mid__reset_ie_area не влезает в отведённые ему 44 байт")
  .text.mlme_sm__check_assoc_capacity 0x008c44ec : { KEEP(*(.text.mlme_sm__check_assoc_capacity)) }
  ASSERT(SIZEOF(.text.mlme_sm__check_assoc_capacity) <= 52, "блок mlme_sm__check_assoc_capacity не влезает в отведённые ему 52 байт")
  .text.bss_join_verify 0x008c4520 : { KEEP(*(.text.bss_join_verify)) }
  ASSERT(SIZEOF(.text.bss_join_verify) <= 76, "блок bss_join_verify не влезает в отведённые ему 76 байт")
  .text.obj__set_field4_one 0x008c458c : { KEEP(*(.text.obj__set_field4_one)) }
  ASSERT(SIZEOF(.text.obj__set_field4_one) <= 8, "блок obj__set_field4_one не влезает в отведённые ему 8 байт")
  .text.bss_set_mode 0x008c4594 : { KEEP(*(.text.bss_set_mode)) }
  ASSERT(SIZEOF(.text.bss_set_mode) <= 52, "блок bss_set_mode не влезает в отведённые ему 52 байт")
  .text.vring_ba__fill_fields 0x008c45c8 : { KEEP(*(.text.vring_ba__fill_fields)) }
  ASSERT(SIZEOF(.text.vring_ba__fill_fields) <= 220, "блок vring_ba__fill_fields не влезает в отведённые ему 220 байт")
  .text.mac_indirect__write_entry 0x008c46a4 : { KEEP(*(.text.mac_indirect__write_entry)) }
  ASSERT(SIZEOF(.text.mac_indirect__write_entry) <= 196, "блок mac_indirect__write_entry не влезает в отведённые ему 196 байт")
  .text.vring__write_macq_desc 0x008c4768 : { KEEP(*(.text.vring__write_macq_desc)) }
  ASSERT(SIZEOF(.text.vring__write_macq_desc) <= 176, "блок vring__write_macq_desc не влезает в отведённые ему 176 байт")
  .text.rf_chain__pack_dist_cfg 0x008c4818 : { KEEP(*(.text.rf_chain__pack_dist_cfg)) }
  ASSERT(SIZEOF(.text.rf_chain__pack_dist_cfg) <= 100, "блок rf_chain__pack_dist_cfg не влезает в отведённые ему 100 байт")
  .text.mem_pool__link_free_list 0x008c487c : { KEEP(*(.text.mem_pool__link_free_list)) }
  ASSERT(SIZEOF(.text.mem_pool__link_free_list) <= 24, "блок mem_pool__link_free_list не влезает в отведённые ему 24 байт")
  .text.brd_if__chunk_offset 0x008c4894 : { KEEP(*(.text.brd_if__chunk_offset)) }
  ASSERT(SIZEOF(.text.brd_if__chunk_offset) <= 88, "блок brd_if__chunk_offset не влезает в отведённые ему 88 байт")
  .text.link_stats__calc_goodput 0x008c48ec : { KEEP(*(.text.link_stats__calc_goodput)) }
  ASSERT(SIZEOF(.text.link_stats__calc_goodput) <= 76, "блок link_stats__calc_goodput не влезает в отведённые ему 76 байт")
  .text.connection__update_rs_metric 0x008c4938 : { KEEP(*(.text.connection__update_rs_metric)) }
  ASSERT(SIZEOF(.text.connection__update_rs_metric) <= 88, "блок connection__update_rs_metric не влезает в отведённые ему 88 байт")
  .text.connection__on_bf_result 0x008c4990 : { KEEP(*(.text.connection__on_bf_result)) }
  ASSERT(SIZEOF(.text.connection__on_bf_result) <= 112, "блок connection__on_bf_result не влезает в отведённые ему 112 байт")
  .text.link_stats__calc_throughput_mbps 0x008c4a00 : { KEEP(*(.text.link_stats__calc_throughput_mbps)) }
  ASSERT(SIZEOF(.text.link_stats__calc_throughput_mbps) <= 64, "блок link_stats__calc_throughput_mbps не влезает в отведённые ему 64 байт")
  .text.pcp_factor_evt_step 0x008c4a40 : { KEEP(*(.text.pcp_factor_evt_step)) }
  ASSERT(SIZEOF(.text.pcp_factor_evt_step) <= 152, "блок pcp_factor_evt_step не влезает в отведённые ему 152 байт")
  .text.calib_engine__on_calib_done 0x008c4ad8 : { KEEP(*(.text.calib_engine__on_calib_done)) }
  ASSERT(SIZEOF(.text.calib_engine__on_calib_done) <= 16, "блок calib_engine__on_calib_done не влезает в отведённые ему 16 байт")
  .text.calib_mngr__log_scheme 0x008c4ae8 : { KEEP(*(.text.calib_mngr__log_scheme)) }
  ASSERT(SIZEOF(.text.calib_mngr__log_scheme) <= 76, "блок calib_mngr__log_scheme не влезает в отведённые ему 76 байт")
  .text.calib_mngr__reset_scheme 0x008c4b34 : { KEEP(*(.text.calib_mngr__reset_scheme)) }
  ASSERT(SIZEOF(.text.calib_mngr__reset_scheme) <= 140, "блок calib_mngr__reset_scheme не влезает в отведённые ему 140 байт")
  .text.rm_main_sm__call_cb 0x008c4bc0 : { KEEP(*(.text.rm_main_sm__call_cb)) }
  ASSERT(SIZEOF(.text.rm_main_sm__call_cb) <= 128, "блок rm_main_sm__call_cb не влезает в отведённые ему 128 байт")
  .text.TX_API__call_mem_pool_alloc_err_cb 0x008c4c40 : { KEEP(*(.text.TX_API__call_mem_pool_alloc_err_cb)) }
  ASSERT(SIZEOF(.text.TX_API__call_mem_pool_alloc_err_cb) <= 100, "блок TX_API__call_mem_pool_alloc_err_cb не влезает в отведённые ему 100 байт")
  .text.epi_8c4ca4 0x008c4ca4 : { KEEP(*(.text.epi_8c4ca4)) }
  ASSERT(SIZEOF(.text.epi_8c4ca4) <= 4, "блок epi_8c4ca4 не влезает в отведённые ему 4 байт")
  .text.TX_API__callback_and_release 0x008c4ca8 : { KEEP(*(.text.TX_API__callback_and_release)) }
  ASSERT(SIZEOF(.text.TX_API__callback_and_release) <= 120, "блок TX_API__callback_and_release не влезает в отведённые ему 120 байт")
  .text.sm_pring__get_vring 0x008c4d20 : { KEEP(*(.text.sm_pring__get_vring)) }
  ASSERT(SIZEOF(.text.sm_pring__get_vring) <= 88, "блок sm_pring__get_vring не влезает в отведённые ему 88 байт")
  .text.periodic_service__reset_tick 0x008c4d78 : { KEEP(*(.text.periodic_service__reset_tick)) }
  ASSERT(SIZEOF(.text.periodic_service__reset_tick) <= 56, "блок periodic_service__reset_tick не влезает в отведённые ему 56 байт")
  .text.rm_ch_switch_sm__notify_ch_switch_done 0x008c4db0 : { KEEP(*(.text.rm_ch_switch_sm__notify_ch_switch_done)) }
  ASSERT(SIZEOF(.text.rm_ch_switch_sm__notify_ch_switch_done) <= 48, "блок rm_ch_switch_sm__notify_ch_switch_done не влезает в отведённые ему 48 байт")
  .text.rm_chan_sw_sm__on_ch_switch_kick 0x008c4de0 : { KEEP(*(.text.rm_chan_sw_sm__on_ch_switch_kick)) }
  ASSERT(SIZEOF(.text.rm_chan_sw_sm__on_ch_switch_kick) <= 64, "блок rm_chan_sw_sm__on_ch_switch_kick не влезает в отведённые ему 64 байт")
  .text.ps_conn_mgr__notify_all 0x008c4e20 : { KEEP(*(.text.ps_conn_mgr__notify_all)) }
  ASSERT(SIZEOF(.text.ps_conn_mgr__notify_all) <= 72, "блок ps_conn_mgr__notify_all не влезает в отведённые ему 72 байт")
  .text.class_calib_lo_power__change_state_by_temperature 0x008c4e68 : { KEEP(*(.text.class_calib_lo_power__change_state_by_temperature)) }
  ASSERT(SIZEOF(.text.class_calib_lo_power__change_state_by_temperature) <= 160, "блок class_calib_lo_power__change_state_by_temperature не влезает в отведённые ему 160 байт")
  .text.mlme_sm__send_assoc 0x008c4f08 : { KEEP(*(.text.mlme_sm__send_assoc)) }
  ASSERT(SIZEOF(.text.mlme_sm__send_assoc) <= 268, "блок mlme_sm__send_assoc не влезает в отведённые ему 268 байт")
  .text.maintain__trigger_bf 0x008c5014 : { KEEP(*(.text.maintain__trigger_bf)) }
  ASSERT(SIZEOF(.text.maintain__trigger_bf) <= 32, "блок maintain__trigger_bf не влезает в отведённые ему 32 байт")
  .text.calib_mngr__switch_channel 0x008c5034 : { KEEP(*(.text.calib_mngr__switch_channel)) }
  ASSERT(SIZEOF(.text.calib_mngr__switch_channel) <= 176, "блок calib_mngr__switch_channel не влезает в отведённые ему 176 байт")
  .text.maintain_sm__check_bad_link 0x008c50e4 : { KEEP(*(.text.maintain_sm__check_bad_link)) }
  ASSERT(SIZEOF(.text.maintain_sm__check_bad_link) <= 156, "блок maintain_sm__check_bad_link не влезает в отведённые ему 156 байт")
  .text.calib_engine_sm__check_correction_needed 0x008c5180 : { KEEP(*(.text.calib_engine_sm__check_correction_needed)) }
  ASSERT(SIZEOF(.text.calib_engine_sm__check_correction_needed) <= 192, "блок calib_engine_sm__check_correction_needed не влезает в отведённые ему 192 байт")
  .text.frag_8c5240 0x008c5240 : { KEEP(*(.text.frag_8c5240)) }
  ASSERT(SIZEOF(.text.frag_8c5240) <= 4, "блок frag_8c5240 не влезает в отведённые ему 4 байт")
  .text.SDP__sdp_init 0x008c5244 : { KEEP(*(.text.SDP__sdp_init)) }
  ASSERT(SIZEOF(.text.SDP__sdp_init) <= 108, "блок SDP__sdp_init не влезает в отведённые ему 108 байт")
  .text.wmi_handler_get_rf_sector_params__check_inputs_valid 0x008c52b0 : { KEEP(*(.text.wmi_handler_get_rf_sector_params__check_inputs_valid)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_rf_sector_params__check_inputs_valid) <= 168, "блок wmi_handler_get_rf_sector_params__check_inputs_valid не влезает в отведённые ему 168 байт")
  .text.wmi_handler_set_rf_sector_params__verify_inputs 0x008c5358 : { KEEP(*(.text.wmi_handler_set_rf_sector_params__verify_inputs)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_rf_sector_params__verify_inputs) <= 168, "блок wmi_handler_set_rf_sector_params__verify_inputs не влезает в отведённые ему 168 байт")
  .text.wmi_handler_get_selected_rf_sector_index__check_inputs_valid 0x008c5400 : { KEEP(*(.text.wmi_handler_get_selected_rf_sector_index__check_inputs_valid)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_selected_rf_sector_index__check_inputs_valid) <= 140, "блок wmi_handler_get_selected_rf_sector_index__check_inputs_valid не влезает в отведённые ему 140 байт")
  .text.wmi_handler_set_selected_rf_sector_index__check_inputs_valid 0x008c548c : { KEEP(*(.text.wmi_handler_set_selected_rf_sector_index__check_inputs_valid)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_selected_rf_sector_index__check_inputs_valid) <= 200, "блок wmi_handler_set_selected_rf_sector_index__check_inputs_valid не влезает в отведённые ему 200 байт")
  .text.check_memory_resource_timeout_cb 0x008c5554 : { KEEP(*(.text.check_memory_resource_timeout_cb)) }
  ASSERT(SIZEOF(.text.check_memory_resource_timeout_cb) <= 60, "блок check_memory_resource_timeout_cb не влезает в отведённые ему 60 байт")
  .text.frag_8c5590 0x008c5590 : { KEEP(*(.text.frag_8c5590)) }
  ASSERT(SIZEOF(.text.frag_8c5590) <= 8, "блок frag_8c5590 не влезает в отведённые ему 8 байт")
  .text.calib_bb_gain_dc__check_online_estimation_condition 0x008c5598 : { KEEP(*(.text.calib_bb_gain_dc__check_online_estimation_condition)) }
  ASSERT(SIZEOF(.text.calib_bb_gain_dc__check_online_estimation_condition) <= 44, "блок calib_bb_gain_dc__check_online_estimation_condition не влезает в отведённые ему 44 байт")
  .text.u_schd__run_expired 0x008c55c4 : { KEEP(*(.text.u_schd__run_expired)) }
  ASSERT(SIZEOF(.text.u_schd__run_expired) <= 80, "блок u_schd__run_expired не влезает в отведённые ему 80 байт")
  .text.brd_if_multi_array__check_physical_section_validity 0x008c5614 : { KEEP(*(.text.brd_if_multi_array__check_physical_section_validity)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__check_physical_section_validity) <= 300, "блок brd_if_multi_array__check_physical_section_validity не влезает в отведённые ему 300 байт")
  .text.mem_pool__put_block 0x008c5740 : { KEEP(*(.text.mem_pool__put_block)) }
  ASSERT(SIZEOF(.text.mem_pool__put_block) <= 28, "блок mem_pool__put_block не влезает в отведённые ему 28 байт")
  .text.brd_if__section_matches_bank 0x008c575c : { KEEP(*(.text.brd_if__section_matches_bank)) }
  ASSERT(SIZEOF(.text.brd_if__section_matches_bank) <= 60, "блок brd_if__section_matches_bank не влезает в отведённые ему 60 байт")
  .text.calib_base__vt14 0x008c5798 : { KEEP(*(.text.calib_base__vt14)) }
  ASSERT(SIZEOF(.text.calib_base__vt14) <= 24, "блок calib_base__vt14 не влезает в отведённые ему 24 байт")
  .text.rm_ch_switch_sm__check_turn_completed 0x008c57b0 : { KEEP(*(.text.rm_ch_switch_sm__check_turn_completed)) }
  ASSERT(SIZEOF(.text.rm_ch_switch_sm__check_turn_completed) <= 84, "блок rm_ch_switch_sm__check_turn_completed не влезает в отведённые ему 84 байт")
  .text.u_schd__invoke_callback 0x008c5804 : { KEEP(*(.text.u_schd__invoke_callback)) }
  ASSERT(SIZEOF(.text.u_schd__invoke_callback) <= 32, "блок u_schd__invoke_callback не влезает в отведённые ему 32 байт")
  .text.get_g_8000ac_8c5824 0x008c5824 : { KEEP(*(.text.get_g_8000ac_8c5824)) }
  ASSERT(SIZEOF(.text.get_g_8000ac_8c5824) <= 20, "блок get_g_8000ac_8c5824 не влезает в отведённые ему 20 байт")
  .text.l2_mgr__chk_sys_idle 0x008c5838 : { KEEP(*(.text.l2_mgr__chk_sys_idle)) }
  ASSERT(SIZEOF(.text.l2_mgr__chk_sys_idle) <= 84, "блок l2_mgr__chk_sys_idle не влезает в отведённые ему 84 байт")
  .text.vring_schd__is_vring_ready 0x008c588c : { KEEP(*(.text.vring_schd__is_vring_ready)) }
  ASSERT(SIZEOF(.text.vring_schd__is_vring_ready) <= 16, "блок vring_schd__is_vring_ready не влезает в отведённые ему 16 байт")
  .text.conn_mgr__find_reusable_cid 0x008c589c : { KEEP(*(.text.conn_mgr__find_reusable_cid)) }
  ASSERT(SIZEOF(.text.conn_mgr__find_reusable_cid) <= 156, "блок conn_mgr__find_reusable_cid не влезает в отведённые ему 156 байт")
  .text.fwq_tx__long_retry_failures 0x008c5938 : { KEEP(*(.text.fwq_tx__long_retry_failures)) }
  ASSERT(SIZEOF(.text.fwq_tx__long_retry_failures) <= 200, "блок fwq_tx__long_retry_failures не влезает в отведённые ему 200 байт")
  .text.app_ies__clear 0x008c5a00 : { KEEP(*(.text.app_ies__clear)) }
  ASSERT(SIZEOF(.text.app_ies__clear) <= 12, "блок app_ies__clear не влезает в отведённые ему 12 байт")
  .text.brd_if__clear_block_info 0x008c5a0c : { KEEP(*(.text.brd_if__clear_block_info)) }
  ASSERT(SIZEOF(.text.brd_if__clear_block_info) <= 20, "блок brd_if__clear_block_info не влезает в отведённые ему 20 байт")
  .text.brd_if__clear_section_info 0x008c5a20 : { KEEP(*(.text.brd_if__clear_section_info)) }
  ASSERT(SIZEOF(.text.brd_if__clear_section_info) <= 16, "блок brd_if__clear_section_info не влезает в отведённые ему 16 байт")
  .text.stub_ret_8c5a30 0x008c5a30 : { KEEP(*(.text.stub_ret_8c5a30)) }
  ASSERT(SIZEOF(.text.stub_ret_8c5a30) <= 4, "блок stub_ret_8c5a30 не влезает в отведённые ему 4 байт")
  .text.bad_beacons_detector__configure 0x008c5a34 : { KEEP(*(.text.bad_beacons_detector__configure)) }
  ASSERT(SIZEOF(.text.bad_beacons_detector__configure) <= 60, "блок bad_beacons_detector__configure не влезает в отведённые ему 60 байт")
  .text.ka_detector__configure 0x008c5a70 : { KEEP(*(.text.ka_detector__configure)) }
  ASSERT(SIZEOF(.text.ka_detector__configure) <= 92, "блок ka_detector__configure не влезает в отведённые ему 92 байт")
  .text.ageing_detector__configure 0x008c5acc : { KEEP(*(.text.ageing_detector__configure)) }
  ASSERT(SIZEOF(.text.ageing_detector__configure) <= 76, "блок ageing_detector__configure не влезает в отведённые ему 76 байт")
  .text.mlme__free_assoc_buf 0x008c5b18 : { KEEP(*(.text.mlme__free_assoc_buf)) }
  ASSERT(SIZEOF(.text.mlme__free_assoc_buf) <= 24, "блок mlme__free_assoc_buf не влезает в отведённые ему 24 байт")
  .text.conn__cancel_retry_timer 0x008c5b30 : { KEEP(*(.text.conn__cancel_retry_timer)) }
  ASSERT(SIZEOF(.text.conn__cancel_retry_timer) <= 24, "блок conn__cancel_retry_timer не влезает в отведённые ему 24 байт")
  .text.calib_mngr__cancel_scheme_step 0x008c5b48 : { KEEP(*(.text.calib_mngr__cancel_scheme_step)) }
  ASSERT(SIZEOF(.text.calib_mngr__cancel_scheme_step) <= 64, "блок calib_mngr__cancel_scheme_step не влезает в отведённые ему 64 байт")
  .text.mid__clear_flag_1c9 0x008c5b88 : { KEEP(*(.text.mid__clear_flag_1c9)) }
  ASSERT(SIZEOF(.text.mid__clear_flag_1c9) <= 12, "блок mid__clear_flag_1c9 не влезает в отведённые ему 12 байт")
  .text.vring__teardown 0x008c5b94 : { KEEP(*(.text.vring__teardown)) }
  ASSERT(SIZEOF(.text.vring__teardown) <= 92, "блок vring__teardown не влезает в отведённые ему 92 байт")
  .text.psc__inject_disassoc_evt 0x008c5bf0 : { KEEP(*(.text.psc__inject_disassoc_evt)) }
  ASSERT(SIZEOF(.text.psc__inject_disassoc_evt) <= 28, "блок psc__inject_disassoc_evt не влезает в отведённые ему 28 байт")
  .text.sta_psc_sm__m_psc_resp_rx_wb_timeout_event 0x008c5c0c : { KEEP(*(.text.sta_psc_sm__m_psc_resp_rx_wb_timeout_event)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__m_psc_resp_rx_wb_timeout_event) <= 36, "блок sta_psc_sm__m_psc_resp_rx_wb_timeout_event не влезает в отведённые ему 36 байт")
  .text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event 0x008c5c30 : { KEEP(*(.text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event) <= 8, "блок pcp_psc_sm__m_psc_resp_tx_wb_timeout_event не влезает в отведённые ему 8 байт")
  .text.sta_psc_sm__on_close 0x008c5c38 : { KEEP(*(.text.sta_psc_sm__on_close)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__on_close) <= 20, "блок sta_psc_sm__on_close не влезает в отведённые ему 20 байт")
  .text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c 0x008c5c4c : { KEEP(*(.text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c) <= 40, "блок pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c не влезает в отведённые ему 40 байт")
  .text.sta_psc_sm__m_psc_req_tx_wb_timeout_event 0x008c5c74 : { KEEP(*(.text.sta_psc_sm__m_psc_req_tx_wb_timeout_event)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__m_psc_req_tx_wb_timeout_event) <= 40, "блок sta_psc_sm__m_psc_req_tx_wb_timeout_event не влезает в отведённые ему 40 байт")
  .text.get_g_8000ac_8c5c9c 0x008c5c9c : { KEEP(*(.text.get_g_8000ac_8c5c9c)) }
  ASSERT(SIZEOF(.text.get_g_8000ac_8c5c9c) <= 16, "блок get_g_8000ac_8c5c9c не влезает в отведённые ему 16 байт")
  .text.rf_comm_test 0x008c5cac : { KEEP(*(.text.rf_comm_test)) }
  ASSERT(SIZEOF(.text.rf_comm_test) <= 188, "блок rf_comm_test не влезает в отведённые ему 188 байт")
  .text.brd_if__scan_sections 0x008c5d68 : { KEEP(*(.text.brd_if__scan_sections)) }
  ASSERT(SIZEOF(.text.brd_if__scan_sections) <= 80, "блок brd_if__scan_sections не влезает в отведённые ему 80 байт")
  .text.frag_8c5db8 0x008c5db8 : { KEEP(*(.text.frag_8c5db8)) }
  ASSERT(SIZEOF(.text.frag_8c5db8) <= 60, "блок frag_8c5db8 не влезает в отведённые ему 60 байт")
  .text.find_mngr__cfg_offload 0x008c5df4 : { KEEP(*(.text.find_mngr__cfg_offload)) }
  ASSERT(SIZEOF(.text.find_mngr__cfg_offload) <= 148, "блок find_mngr__cfg_offload не влезает в отведённые ему 148 байт")
  .text.vring__program_tx_desc_and_ba 0x008c5e88 : { KEEP(*(.text.vring__program_tx_desc_and_ba)) }
  ASSERT(SIZEOF(.text.vring__program_tx_desc_and_ba) <= 60, "блок vring__program_tx_desc_and_ba не влезает в отведённые ему 60 байт")
  .text.calib_silent_rssi_sparrow 0x008c5ec4 : { KEEP(*(.text.calib_silent_rssi_sparrow)) }
  ASSERT(SIZEOF(.text.calib_silent_rssi_sparrow) <= 76, "блок calib_silent_rssi_sparrow не влезает в отведённые ему 76 байт")
  .text.maintain_sm__set_rs_params_at34 0x008c5f10 : { KEEP(*(.text.maintain_sm__set_rs_params_at34)) }
  ASSERT(SIZEOF(.text.maintain_sm__set_rs_params_at34) <= 8, "блок maintain_sm__set_rs_params_at34 не влезает в отведённые ему 8 байт")
  .text.marlon_r_if_class__config_brp_sectors 0x008c5f18 : { KEEP(*(.text.marlon_r_if_class__config_brp_sectors)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__config_brp_sectors) <= 304, "блок marlon_r_if_class__config_brp_sectors не влезает в отведённые ему 304 байт")
  .text.marlon_r_if_class__config_channel 0x008c6048 : { KEEP(*(.text.marlon_r_if_class__config_channel)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__config_channel) <= 180, "блок marlon_r_if_class__config_channel не влезает в отведённые ему 180 байт")
  .text.sw_vring__set_ba_params 0x008c60fc : { KEEP(*(.text.sw_vring__set_ba_params)) }
  ASSERT(SIZEOF(.text.sw_vring__set_ba_params) <= 32, "блок sw_vring__set_ba_params не влезает в отведённые ему 32 байт")
  .text.dma_mgr__configure_ring 0x008c611c : { KEEP(*(.text.dma_mgr__configure_ring)) }
  ASSERT(SIZEOF(.text.dma_mgr__configure_ring) <= 320, "блок dma_mgr__configure_ring не влезает в отведённые ему 320 байт")
  .text.lm_main_sm__config_lmac_bf_sm 0x008c625c : { KEEP(*(.text.lm_main_sm__config_lmac_bf_sm)) }
  ASSERT(SIZEOF(.text.lm_main_sm__config_lmac_bf_sm) <= 72, "блок lm_main_sm__config_lmac_bf_sm не влезает в отведённые ему 72 байт")
  .text.maintain_sm__config_mcs_en_vec 0x008c62a4 : { KEEP(*(.text.maintain_sm__config_mcs_en_vec)) }
  ASSERT(SIZEOF(.text.maintain_sm__config_mcs_en_vec) <= 92, "блок maintain_sm__config_mcs_en_vec не влезает в отведённые ему 92 байт")
  .text.vring_schd__bind_if_free 0x008c6300 : { KEEP(*(.text.vring_schd__bind_if_free)) }
  ASSERT(SIZEOF(.text.vring_schd__bind_if_free) <= 84, "блок vring_schd__bind_if_free не влезает в отведённые ему 84 байт")
  .text.mid__connect 0x008c6354 : { KEEP(*(.text.mid__connect)) }
  ASSERT(SIZEOF(.text.mid__connect) <= 80, "блок mid__connect не влезает в отведённые ему 80 байт")
  .text.tail_lmac_if_send_cmd_0x1b 0x008c63a4 : { KEEP(*(.text.tail_lmac_if_send_cmd_0x1b)) }
  ASSERT(SIZEOF(.text.tail_lmac_if_send_cmd_0x1b) <= 12, "блок tail_lmac_if_send_cmd_0x1b не влезает в отведённые ему 12 байт")
  .text.maintain_sm__on_consecutive_high_per 0x008c63b0 : { KEEP(*(.text.maintain_sm__on_consecutive_high_per)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_consecutive_high_per) <= 48, "блок maintain_sm__on_consecutive_high_per не влезает в отведённые ему 48 байт")
  .text.tx_send_packet_step 0x008c63e0 : { KEEP(*(.text.tx_send_packet_step)) }
  ASSERT(SIZEOF(.text.tx_send_packet_step) <= 132, "блок tx_send_packet_step не влезает в отведённые ему 132 байт")
  .text.TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters 0x008c6464 : { KEEP(*(.text.TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters)) }
  ASSERT(SIZEOF(.text.TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters) <= 88, "блок TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters не влезает в отведённые ему 88 байт")
  .text.rf__check_state 0x008c64bc : { KEEP(*(.text.rf__check_state)) }
  ASSERT(SIZEOF(.text.rf__check_state) <= 56, "блок rf__check_state не влезает в отведённые ему 56 байт")
  .text.lut__find_index 0x008c64f4 : { KEEP(*(.text.lut__find_index)) }
  ASSERT(SIZEOF(.text.lut__find_index) <= 72, "блок lut__find_index не влезает в отведённые ему 72 байт")
  .text.conn__threshold_to_offset 0x008c653c : { KEEP(*(.text.conn__threshold_to_offset)) }
  ASSERT(SIZEOF(.text.conn__threshold_to_offset) <= 32, "блок conn__threshold_to_offset не влезает в отведённые ему 32 байт")
  .text.mid__lookup_for_tx 0x008c655c : { KEEP(*(.text.mid__lookup_for_tx)) }
  ASSERT(SIZEOF(.text.mid__lookup_for_tx) <= 124, "блок mid__lookup_for_tx не влезает в отведённые ему 124 байт")
  .text.calib_engine__step 0x008c65d8 : { KEEP(*(.text.calib_engine__step)) }
  ASSERT(SIZEOF(.text.calib_engine__step) <= 204, "блок calib_engine__step не влезает в отведённые ему 204 байт")
  .text.basic_calib__run_step 0x008c66a4 : { KEEP(*(.text.basic_calib__run_step)) }
  ASSERT(SIZEOF(.text.basic_calib__run_step) <= 84, "блок basic_calib__run_step не влезает в отведённые ему 84 байт")
  .text.calib_sar__vt1c 0x008c66f8 : { KEEP(*(.text.calib_sar__vt1c)) }
  ASSERT(SIZEOF(.text.calib_sar__vt1c) <= 24, "блок calib_sar__vt1c не влезает в отведённые ему 24 байт")
  .text.class_calib_lo_power__correction_alg 0x008c6710 : { KEEP(*(.text.class_calib_lo_power__correction_alg)) }
  ASSERT(SIZEOF(.text.class_calib_lo_power__correction_alg) <= 4, "блок class_calib_lo_power__correction_alg не влезает в отведённые ему 4 байт")
  .text.calib_lo_power__correction_alg 0x008c6714 : { KEEP(*(.text.calib_lo_power__correction_alg)) }
  ASSERT(SIZEOF(.text.calib_lo_power__correction_alg) <= 124, "блок calib_lo_power__correction_alg не влезает в отведённые ему 124 байт")
  .text.frag_8c6790 0x008c6790 : { KEEP(*(.text.frag_8c6790)) }
  ASSERT(SIZEOF(.text.frag_8c6790) <= 4, "блок frag_8c6790 не влезает в отведённые ему 4 байт")
  .text.hwf_calib_lo_leakage_res 0x008c6794 : { KEEP(*(.text.hwf_calib_lo_leakage_res)) }
  ASSERT(SIZEOF(.text.hwf_calib_lo_leakage_res) <= 340, "блок hwf_calib_lo_leakage_res не влезает в отведённые ему 340 байт")
  .text.calib_if_gain__vt1c 0x008c68e8 : { KEEP(*(.text.calib_if_gain__vt1c)) }
  ASSERT(SIZEOF(.text.calib_if_gain__vt1c) <= 16, "блок calib_if_gain__vt1c не влезает в отведённые ему 16 байт")
  .text.hwf_vga_dc_fine 0x008c68f8 : { KEEP(*(.text.hwf_vga_dc_fine)) }
  ASSERT(SIZEOF(.text.hwf_vga_dc_fine) <= 4, "блок hwf_vga_dc_fine не влезает в отведённые ему 4 байт")
  .text.calib_bb_gain_dc__vga_dc_fine 0x008c68fc : { KEEP(*(.text.calib_bb_gain_dc__vga_dc_fine)) }
  ASSERT(SIZEOF(.text.calib_bb_gain_dc__vga_dc_fine) <= 320, "блок calib_bb_gain_dc__vga_dc_fine не влезает в отведённые ему 320 байт")
  .text.calib_silent_rssi__vt1c 0x008c6a3c : { KEEP(*(.text.calib_silent_rssi__vt1c)) }
  ASSERT(SIZEOF(.text.calib_silent_rssi__vt1c) <= 48, "блок calib_silent_rssi__vt1c не влезает в отведённые ему 48 байт")
  .text.calib_sar__vt18 0x008c6a6c : { KEEP(*(.text.calib_sar__vt18)) }
  ASSERT(SIZEOF(.text.calib_sar__vt18) <= 72, "блок calib_sar__vt18 не влезает в отведённые ему 72 байт")
  .text.calib_lo_power__vt18 0x008c6ab4 : { KEEP(*(.text.calib_lo_power__vt18)) }
  ASSERT(SIZEOF(.text.calib_lo_power__vt18) <= 4, "блок calib_lo_power__vt18 не влезает в отведённые ему 4 байт")
  .text.epi_8c6ab8 0x008c6ab8 : { KEEP(*(.text.epi_8c6ab8)) }
  ASSERT(SIZEOF(.text.epi_8c6ab8) <= 4, "блок epi_8c6ab8 не влезает в отведённые ему 4 байт")
  .text.calib_mngr_step_b 0x008c6abc : { KEEP(*(.text.calib_mngr_step_b)) }
  ASSERT(SIZEOF(.text.calib_mngr_step_b) <= 156, "блок calib_mngr_step_b не влезает в отведённые ему 156 байт")
  .text.epi_8c6b58 0x008c6b58 : { KEEP(*(.text.epi_8c6b58)) }
  ASSERT(SIZEOF(.text.epi_8c6b58) <= 4, "блок epi_8c6b58 не влезает в отведённые ему 4 байт")
  .text.calib_if_gain__vt18 0x008c6b5c : { KEEP(*(.text.calib_if_gain__vt18)) }
  ASSERT(SIZEOF(.text.calib_if_gain__vt18) <= 16, "блок calib_if_gain__vt18 не влезает в отведённые ему 16 байт")
  .text.epi_8c6b6c 0x008c6b6c : { KEEP(*(.text.epi_8c6b6c)) }
  ASSERT(SIZEOF(.text.epi_8c6b6c) <= 4, "блок epi_8c6b6c не влезает в отведённые ему 4 байт")
  .text.calib_bb_gain_dc__vt18 0x008c6b70 : { KEEP(*(.text.calib_bb_gain_dc__vt18)) }
  ASSERT(SIZEOF(.text.calib_bb_gain_dc__vt18) <= 16, "блок calib_bb_gain_dc__vt18 не влезает в отведённые ему 16 байт")
  .text.epi_8c6b80 0x008c6b80 : { KEEP(*(.text.epi_8c6b80)) }
  ASSERT(SIZEOF(.text.epi_8c6b80) <= 4, "блок epi_8c6b80 не влезает в отведённые ему 4 байт")
  .text.calib_silent_rssi__vt18 0x008c6b84 : { KEEP(*(.text.calib_silent_rssi__vt18)) }
  ASSERT(SIZEOF(.text.calib_silent_rssi__vt18) <= 64, "блок calib_silent_rssi__vt18 не влезает в отведённые ему 64 байт")
  .text.calib_sar__vt20 0x008c6bc4 : { KEEP(*(.text.calib_sar__vt20)) }
  ASSERT(SIZEOF(.text.calib_sar__vt20) <= 16, "блок calib_sar__vt20 не влезает в отведённые ему 16 байт")
  .text.epi_8c6bd4 0x008c6bd4 : { KEEP(*(.text.epi_8c6bd4)) }
  ASSERT(SIZEOF(.text.epi_8c6bd4) <= 4, "блок epi_8c6bd4 не влезает в отведённые ему 4 байт")
  .text.calib_lo_power__vt20 0x008c6bd8 : { KEEP(*(.text.calib_lo_power__vt20)) }
  ASSERT(SIZEOF(.text.calib_lo_power__vt20) <= 4, "блок calib_lo_power__vt20 не влезает в отведённые ему 4 байт")
  .text.epi_8c6bdc 0x008c6bdc : { KEEP(*(.text.epi_8c6bdc)) }
  ASSERT(SIZEOF(.text.epi_8c6bdc) <= 4, "блок epi_8c6bdc не влезает в отведённые ему 4 байт")
  .text.calib_lo_leakage__vt20 0x008c6be0 : { KEEP(*(.text.calib_lo_leakage__vt20)) }
  ASSERT(SIZEOF(.text.calib_lo_leakage__vt20) <= 28, "блок calib_lo_leakage__vt20 не влезает в отведённые ему 28 байт")
  .text.epi_8c6bfc 0x008c6bfc : { KEEP(*(.text.epi_8c6bfc)) }
  ASSERT(SIZEOF(.text.epi_8c6bfc) <= 4, "блок epi_8c6bfc не влезает в отведённые ему 4 байт")
  .text.calib_if_gain__vt20 0x008c6c00 : { KEEP(*(.text.calib_if_gain__vt20)) }
  ASSERT(SIZEOF(.text.calib_if_gain__vt20) <= 16, "блок calib_if_gain__vt20 не влезает в отведённые ему 16 байт")
  .text.epi_8c6c10 0x008c6c10 : { KEEP(*(.text.epi_8c6c10)) }
  ASSERT(SIZEOF(.text.epi_8c6c10) <= 4, "блок epi_8c6c10 не влезает в отведённые ему 4 байт")
  .text.calib_bb_gain_dc__vt20 0x008c6c14 : { KEEP(*(.text.calib_bb_gain_dc__vt20)) }
  ASSERT(SIZEOF(.text.calib_bb_gain_dc__vt20) <= 16, "блок calib_bb_gain_dc__vt20 не влезает в отведённые ему 16 байт")
  .text.epi_8c6c24 0x008c6c24 : { KEEP(*(.text.epi_8c6c24)) }
  ASSERT(SIZEOF(.text.epi_8c6c24) <= 4, "блок epi_8c6c24 не влезает в отведённые ему 4 байт")
  .text.calib_silent_rssi__vt20 0x008c6c28 : { KEEP(*(.text.calib_silent_rssi__vt20)) }
  ASSERT(SIZEOF(.text.calib_silent_rssi__vt20) <= 12, "блок calib_silent_rssi__vt20 не влезает в отведённые ему 12 байт")
  .text.epi_8c6c34 0x008c6c34 : { KEEP(*(.text.epi_8c6c34)) }
  ASSERT(SIZEOF(.text.epi_8c6c34) <= 4, "блок epi_8c6c34 не влезает в отведённые ему 4 байт")
  .text.bit_length 0x008c6c38 : { KEEP(*(.text.bit_length)) }
  ASSERT(SIZEOF(.text.bit_length) <= 36, "блок bit_length не влезает в отведённые ему 36 байт")
  .text.popcount32 0x008c6c5c : { KEEP(*(.text.popcount32)) }
  ASSERT(SIZEOF(.text.popcount32) <= 20, "блок popcount32 не влезает в отведённые ему 20 байт")
  .text.mem_pool__init 0x008c6c70 : { KEEP(*(.text.mem_pool__init)) }
  ASSERT(SIZEOF(.text.mem_pool__init) <= 108, "блок mem_pool__init не влезает в отведённые ему 108 байт")
  .text.sw_vring__setup_ba_win 0x008c6cdc : { KEEP(*(.text.sw_vring__setup_ba_win)) }
  ASSERT(SIZEOF(.text.sw_vring__setup_ba_win) <= 68, "блок sw_vring__setup_ba_win не влезает в отведённые ему 68 байт")
  .text.rm_ch_switch_sm__bump_turn 0x008c6d20 : { KEEP(*(.text.rm_ch_switch_sm__bump_turn)) }
  ASSERT(SIZEOF(.text.rm_ch_switch_sm__bump_turn) <= 16, "блок rm_ch_switch_sm__bump_turn не влезает в отведённые ему 16 байт")
  .text.rm_ch_switch_sm__turn_step 0x008c6d30 : { KEEP(*(.text.rm_ch_switch_sm__turn_step)) }
  ASSERT(SIZEOF(.text.rm_ch_switch_sm__turn_step) <= 56, "блок rm_ch_switch_sm__turn_step не влезает в отведённые ему 56 байт")
  .text.find_mngr__detect_discovery_bcon 0x008c6d68 : { KEEP(*(.text.find_mngr__detect_discovery_bcon)) }
  ASSERT(SIZEOF(.text.find_mngr__detect_discovery_bcon) <= 96, "блок find_mngr__detect_discovery_bcon не влезает в отведённые ему 96 байт")
  .text.scan_mngr__dband_beacon_ind 0x008c6dc8 : { KEEP(*(.text.scan_mngr__dband_beacon_ind)) }
  ASSERT(SIZEOF(.text.scan_mngr__dband_beacon_ind) <= 480, "блок scan_mngr__dband_beacon_ind не влезает в отведённые ему 480 байт")
  .text.ps_mode_sm__ignored_agreed 0x008c6fa8 : { KEEP(*(.text.ps_mode_sm__ignored_agreed)) }
  ASSERT(SIZEOF(.text.ps_mode_sm__ignored_agreed) <= 12, "блок ps_mode_sm__ignored_agreed не влезает в отведённые ему 12 байт")
  .text.ps_mode_sm__ignored_ps_trigger_ 0x008c6fb4 : { KEEP(*(.text.ps_mode_sm__ignored_ps_trigger_)) }
  ASSERT(SIZEOF(.text.ps_mode_sm__ignored_ps_trigger_) <= 16, "блок ps_mode_sm__ignored_ps_trigger_ не влезает в отведённые ему 16 байт")
  .text.ps_mode_sm__ignored_rejected 0x008c6fc4 : { KEEP(*(.text.ps_mode_sm__ignored_rejected)) }
  ASSERT(SIZEOF(.text.ps_mode_sm__ignored_rejected) <= 20, "блок ps_mode_sm__ignored_rejected не влезает в отведённые ему 20 байт")
  .text.calib_lo_leakage_step 0x008c6fd8 : { KEEP(*(.text.calib_lo_leakage_step)) }
  ASSERT(SIZEOF(.text.calib_lo_leakage_step) <= 312, "блок calib_lo_leakage_step не влезает в отведённые ему 312 байт")
  .text.tx_api__stamp_seq_bytes 0x008c7110 : { KEEP(*(.text.tx_api__stamp_seq_bytes)) }
  ASSERT(SIZEOF(.text.tx_api__stamp_seq_bytes) <= 80, "блок tx_api__stamp_seq_bytes не влезает в отведённые ему 80 байт")
  .text.stub_ret_8c7160 0x008c7160 : { KEEP(*(.text.stub_ret_8c7160)) }
  ASSERT(SIZEOF(.text.stub_ret_8c7160) <= 4, "блок stub_ret_8c7160 не влезает в отведённые ему 4 байт")
  .text.connection__dec_stream_count 0x008c7164 : { KEEP(*(.text.connection__dec_stream_count)) }
  ASSERT(SIZEOF(.text.connection__dec_stream_count) <= 56, "блок connection__dec_stream_count не влезает в отведённые ему 56 байт")
  .text.lmac_if__send_echo 0x008c719c : { KEEP(*(.text.lmac_if__send_echo)) }
  ASSERT(SIZEOF(.text.lmac_if__send_echo) <= 28, "блок lmac_if__send_echo не влезает в отведённые ему 28 байт")
  .text.deep_sleep_enter 0x008c71b8 : { KEEP(*(.text.deep_sleep_enter)) }
  ASSERT(SIZEOF(.text.deep_sleep_enter) <= 540, "блок deep_sleep_enter не влезает в отведённые ему 540 байт")
  .text.POWER_MNGR__halt 0x008c73d4 : { KEEP(*(.text.POWER_MNGR__halt)) }
  ASSERT(SIZEOF(.text.POWER_MNGR__halt) <= 140, "блок POWER_MNGR__halt не влезает в отведённые ему 140 байт")
  .text.POWER_MNGR__deep_sleep_exit 0x008c7460 : { KEEP(*(.text.POWER_MNGR__deep_sleep_exit)) }
  ASSERT(SIZEOF(.text.POWER_MNGR__deep_sleep_exit) <= 108, "блок POWER_MNGR__deep_sleep_exit не влезает в отведённые ему 108 байт")
  .text.power_deep_sleep_exit_step 0x008c74cc : { KEEP(*(.text.power_deep_sleep_exit_step)) }
  ASSERT(SIZEOF(.text.power_deep_sleep_exit_step) <= 172, "блок power_deep_sleep_exit_step не влезает в отведённые ему 172 байт")
  .text.pbss__free_sta_slot 0x008c7594 : { KEEP(*(.text.pbss__free_sta_slot)) }
  ASSERT(SIZEOF(.text.pbss__free_sta_slot) <= 20, "блок pbss__free_sta_slot не влезает в отведённые ему 20 байт")
  .text.stream_mgr__on_delba_rx 0x008c75a8 : { KEEP(*(.text.stream_mgr__on_delba_rx)) }
  ASSERT(SIZEOF(.text.stream_mgr__on_delba_rx) <= 276, "блок stream_mgr__on_delba_rx не влезает в отведённые ему 276 байт")
  .text.stream_mgr__ba_teardown 0x008c76bc : { KEEP(*(.text.stream_mgr__ba_teardown)) }
  ASSERT(SIZEOF(.text.stream_mgr__ba_teardown) <= 76, "блок stream_mgr__ba_teardown не влезает в отведённые ему 76 байт")
  .text.tail_8c7708 0x008c7708 : { KEEP(*(.text.tail_8c7708)) }
  ASSERT(SIZEOF(.text.tail_8c7708) <= 4, "блок tail_8c7708 не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_delba_tx_complete 0x008c770c : { KEEP(*(.text.ba_sm__on_delba_tx_complete)) }
  ASSERT(SIZEOF(.text.ba_sm__on_delba_tx_complete) <= 16, "блок ba_sm__on_delba_tx_complete не влезает в отведённые ему 16 байт")
  .text.find_mngr__del_discovery_bcon 0x008c771c : { KEEP(*(.text.find_mngr__del_discovery_bcon)) }
  ASSERT(SIZEOF(.text.find_mngr__del_discovery_bcon) <= 48, "блок find_mngr__del_discovery_bcon не влезает в отведённые ему 48 байт")
  .text.stream_mgr__macq_removed 0x008c774c : { KEEP(*(.text.stream_mgr__macq_removed)) }
  ASSERT(SIZEOF(.text.stream_mgr__macq_removed) <= 72, "блок stream_mgr__macq_removed не влезает в отведённые ему 72 байт")
  .text.u_schd__cancel 0x008c7794 : { KEEP(*(.text.u_schd__cancel)) }
  ASSERT(SIZEOF(.text.u_schd__cancel) <= 168, "блок u_schd__cancel не влезает в отведённые ему 168 байт")
  .text.timer_task__cancel 0x008c783c : { KEEP(*(.text.timer_task__cancel)) }
  ASSERT(SIZEOF(.text.timer_task__cancel) <= 28, "блок timer_task__cancel не влезает в отведённые ему 28 байт")
  .text.vring_schd__remove_vring 0x008c7858 : { KEEP(*(.text.vring_schd__remove_vring)) }
  ASSERT(SIZEOF(.text.vring_schd__remove_vring) <= 44, "блок vring_schd__remove_vring не влезает в отведённые ему 44 байт")
  .text.bcast_vring__delete 0x008c7884 : { KEEP(*(.text.bcast_vring__delete)) }
  ASSERT(SIZEOF(.text.bcast_vring__delete) <= 128, "блок bcast_vring__delete не влезает в отведённые ему 128 байт")
  .text.vring_schd__unbind_vring 0x008c7904 : { KEEP(*(.text.vring_schd__unbind_vring)) }
  ASSERT(SIZEOF(.text.vring_schd__unbind_vring) <= 76, "блок vring_schd__unbind_vring не влезает в отведённые ему 76 байт")
  .text.lm_if__disable_link_loss_monitoring 0x008c7950 : { KEEP(*(.text.lm_if__disable_link_loss_monitoring)) }
  ASSERT(SIZEOF(.text.lm_if__disable_link_loss_monitoring) <= 52, "блок lm_if__disable_link_loss_monitoring не влезает в отведённые ему 52 байт")
  .text.set_g_80040c_x2 0x008c7984 : { KEEP(*(.text.set_g_80040c_x2)) }
  ASSERT(SIZEOF(.text.set_g_80040c_x2) <= 12, "блок set_g_80040c_x2 не влезает в отведённые ему 12 байт")
  .text.PS_CONNECTION__disassoc_ntf 0x008c7990 : { KEEP(*(.text.PS_CONNECTION__disassoc_ntf)) }
  ASSERT(SIZEOF(.text.PS_CONNECTION__disassoc_ntf) <= 52, "блок PS_CONNECTION__disassoc_ntf не влезает в отведённые ему 52 байт")
  .text.ps_conn_mgr__on_disassoc 0x008c79c4 : { KEEP(*(.text.ps_conn_mgr__on_disassoc)) }
  ASSERT(SIZEOF(.text.ps_conn_mgr__on_disassoc) <= 44, "блок ps_conn_mgr__on_disassoc не влезает в отведённые ему 44 байт")
  .text.stub_ret_8c79f0 0x008c79f0 : { KEEP(*(.text.stub_ret_8c79f0)) }
  ASSERT(SIZEOF(.text.stub_ret_8c79f0) <= 4, "блок stub_ret_8c79f0 не влезает в отведённые ему 4 байт")
  .text.conn_msm__on_ntf_disc_complete 0x008c79f4 : { KEEP(*(.text.conn_msm__on_ntf_disc_complete)) }
  ASSERT(SIZEOF(.text.conn_msm__on_ntf_disc_complete) <= 72, "блок conn_msm__on_ntf_disc_complete не влезает в отведённые ему 72 байт")
  .text.frag_8c7a3c 0x008c7a3c : { KEEP(*(.text.frag_8c7a3c)) }
  ASSERT(SIZEOF(.text.frag_8c7a3c) <= 4, "блок frag_8c7a3c не влезает в отведённые ему 4 байт")
  .text.ageing_detector__drop_connection 0x008c7a40 : { KEEP(*(.text.ageing_detector__drop_connection)) }
  ASSERT(SIZEOF(.text.ageing_detector__drop_connection) <= 32, "блок ageing_detector__drop_connection не влезает в отведённые ему 32 байт")
  .text.mid_list__disconnect_all 0x008c7a60 : { KEEP(*(.text.mid_list__disconnect_all)) }
  ASSERT(SIZEOF(.text.mid_list__disconnect_all) <= 84, "блок mid_list__disconnect_all не влезает в отведённые ему 84 байт")
  .text.pbss__disconnect_by_peer 0x008c7ab4 : { KEEP(*(.text.pbss__disconnect_by_peer)) }
  ASSERT(SIZEOF(.text.pbss__disconnect_by_peer) <= 88, "блок pbss__disconnect_by_peer не влезает в отведённые ему 88 байт")
  .text.vring_schd__disconnect_notify 0x008c7b0c : { KEEP(*(.text.vring_schd__disconnect_notify)) }
  ASSERT(SIZEOF(.text.vring_schd__disconnect_notify) <= 304, "блок vring_schd__disconnect_notify не влезает в отведённые ему 304 байт")
  .text.mid__disconnect_cmd 0x008c7c3c : { KEEP(*(.text.mid__disconnect_cmd)) }
  ASSERT(SIZEOF(.text.mid__disconnect_cmd) <= 68, "блок mid__disconnect_cmd не влезает в отведённые ему 68 байт")
  .text.discovery__handle_rx_frame 0x008c7c80 : { KEEP(*(.text.discovery__handle_rx_frame)) }
  ASSERT(SIZEOF(.text.discovery__handle_rx_frame) <= 352, "блок discovery__handle_rx_frame не влезает в отведённые ему 352 байт")
  .text.txrx_mgr__handle_dma_irq 0x008c7de0 : { KEEP(*(.text.txrx_mgr__handle_dma_irq)) }
  ASSERT(SIZEOF(.text.txrx_mgr__handle_dma_irq) <= 132, "блок txrx_mgr__handle_dma_irq не влезает в отведённые ему 132 байт")
  .text.hwd_dma__set_881c80 0x008c7e64 : { KEEP(*(.text.hwd_dma__set_881c80)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_881c80) <= 52, "блок hwd_dma__set_881c80 не влезает в отведённые ему 52 байт")
  .text.dpal__cpl_timeout_evt 0x008c7e98 : { KEEP(*(.text.dpal__cpl_timeout_evt)) }
  ASSERT(SIZEOF(.text.dpal__cpl_timeout_evt) <= 208, "блок dpal__cpl_timeout_evt не влезает в отведённые ему 208 байт")
  .text.dpal__cpl_timeout_log 0x008c7f68 : { KEEP(*(.text.dpal__cpl_timeout_log)) }
  ASSERT(SIZEOF(.text.dpal__cpl_timeout_log) <= 40, "блок dpal__cpl_timeout_log не влезает в отведённые ему 40 байт")
  .text.log_hexdump 0x008c7f90 : { KEEP(*(.text.log_hexdump)) }
  ASSERT(SIZEOF(.text.log_hexdump) <= 300, "блок log_hexdump не влезает в отведённые ему 300 байт")
  .text.set_g_80040c_x2_8c80bc 0x008c80bc : { KEEP(*(.text.set_g_80040c_x2_8c80bc)) }
  ASSERT(SIZEOF(.text.set_g_80040c_x2_8c80bc) <= 12, "блок set_g_80040c_x2_8c80bc не влезает в отведённые ему 12 байт")
  .text.rm_main_sm__enter_primary_non_locked 0x008c80c8 : { KEEP(*(.text.rm_main_sm__enter_primary_non_locked)) }
  ASSERT(SIZEOF(.text.rm_main_sm__enter_primary_non_locked) <= 64, "блок rm_main_sm__enter_primary_non_locked не влезает в отведённые ему 64 байт")
  .text.sm_pring__eop_evt 0x008c8108 : { KEEP(*(.text.sm_pring__eop_evt)) }
  ASSERT(SIZEOF(.text.sm_pring__eop_evt) <= 196, "блок sm_pring__eop_evt не влезает в отведённые ему 196 байт")
  .text.basic_sm__error_handler 0x008c81cc : { KEEP(*(.text.basic_sm__error_handler)) }
  ASSERT(SIZEOF(.text.basic_sm__error_handler) <= 56, "блок basic_sm__error_handler не влезает в отведённые ему 56 байт")
  .text.stub_ret_8c8204 0x008c8204 : { KEEP(*(.text.stub_ret_8c8204)) }
  ASSERT(SIZEOF(.text.stub_ret_8c8204) <= 4, "блок stub_ret_8c8204 не влезает в отведённые ему 4 байт")
  .text.sys__assert_no_error 0x008c8208 : { KEEP(*(.text.sys__assert_no_error)) }
  ASSERT(SIZEOF(.text.sys__assert_no_error) <= 24, "блок sys__assert_no_error не влезает в отведённые ему 24 байт")
  .text.sysassert__dump_stack 0x008c8220 : { KEEP(*(.text.sysassert__dump_stack)) }
  ASSERT(SIZEOF(.text.sysassert__dump_stack) <= 68, "блок sysassert__dump_stack не влезает в отведённые ему 68 байт")
  .text.sysassert__dump_ucode_stack 0x008c8264 : { KEEP(*(.text.sysassert__dump_ucode_stack)) }
  ASSERT(SIZEOF(.text.sysassert__dump_ucode_stack) <= 92, "блок sysassert__dump_ucode_stack не влезает в отведённые ему 92 байт")
  .text.fw_sysassert_fatal 0x008c82c0 : { KEEP(*(.text.fw_sysassert_fatal)) }
  ASSERT(SIZEOF(.text.fw_sysassert_fatal) <= 352, "блок fw_sysassert_fatal не влезает в отведённые ему 352 байт")
  .text.sysassert__wmi_lock_notice 0x008c8420 : { KEEP(*(.text.sysassert__wmi_lock_notice)) }
  ASSERT(SIZEOF(.text.sysassert__wmi_lock_notice) <= 140, "блок sysassert__wmi_lock_notice не влезает в отведённые ему 140 байт")
  .text.sysassert__dump_ucode_int6 0x008c84ac : { KEEP(*(.text.sysassert__dump_ucode_int6)) }
  ASSERT(SIZEOF(.text.sysassert__dump_ucode_int6) <= 96, "блок sysassert__dump_ucode_int6 не влезает в отведённые ему 96 байт")
  .text.frag_8c850c 0x008c850c : { KEEP(*(.text.frag_8c850c)) }
  ASSERT(SIZEOF(.text.frag_8c850c) <= 4, "блок frag_8c850c не влезает в отведённые ему 4 байт")
  .text.calib_engine__on_start 0x008c8510 : { KEEP(*(.text.calib_engine__on_start)) }
  ASSERT(SIZEOF(.text.calib_engine__on_start) <= 144, "блок calib_engine__on_start не влезает в отведённые ему 144 байт")
  .text.frag_8c85a0 0x008c85a0 : { KEEP(*(.text.frag_8c85a0)) }
  ASSERT(SIZEOF(.text.frag_8c85a0) <= 48, "блок frag_8c85a0 не влезает в отведённые ему 48 байт")
  .text.basic_calib_sparrow__estimation_alg 0x008c85d0 : { KEEP(*(.text.basic_calib_sparrow__estimation_alg)) }
  ASSERT(SIZEOF(.text.basic_calib_sparrow__estimation_alg) <= 268, "блок basic_calib_sparrow__estimation_alg не влезает в отведённые ему 268 байт")
  .text.class_calib_lo_power__check_online_estimation_condition 0x008c86dc : { KEEP(*(.text.class_calib_lo_power__check_online_estimation_condition)) }
  ASSERT(SIZEOF(.text.class_calib_lo_power__check_online_estimation_condition) <= 196, "блок class_calib_lo_power__check_online_estimation_condition не влезает в отведённые ему 196 байт")
  .text.calib_base__vt08 0x008c87a0 : { KEEP(*(.text.calib_base__vt08)) }
  ASSERT(SIZEOF(.text.calib_base__vt08) <= 4, "блок calib_base__vt08 не влезает в отведённые ему 4 байт")
  .text.frag_8c87a4 0x008c87a4 : { KEEP(*(.text.frag_8c87a4)) }
  ASSERT(SIZEOF(.text.frag_8c87a4) <= 8, "блок frag_8c87a4 не влезает в отведённые ему 8 байт")
  .text.fw_mailbox__init_rings 0x008c87ac : { KEEP(*(.text.fw_mailbox__init_rings)) }
  ASSERT(SIZEOF(.text.fw_mailbox__init_rings) <= 48, "блок fw_mailbox__init_rings не влезает в отведённые ему 48 байт")
  .text.frag_8c87dc 0x008c87dc : { KEEP(*(.text.frag_8c87dc)) }
  ASSERT(SIZEOF(.text.frag_8c87dc) <= 4, "блок frag_8c87dc не влезает в отведённые ему 4 байт")
  .text.calib_mngr__engine_start 0x008c87e0 : { KEEP(*(.text.calib_mngr__engine_start)) }
  ASSERT(SIZEOF(.text.calib_mngr__engine_start) <= 120, "блок calib_mngr__engine_start не влезает в отведённые ему 120 байт")
  .text.tx_desc__build 0x008c8858 : { KEEP(*(.text.tx_desc__build)) }
  ASSERT(SIZEOF(.text.tx_desc__build) <= 124, "блок tx_desc__build не влезает в отведённые ему 124 байт")
  .text.fill_statistics_to_host 0x008c88d4 : { KEEP(*(.text.fill_statistics_to_host)) }
  ASSERT(SIZEOF(.text.fill_statistics_to_host) <= 164, "блок fill_statistics_to_host не влезает в отведённые ему 164 байт")
  .text.agc_start_index 0x008c8978 : { KEEP(*(.text.agc_start_index)) }
  ASSERT(SIZEOF(.text.agc_start_index) <= 532, "блок agc_start_index не влезает в отведённые ему 532 байт")
  .text.conn_mgr__ranking_remove 0x008c8b8c : { KEEP(*(.text.conn_mgr__ranking_remove)) }
  ASSERT(SIZEOF(.text.conn_mgr__ranking_remove) <= 104, "блок conn_mgr__ranking_remove не влезает в отведённые ему 104 байт")
  .text.brd_if_multi_array__get_chunk 0x008c8bf4 : { KEEP(*(.text.brd_if_multi_array__get_chunk)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_chunk) <= 172, "блок brd_if_multi_array__get_chunk не влезает в отведённые ему 172 байт")
  .text.lut__find_index__2 0x008c8ca0 : { KEEP(*(.text.lut__find_index__2)) }
  ASSERT(SIZEOF(.text.lut__find_index__2) <= 296, "блок lut__find_index__2 не влезает в отведённые ему 296 байт")
  .text.brd_if_multi_array__find_section 0x008c8dc8 : { KEEP(*(.text.brd_if_multi_array__find_section)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__find_section) <= 156, "блок brd_if_multi_array__find_section не влезает в отведённые ему 156 байт")
  .text.MAINTAIN_SM__FBF_DELAYED 0x008c8e64 : { KEEP(*(.text.MAINTAIN_SM__FBF_DELAYED)) }
  ASSERT(SIZEOF(.text.MAINTAIN_SM__FBF_DELAYED) <= 88, "блок MAINTAIN_SM__FBF_DELAYED не влезает в отведённые ему 88 байт")
  .text.TX_CTRL_API__flush_connection 0x008c8ebc : { KEEP(*(.text.TX_CTRL_API__flush_connection)) }
  ASSERT(SIZEOF(.text.TX_CTRL_API__flush_connection) <= 100, "блок TX_CTRL_API__flush_connection не влезает в отведённые ему 100 байт")
  .text.fwq_tx__request_flush 0x008c8f20 : { KEEP(*(.text.fwq_tx__request_flush)) }
  ASSERT(SIZEOF(.text.fwq_tx__request_flush) <= 88, "блок fwq_tx__request_flush не влезает в отведённые ему 88 байт")
  .text.fwq_tx__flush_list_packets_by_cid 0x008c8f78 : { KEEP(*(.text.fwq_tx__flush_list_packets_by_cid)) }
  ASSERT(SIZEOF(.text.fwq_tx__flush_list_packets_by_cid) <= 148, "блок fwq_tx__flush_list_packets_by_cid не влезает в отведённые ему 148 байт")
  .text.fwq_tx__flush_by_prio 0x008c900c : { KEEP(*(.text.fwq_tx__flush_by_prio)) }
  ASSERT(SIZEOF(.text.fwq_tx__flush_by_prio) <= 76, "блок fwq_tx__flush_by_prio не влезает в отведённые ему 76 байт")
  .text.TX_API__flush_pending_peer_pm_connection 0x008c9058 : { KEEP(*(.text.TX_API__flush_pending_peer_pm_connection)) }
  ASSERT(SIZEOF(.text.TX_API__flush_pending_peer_pm_connection) <= 128, "блок TX_API__flush_pending_peer_pm_connection не влезает в отведённые ему 128 байт")
  .text.fwq__flush_timeout_handler 0x008c90d8 : { KEEP(*(.text.fwq__flush_timeout_handler)) }
  ASSERT(SIZEOF(.text.fwq__flush_timeout_handler) <= 44, "блок fwq__flush_timeout_handler не влезает в отведённые ему 44 байт")
  .text.WBE_DRIVER__Force 0x008c9104 : { KEEP(*(.text.WBE_DRIVER__Force)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__Force) <= 136, "блок WBE_DRIVER__Force не влезает в отведённые ему 136 байт")
  .text.set_reg_880ab8 0x008c918c : { KEEP(*(.text.set_reg_880ab8)) }
  ASSERT(SIZEOF(.text.set_reg_880ab8) <= 12, "блок set_reg_880ab8 не влезает в отведённые ему 12 байт")
  .text.fw_mailbox__write 0x008c9198 : { KEEP(*(.text.fw_mailbox__write)) }
  ASSERT(SIZEOF(.text.fw_mailbox__write) <= 136, "блок fw_mailbox__write не влезает в отведённые ему 136 байт")
  .text.fr_clr_mdm_crc_statistics 0x008c9220 : { KEEP(*(.text.fr_clr_mdm_crc_statistics)) }
  ASSERT(SIZEOF(.text.fr_clr_mdm_crc_statistics) <= 72, "блок fr_clr_mdm_crc_statistics не влезает в отведённые ему 72 байт")
  .text.mem_pool__free 0x008c9268 : { KEEP(*(.text.mem_pool__free)) }
  ASSERT(SIZEOF(.text.mem_pool__free) <= 120, "блок mem_pool__free не влезает в отведённые ему 120 байт")
  .text.vring__clear_hw_state 0x008c92e0 : { KEEP(*(.text.vring__clear_hw_state)) }
  ASSERT(SIZEOF(.text.vring__clear_hw_state) <= 28, "блок vring__clear_hw_state не влезает в отведённые ему 28 байт")
  .text.obj__clear_f24 0x008c92fc : { KEEP(*(.text.obj__clear_f24)) }
  ASSERT(SIZEOF(.text.obj__clear_f24) <= 8, "блок obj__clear_f24 не влезает в отведённые ему 8 байт")
  .text.conn_mgr__free_cid_db_element 0x008c9304 : { KEEP(*(.text.conn_mgr__free_cid_db_element)) }
  ASSERT(SIZEOF(.text.conn_mgr__free_cid_db_element) <= 120, "блок conn_mgr__free_cid_db_element не влезает в отведённые ему 120 байт")
  .text.fw_mailbox__enqueue 0x008c937c : { KEEP(*(.text.fw_mailbox__enqueue)) }
  ASSERT(SIZEOF(.text.fw_mailbox__enqueue) <= 120, "блок fw_mailbox__enqueue не влезает в отведённые ему 120 байт")
  .text.mem_pool__free_locked 0x008c93f4 : { KEEP(*(.text.mem_pool__free_locked)) }
  ASSERT(SIZEOF(.text.mem_pool__free_locked) <= 52, "блок mem_pool__free_locked не влезает в отведённые ему 52 байт")
  .text.rx_api__free_rx_buffer 0x008c9428 : { KEEP(*(.text.rx_api__free_rx_buffer)) }
  ASSERT(SIZEOF(.text.rx_api__free_rx_buffer) <= 64, "блок rx_api__free_rx_buffer не влезает в отведённые ему 64 байт")
  .text.fw_mailbox__enqueue_msg 0x008c9468 : { KEEP(*(.text.fw_mailbox__enqueue_msg)) }
  ASSERT(SIZEOF(.text.fw_mailbox__enqueue_msg) <= 92, "блок fw_mailbox__enqueue_msg не влезает в отведённые ему 92 байт")
  .text.TX_API__free_memory 0x008c94c4 : { KEEP(*(.text.TX_API__free_memory)) }
  ASSERT(SIZEOF(.text.TX_API__free_memory) <= 116, "блок TX_API__free_memory не влезает в отведённые ему 116 байт")
  .text.mgmt_buf__free 0x008c9538 : { KEEP(*(.text.mgmt_buf__free)) }
  ASSERT(SIZEOF(.text.mgmt_buf__free) <= 4, "блок mgmt_buf__free не влезает в отведённые ему 4 байт")
  .text.mgmt_pkt__clear 0x008c953c : { KEEP(*(.text.mgmt_pkt__clear)) }
  ASSERT(SIZEOF(.text.mgmt_pkt__clear) <= 32, "блок mgmt_pkt__clear не влезает в отведённые ему 32 байт")
  .text.mgmt_pkt__release 0x008c955c : { KEEP(*(.text.mgmt_pkt__release)) }
  ASSERT(SIZEOF(.text.mgmt_pkt__release) <= 28, "блок mgmt_pkt__release не влезает в отведённые ему 28 байт")
  .text.mem_pool__free_8062c4 0x008c9578 : { KEEP(*(.text.mem_pool__free_8062c4)) }
  ASSERT(SIZEOF(.text.mem_pool__free_8062c4) <= 32, "блок mem_pool__free_8062c4 не влезает в отведённые ему 32 байт")
  .text.basic_if__send_msg 0x008c9598 : { KEEP(*(.text.basic_if__send_msg)) }
  ASSERT(SIZEOF(.text.basic_if__send_msg) <= 80, "блок basic_if__send_msg не влезает в отведённые ему 80 байт")
  .text.TX_INTERNAL_API__connection 0x008c95e8 : { KEEP(*(.text.TX_INTERNAL_API__connection)) }
  ASSERT(SIZEOF(.text.TX_INTERNAL_API__connection) <= 160, "блок TX_INTERNAL_API__connection не влезает в отведённые ему 160 байт")
  .text.conn__inject_evt4 0x008c9688 : { KEEP(*(.text.conn__inject_evt4)) }
  ASSERT(SIZEOF(.text.conn__inject_evt4) <= 12, "блок conn__inject_evt4 не влезает в отведённые ему 12 байт")
  .text.rx_off__complete_when_drained 0x008c9694 : { KEEP(*(.text.rx_off__complete_when_drained)) }
  ASSERT(SIZEOF(.text.rx_off__complete_when_drained) <= 64, "блок rx_off__complete_when_drained не влезает в отведённые ему 64 байт")
  .text.rm_ch_switch_sm__fwtx_channel_stopped 0x008c96d4 : { KEEP(*(.text.rm_ch_switch_sm__fwtx_channel_stopped)) }
  ASSERT(SIZEOF(.text.rm_ch_switch_sm__fwtx_channel_stopped) <= 76, "блок rm_ch_switch_sm__fwtx_channel_stopped не влезает в отведённые ему 76 байт")
  .text.mid__set_default_dmg_params 0x008c9720 : { KEEP(*(.text.mid__set_default_dmg_params)) }
  ASSERT(SIZEOF(.text.mid__set_default_dmg_params) <= 120, "блок mid__set_default_dmg_params не влезает в отведённые ему 120 байт")
  .text.mid_list__count_active 0x008c9798 : { KEEP(*(.text.mid_list__count_active)) }
  ASSERT(SIZEOF(.text.mid_list__count_active) <= 72, "блок mid_list__count_active не влезает в отведённые ему 72 байт")
  .text.tsf__wrap_by_bi 0x008c97e0 : { KEEP(*(.text.tsf__wrap_by_bi)) }
  ASSERT(SIZEOF(.text.tsf__wrap_by_bi) <= 28, "блок tsf__wrap_by_bi не влезает в отведённые ему 28 байт")
  .text.mid__get_bcon_additional_ies 0x008c97fc : { KEEP(*(.text.mid__get_bcon_additional_ies)) }
  ASSERT(SIZEOF(.text.mid__get_bcon_additional_ies) <= 108, "блок mid__get_bcon_additional_ies не влезает в отведённые ему 108 байт")
  .text.get_g_8035f2 0x008c9868 : { KEEP(*(.text.get_g_8035f2)) }
  ASSERT(SIZEOF(.text.get_g_8035f2) <= 12, "блок get_g_8035f2 не влезает в отведённые ему 12 байт")
  .text.ies__scan_for_match 0x008c9874 : { KEEP(*(.text.ies__scan_for_match)) }
  ASSERT(SIZEOF(.text.ies__scan_for_match) <= 36, "блок ies__scan_for_match не влезает в отведённые ему 36 байт")
  .text.get_g_800236 0x008c9898 : { KEEP(*(.text.get_g_800236)) }
  ASSERT(SIZEOF(.text.get_g_800236) <= 4, "блок get_g_800236 не влезает в отведённые ему 4 байт")
  .text.mid__get_awake_window 0x008c989c : { KEEP(*(.text.mid__get_awake_window)) }
  ASSERT(SIZEOF(.text.mid__get_awake_window) <= 8, "блок mid__get_awake_window не влезает в отведённые ему 8 байт")
  .text.get_g_8000a0 0x008c98a4 : { KEEP(*(.text.get_g_8000a0)) }
  ASSERT(SIZEOF(.text.get_g_8000a0) <= 4, "блок get_g_8000a0 не влезает в отведённые ему 4 байт")
  .text.psc__read_mac_counters 0x008c98a8 : { KEEP(*(.text.psc__read_mac_counters)) }
  ASSERT(SIZEOF(.text.psc__read_mac_counters) <= 52, "блок psc__read_mac_counters не влезает в отведённые ему 52 байт")
  .text.brd_if_multi_array__get_block_info 0x008c98dc : { KEEP(*(.text.brd_if_multi_array__get_block_info)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_block_info) <= 368, "блок brd_if_multi_array__get_block_info не влезает в отведённые ему 368 байт")
  .text.brd_if__pick_block 0x008c9a4c : { KEEP(*(.text.brd_if__pick_block)) }
  ASSERT(SIZEOF(.text.brd_if__pick_block) <= 32, "блок brd_if__pick_block не влезает в отведённые ему 32 байт")
  .text.brd_if__section_bit_index 0x008c9a6c : { KEEP(*(.text.brd_if__section_bit_index)) }
  ASSERT(SIZEOF(.text.brd_if__section_bit_index) <= 24, "блок brd_if__section_bit_index не влезает в отведённые ему 24 байт")
  .text.brd_if_multi_array__get_board_file_format_version 0x008c9a84 : { KEEP(*(.text.brd_if_multi_array__get_board_file_format_version)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_board_file_format_version) <= 52, "блок brd_if_multi_array__get_board_file_format_version не влезает в отведённые ему 52 байт")
  .text.wmi_add_key__pick_mid 0x008c9ab8 : { KEEP(*(.text.wmi_add_key__pick_mid)) }
  ASSERT(SIZEOF(.text.wmi_add_key__pick_mid) <= 44, "блок wmi_add_key__pick_mid не влезает в отведённые ему 44 байт")
  .text.mid__copy_bssid 0x008c9ae4 : { KEEP(*(.text.mid__copy_bssid)) }
  ASSERT(SIZEOF(.text.mid__copy_bssid) <= 40, "блок mid__copy_bssid не влезает в отведённые ему 40 байт")
  .text.stub_ret_8c9b0c 0x008c9b0c : { KEEP(*(.text.stub_ret_8c9b0c)) }
  ASSERT(SIZEOF(.text.stub_ret_8c9b0c) <= 4, "блок stub_ret_8c9b0c не влезает в отведённые ему 4 байт")
  .text.fwq_tx__check_prio 0x008c9b10 : { KEEP(*(.text.fwq_tx__check_prio)) }
  ASSERT(SIZEOF(.text.fwq_tx__check_prio) <= 44, "блок fwq_tx__check_prio не влезает в отведённые ему 44 байт")
  .text.brd_if_multi_array__get_chunk_8c9b3c 0x008c9b3c : { KEEP(*(.text.brd_if_multi_array__get_chunk_8c9b3c)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_chunk_8c9b3c) <= 140, "блок brd_if_multi_array__get_chunk_8c9b3c не влезает в отведённые ему 140 байт")
  .text.brd_if_multi_array__get_chunk_in_address_data_pairs_format 0x008c9bc8 : { KEEP(*(.text.brd_if_multi_array__get_chunk_in_address_data_pairs_format)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_chunk_in_address_data_pairs_format) <= 152, "блок brd_if_multi_array__get_chunk_in_address_data_pairs_format не влезает в отведённые ему 152 байт")
  .text.brd_if_multi_array__get_chunk_in_data_only_format 0x008c9c60 : { KEEP(*(.text.brd_if_multi_array__get_chunk_in_data_only_format)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_chunk_in_data_only_format) <= 252, "блок brd_if_multi_array__get_chunk_in_data_only_format не влезает в отведённые ему 252 байт")
  .text.div_round_up 0x008c9d5c : { KEEP(*(.text.div_round_up)) }
  ASSERT(SIZEOF(.text.div_round_up) <= 24, "блок div_round_up не влезает в отведённые ему 24 байт")
  .text.lm__get_cid 0x008c9d74 : { KEEP(*(.text.lm__get_cid)) }
  ASSERT(SIZEOF(.text.lm__get_cid) <= 8, "блок lm__get_cid не влезает в отведённые ему 8 байт")
  .text.link_stats__get_cid 0x008c9d7c : { KEEP(*(.text.link_stats__get_cid)) }
  ASSERT(SIZEOF(.text.link_stats__get_cid) <= 8, "блок link_stats__get_cid не влезает в отведённые ему 8 байт")
  .text.ba_sm__pring_id_of_conn 0x008c9d84 : { KEEP(*(.text.ba_sm__pring_id_of_conn)) }
  ASSERT(SIZEOF(.text.ba_sm__pring_id_of_conn) <= 8, "блок ba_sm__pring_id_of_conn не влезает в отведённые ему 8 байт")
  .text.lm_if__get_cid 0x008c9d8c : { KEEP(*(.text.lm_if__get_cid)) }
  ASSERT(SIZEOF(.text.lm_if__get_cid) <= 8, "блок lm_if__get_cid не влезает в отведённые ему 8 байт")
  .text.vring__get_pring_id 0x008c9d94 : { KEEP(*(.text.vring__get_pring_id)) }
  ASSERT(SIZEOF(.text.vring__get_pring_id) <= 16, "блок vring__get_pring_id не влезает в отведённые ему 16 байт")
  .text.pbss__cid_by_aid 0x008c9da4 : { KEEP(*(.text.pbss__cid_by_aid)) }
  ASSERT(SIZEOF(.text.pbss__cid_by_aid) <= 108, "блок pbss__cid_by_aid не влезает в отведённые ему 108 байт")
  .text.ie_list__first 0x008c9e10 : { KEEP(*(.text.ie_list__first)) }
  ASSERT(SIZEOF(.text.ie_list__first) <= 52, "блок ie_list__first не влезает в отведённые ему 52 байт")
  .text.conn_mgr__by_cid 0x008c9e44 : { KEEP(*(.text.conn_mgr__by_cid)) }
  ASSERT(SIZEOF(.text.conn_mgr__by_cid) <= 48, "блок conn_mgr__by_cid не влезает в отведённые ему 48 байт")
  .text.mid_list__find_by 0x008c9e74 : { KEEP(*(.text.mid_list__find_by)) }
  ASSERT(SIZEOF(.text.mid_list__find_by) <= 72, "блок mid_list__find_by не влезает в отведённые ему 72 байт")
  .text.mid__cid_by_aid 0x008c9ebc : { KEEP(*(.text.mid__cid_by_aid)) }
  ASSERT(SIZEOF(.text.mid__cid_by_aid) <= 160, "блок mid__cid_by_aid не влезает в отведённые ему 160 байт")
  .text.tail_get_reg_880254 0x008c9f5c : { KEEP(*(.text.tail_get_reg_880254)) }
  ASSERT(SIZEOF(.text.tail_get_reg_880254) <= 4, "блок tail_get_reg_880254 не влезает в отведённые ему 4 байт")
  .text.conn__get_vtbl_pair 0x008c9f60 : { KEEP(*(.text.conn__get_vtbl_pair)) }
  ASSERT(SIZEOF(.text.conn__get_vtbl_pair) <= 12, "блок conn__get_vtbl_pair не влезает в отведённые ему 12 байт")
  .text.conn__get_vtbl_pair_at28 0x008c9f6c : { KEEP(*(.text.conn__get_vtbl_pair_at28)) }
  ASSERT(SIZEOF(.text.conn__get_vtbl_pair_at28) <= 8, "блок conn__get_vtbl_pair_at28 не влезает в отведённые ему 8 байт")
  .text.rx_pkt__lookup_handler 0x008c9f74 : { KEEP(*(.text.rx_pkt__lookup_handler)) }
  ASSERT(SIZEOF(.text.rx_pkt__lookup_handler) <= 24, "блок rx_pkt__lookup_handler не влезает в отведённые ему 24 байт")
  .text.get_g_800140_8c9f8c 0x008c9f8c : { KEEP(*(.text.get_g_800140_8c9f8c)) }
  ASSERT(SIZEOF(.text.get_g_800140_8c9f8c) <= 12, "блок get_g_800140_8c9f8c не влезает в отведённые ему 12 байт")
  .text.obj__get_field_0x424 0x008c9f98 : { KEEP(*(.text.obj__get_field_0x424)) }
  ASSERT(SIZEOF(.text.obj__get_field_0x424) <= 8, "блок obj__get_field_0x424 не влезает в отведённые ему 8 байт")
  .text.frag_8c9fa0 0x008c9fa0 : { KEEP(*(.text.frag_8c9fa0)) }
  ASSERT(SIZEOF(.text.frag_8c9fa0) <= 8, "блок frag_8c9fa0 не влезает в отведённые ему 8 байт")
  .text.frag_8c9fa8 0x008c9fa8 : { KEEP(*(.text.frag_8c9fa8)) }
  ASSERT(SIZEOF(.text.frag_8c9fa8) <= 12, "блок frag_8c9fa8 не влезает в отведённые ему 12 байт")
  .text.obj_800140__vt20 0x008c9fb4 : { KEEP(*(.text.obj_800140__vt20)) }
  ASSERT(SIZEOF(.text.obj_800140__vt20) <= 8, "блок obj_800140__vt20 не влезает в отведённые ему 8 байт")
  .text.stub_ret_8c9fbc 0x008c9fbc : { KEEP(*(.text.stub_ret_8c9fbc)) }
  ASSERT(SIZEOF(.text.stub_ret_8c9fbc) <= 8, "блок stub_ret_8c9fbc не влезает в отведённые ему 8 байт")
  .text.stub_ret_8c9fc4 0x008c9fc4 : { KEEP(*(.text.stub_ret_8c9fc4)) }
  ASSERT(SIZEOF(.text.stub_ret_8c9fc4) <= 8, "блок stub_ret_8c9fc4 не влезает в отведённые ему 8 байт")
  .text.link_maintain_cfg__copy 0x008c9fcc : { KEEP(*(.text.link_maintain_cfg__copy)) }
  ASSERT(SIZEOF(.text.link_maintain_cfg__copy) <= 44, "блок link_maintain_cfg__copy не влезает в отведённые ему 44 байт")
  .text.tx_desc_by_index 0x008c9ff8 : { KEEP(*(.text.tx_desc_by_index)) }
  ASSERT(SIZEOF(.text.tx_desc_by_index) <= 8, "блок tx_desc_by_index не влезает в отведённые ему 8 байт")
  .text.stub_ret_8ca000 0x008ca000 : { KEEP(*(.text.stub_ret_8ca000)) }
  ASSERT(SIZEOF(.text.stub_ret_8ca000) <= 8, "блок stub_ret_8ca000 не влезает в отведённые ему 8 байт")
  .text.get_g_80035c 0x008ca008 : { KEEP(*(.text.get_g_80035c)) }
  ASSERT(SIZEOF(.text.get_g_80035c) <= 4, "блок get_g_80035c не влезает в отведённые ему 4 байт")
  .text.tsf__read_scaled 0x008ca00c : { KEEP(*(.text.tsf__read_scaled)) }
  ASSERT(SIZEOF(.text.tsf__read_scaled) <= 44, "блок tsf__read_scaled не влезает в отведённые ему 44 байт")
  .text.frag_8ca038 0x008ca038 : { KEEP(*(.text.frag_8ca038)) }
  ASSERT(SIZEOF(.text.frag_8ca038) <= 56, "блок frag_8ca038 не влезает в отведённые ему 56 байт")
  .text.u_schd__deadline_less 0x008ca070 : { KEEP(*(.text.u_schd__deadline_less)) }
  ASSERT(SIZEOF(.text.u_schd__deadline_less) <= 32, "блок u_schd__deadline_less не влезает в отведённые ему 32 байт")
  .text.ies_block__find_ie 0x008ca090 : { KEEP(*(.text.ies_block__find_ie)) }
  ASSERT(SIZEOF(.text.ies_block__find_ie) <= 52, "блок ies_block__find_ie не влезает в отведённые ему 52 байт")
  .text.get_g_800374 0x008ca0c4 : { KEEP(*(.text.get_g_800374)) }
  ASSERT(SIZEOF(.text.get_g_800374) <= 4, "блок get_g_800374 не влезает в отведённые ему 4 байт")
  .text.get_g_800378 0x008ca0c8 : { KEEP(*(.text.get_g_800378)) }
  ASSERT(SIZEOF(.text.get_g_800378) <= 4, "блок get_g_800378 не влезает в отведённые ему 4 байт")
  .text.get_g_800288 0x008ca0cc : { KEEP(*(.text.get_g_800288)) }
  ASSERT(SIZEOF(.text.get_g_800288) <= 4, "блок get_g_800288 не влезает в отведённые ему 4 байт")
  .text.get_g_800220 0x008ca0d0 : { KEEP(*(.text.get_g_800220)) }
  ASSERT(SIZEOF(.text.get_g_800220) <= 4, "блок get_g_800220 не влезает в отведённые ему 4 байт")
  .text.get_g_800222 0x008ca0d4 : { KEEP(*(.text.get_g_800222)) }
  ASSERT(SIZEOF(.text.get_g_800222) <= 4, "блок get_g_800222 не влезает в отведённые ему 4 байт")
  .text.get_g_8001e8 0x008ca0d8 : { KEEP(*(.text.get_g_8001e8)) }
  ASSERT(SIZEOF(.text.get_g_8001e8) <= 4, "блок get_g_8001e8 не влезает в отведённые ему 4 байт")
  .text.get_g_800221 0x008ca0dc : { KEEP(*(.text.get_g_800221)) }
  ASSERT(SIZEOF(.text.get_g_800221) <= 4, "блок get_g_800221 не влезает в отведённые ему 4 байт")
  .text.get_g_80037c 0x008ca0e0 : { KEEP(*(.text.get_g_80037c)) }
  ASSERT(SIZEOF(.text.get_g_80037c) <= 4, "блок get_g_80037c не влезает в отведённые ему 4 байт")
  .text.txq_cfg__default_c8_if_unset 0x008ca0e4 : { KEEP(*(.text.txq_cfg__default_c8_if_unset)) }
  ASSERT(SIZEOF(.text.txq_cfg__default_c8_if_unset) <= 20, "блок txq_cfg__default_c8_if_unset не влезает в отведённые ему 20 байт")
  .text.txq_cfg__default_1_if_unset 0x008ca0f8 : { KEEP(*(.text.txq_cfg__default_1_if_unset)) }
  ASSERT(SIZEOF(.text.txq_cfg__default_1_if_unset) <= 20, "блок txq_cfg__default_1_if_unset не влезает в отведённые ему 20 байт")
  .text.txq_cfg__default_40_if_unset 0x008ca10c : { KEEP(*(.text.txq_cfg__default_40_if_unset)) }
  ASSERT(SIZEOF(.text.txq_cfg__default_40_if_unset) <= 20, "блок txq_cfg__default_40_if_unset не влезает в отведённые ему 20 байт")
  .text.get_g_8001ea 0x008ca120 : { KEEP(*(.text.get_g_8001ea)) }
  ASSERT(SIZEOF(.text.get_g_8001ea) <= 4, "блок get_g_8001ea не влезает в отведённые ему 4 байт")
  .text.txq_cfg__default_0_if_unset 0x008ca124 : { KEEP(*(.text.txq_cfg__default_0_if_unset)) }
  ASSERT(SIZEOF(.text.txq_cfg__default_0_if_unset) <= 20, "блок txq_cfg__default_0_if_unset не влезает в отведённые ему 20 байт")
  .text.get_g_800384 0x008ca138 : { KEEP(*(.text.get_g_800384)) }
  ASSERT(SIZEOF(.text.get_g_800384) <= 4, "блок get_g_800384 не влезает в отведённые ему 4 байт")
  .text.link_maintain_cfg__read_by_index 0x008ca13c : { KEEP(*(.text.link_maintain_cfg__read_by_index)) }
  ASSERT(SIZEOF(.text.link_maintain_cfg__read_by_index) <= 40, "блок link_maintain_cfg__read_by_index не влезает в отведённые ему 40 байт")
  .text.get_g_80023d 0x008ca164 : { KEEP(*(.text.get_g_80023d)) }
  ASSERT(SIZEOF(.text.get_g_80023d) <= 4, "блок get_g_80023d не влезает в отведённые ему 4 байт")
  .text.stub_ret_8ca168 0x008ca168 : { KEEP(*(.text.stub_ret_8ca168)) }
  ASSERT(SIZEOF(.text.stub_ret_8ca168) <= 8, "блок stub_ret_8ca168 не влезает в отведённые ему 8 байт")
  .text.stub_ret_8ca170 0x008ca170 : { KEEP(*(.text.stub_ret_8ca170)) }
  ASSERT(SIZEOF(.text.stub_ret_8ca170) <= 8, "блок stub_ret_8ca170 не влезает в отведённые ему 8 байт")
  .text.get_g_80023e 0x008ca178 : { KEEP(*(.text.get_g_80023e)) }
  ASSERT(SIZEOF(.text.get_g_80023e) <= 4, "блок get_g_80023e не влезает в отведённые ему 4 байт")
  .text.get_g_80023f 0x008ca17c : { KEEP(*(.text.get_g_80023f)) }
  ASSERT(SIZEOF(.text.get_g_80023f) <= 4, "блок get_g_80023f не влезает в отведённые ему 4 байт")
  .text.mac_hdr__copy_addr 0x008ca180 : { KEEP(*(.text.mac_hdr__copy_addr)) }
  ASSERT(SIZEOF(.text.mac_hdr__copy_addr) <= 16, "блок mac_hdr__copy_addr не влезает в отведённые ему 16 байт")
  .text.tail_sm_pring__used_slots 0x008ca190 : { KEEP(*(.text.tail_sm_pring__used_slots)) }
  ASSERT(SIZEOF(.text.tail_sm_pring__used_slots) <= 4, "блок tail_sm_pring__used_slots не влезает в отведённые ему 4 байт")
  .text.tail_sm_pring__free_slots 0x008ca194 : { KEEP(*(.text.tail_sm_pring__free_slots)) }
  ASSERT(SIZEOF(.text.tail_sm_pring__free_slots) <= 4, "блок tail_sm_pring__free_slots не влезает в отведённые ему 4 байт")
  .text.get_g_8003bc 0x008ca198 : { KEEP(*(.text.get_g_8003bc)) }
  ASSERT(SIZEOF(.text.get_g_8003bc) <= 4, "блок get_g_8003bc не влезает в отведённые ему 4 байт")
  .text.stub_ret_8ca19c 0x008ca19c : { KEEP(*(.text.stub_ret_8ca19c)) }
  ASSERT(SIZEOF(.text.stub_ret_8ca19c) <= 4, "блок stub_ret_8ca19c не влезает в отведённые ему 4 байт")
  .text.get_g_800100 0x008ca1a0 : { KEEP(*(.text.get_g_800100)) }
  ASSERT(SIZEOF(.text.get_g_800100) <= 4, "блок get_g_800100 не влезает в отведённые ему 4 байт")
  .text.get_g_800240 0x008ca1a4 : { KEEP(*(.text.get_g_800240)) }
  ASSERT(SIZEOF(.text.get_g_800240) <= 4, "блок get_g_800240 не влезает в отведённые ему 4 байт")
  .text.lm__get_mid_id 0x008ca1a8 : { KEEP(*(.text.lm__get_mid_id)) }
  ASSERT(SIZEOF(.text.lm__get_mid_id) <= 8, "блок lm__get_mid_id не влезает в отведённые ему 8 байт")
  .text.mid_list__by_mid 0x008ca1b0 : { KEEP(*(.text.mid_list__by_mid)) }
  ASSERT(SIZEOF(.text.mid_list__by_mid) <= 56, "блок mid_list__by_mid не влезает в отведённые ему 56 байт")
  .text.lm_if__get_mid_id 0x008ca1e8 : { KEEP(*(.text.lm_if__get_mid_id)) }
  ASSERT(SIZEOF(.text.lm_if__get_mid_id) <= 8, "блок lm_if__get_mid_id не влезает в отведённые ему 8 байт")
  .text.mid_list__first_of_field8 0x008ca1f0 : { KEEP(*(.text.mid_list__first_of_field8)) }
  ASSERT(SIZEOF(.text.mid_list__first_of_field8) <= 8, "блок mid_list__first_of_field8 не влезает в отведённые ему 8 байт")
  .text.mid_list__find_by_kind 0x008ca1f8 : { KEEP(*(.text.mid_list__find_by_kind)) }
  ASSERT(SIZEOF(.text.mid_list__find_by_kind) <= 96, "блок mid_list__find_by_kind не влезает в отведённые ему 96 байт")
  .text.get_g_800242 0x008ca258 : { KEEP(*(.text.get_g_800242)) }
  ASSERT(SIZEOF(.text.get_g_800242) <= 4, "блок get_g_800242 не влезает в отведённые ему 4 байт")
  .text.ps_assoc_mgr__vt28 0x008ca25c : { KEEP(*(.text.ps_assoc_mgr__vt28)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt28) <= 4, "блок ps_assoc_mgr__vt28 не влезает в отведённые ему 4 байт")
  .text.ps_nonassoc_mgr__vt28 0x008ca260 : { KEEP(*(.text.ps_nonassoc_mgr__vt28)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt28) <= 4, "блок ps_nonassoc_mgr__vt28 не влезает в отведённые ему 4 байт")
  .text.tx_desc__set_lifetime 0x008ca264 : { KEEP(*(.text.tx_desc__set_lifetime)) }
  ASSERT(SIZEOF(.text.tx_desc__set_lifetime) <= 60, "блок tx_desc__set_lifetime не влезает в отведённые ему 60 байт")
  .text.u_schd__calc_next_deadline 0x008ca2a0 : { KEEP(*(.text.u_schd__calc_next_deadline)) }
  ASSERT(SIZEOF(.text.u_schd__calc_next_deadline) <= 108, "блок u_schd__calc_next_deadline не влезает в отведённые ему 108 байт")
  .text.u_schd__pick_next 0x008ca30c : { KEEP(*(.text.u_schd__pick_next)) }
  ASSERT(SIZEOF(.text.u_schd__pick_next) <= 124, "блок u_schd__pick_next не влезает в отведённые ему 124 байт")
  .text.rm_main_sm__get_next_prim_request 0x008ca388 : { KEEP(*(.text.rm_main_sm__get_next_prim_request)) }
  ASSERT(SIZEOF(.text.rm_main_sm__get_next_prim_request) <= 56, "блок rm_main_sm__get_next_prim_request не влезает в отведённые ему 56 байт")
  .text.rm_main_sm__get_next_request 0x008ca3c0 : { KEEP(*(.text.rm_main_sm__get_next_request)) }
  ASSERT(SIZEOF(.text.rm_main_sm__get_next_request) <= 144, "блок rm_main_sm__get_next_request не влезает в отведённые ему 144 байт")
  .text.frag_8ca450 0x008ca450 : { KEEP(*(.text.frag_8ca450)) }
  ASSERT(SIZEOF(.text.frag_8ca450) <= 4, "блок frag_8ca450 не влезает в отведённые ему 4 байт")
  .text.obj__get_field4 0x008ca454 : { KEEP(*(.text.obj__get_field4)) }
  ASSERT(SIZEOF(.text.obj__get_field4) <= 4, "блок obj__get_field4 не влезает в отведённые ему 4 байт")
  .text.get_g_8035f0 0x008ca458 : { KEEP(*(.text.get_g_8035f0)) }
  ASSERT(SIZEOF(.text.get_g_8035f0) <= 12, "блок get_g_8035f0 не влезает в отведённые ему 12 байт")
  .text.mid_list__count_free 0x008ca464 : { KEEP(*(.text.mid_list__count_free)) }
  ASSERT(SIZEOF(.text.mid_list__count_free) <= 56, "блок mid_list__count_free не влезает в отведённые ему 56 байт")
  .text.stub_ret_8ca49c 0x008ca49c : { KEEP(*(.text.stub_ret_8ca49c)) }
  ASSERT(SIZEOF(.text.stub_ret_8ca49c) <= 8, "блок stub_ret_8ca49c не влезает в отведённые ему 8 байт")
  .text.calib_cfg__get_scheme 0x008ca4a4 : { KEEP(*(.text.calib_cfg__get_scheme)) }
  ASSERT(SIZEOF(.text.calib_cfg__get_scheme) <= 100, "блок calib_cfg__get_scheme не влезает в отведённые ему 100 байт")
  .text.fwq_tx__find_packet 0x008ca508 : { KEEP(*(.text.fwq_tx__find_packet)) }
  ASSERT(SIZEOF(.text.fwq_tx__find_packet) <= 48, "блок fwq_tx__find_packet не влезает в отведённые ему 48 байт")
  .text.tail_fwq_tx__handle_completion 0x008ca538 : { KEEP(*(.text.tail_fwq_tx__handle_completion)) }
  ASSERT(SIZEOF(.text.tail_fwq_tx__handle_completion) <= 8, "блок tail_fwq_tx__handle_completion не влезает в отведённые ему 8 байт")
  .text.fwq_tx__handle_completion 0x008ca540 : { KEEP(*(.text.fwq_tx__handle_completion)) }
  ASSERT(SIZEOF(.text.fwq_tx__handle_completion) <= 428, "блок fwq_tx__handle_completion не влезает в отведённые ему 428 байт")
  .text.tx_dma_if__submit 0x008ca6ec : { KEEP(*(.text.tx_dma_if__submit)) }
  ASSERT(SIZEOF(.text.tx_dma_if__submit) <= 192, "блок tx_dma_if__submit не влезает в отведённые ему 192 байт")
  .text.frag_8ca7ac 0x008ca7ac : { KEEP(*(.text.frag_8ca7ac)) }
  ASSERT(SIZEOF(.text.frag_8ca7ac) <= 24, "блок frag_8ca7ac не влезает в отведённые ему 24 байт")
  .text.pbss__sta_entry_flag 0x008ca7c4 : { KEEP(*(.text.pbss__sta_entry_flag)) }
  ASSERT(SIZEOF(.text.pbss__sta_entry_flag) <= 24, "блок pbss__sta_entry_flag не влезает в отведённые ему 24 байт")
  .text.pring__by_index 0x008ca7dc : { KEEP(*(.text.pring__by_index)) }
  ASSERT(SIZEOF(.text.pring__by_index) <= 16, "блок pring__by_index не влезает в отведённые ему 16 байт")
  .text.ba_sm__vring_field6 0x008ca7ec : { KEEP(*(.text.ba_sm__vring_field6)) }
  ASSERT(SIZEOF(.text.ba_sm__vring_field6) <= 8, "блок ba_sm__vring_field6 не влезает в отведённые ему 8 байт")
  .text.deref_0_4 0x008ca7f4 : { KEEP(*(.text.deref_0_4)) }
  ASSERT(SIZEOF(.text.deref_0_4) <= 8, "блок deref_0_4 не влезает в отведённые ему 8 байт")
  .text.get_g_80013c 0x008ca7fc : { KEEP(*(.text.get_g_80013c)) }
  ASSERT(SIZEOF(.text.get_g_80013c) <= 4, "блок get_g_80013c не влезает в отведённые ему 4 байт")
  .text.rw_g_8043d4 0x008ca800 : { KEEP(*(.text.rw_g_8043d4)) }
  ASSERT(SIZEOF(.text.rw_g_8043d4) <= 12, "блок rw_g_8043d4 не влезает в отведённые ему 12 байт")
  .text.get_g_800227 0x008ca80c : { KEEP(*(.text.get_g_800227)) }
  ASSERT(SIZEOF(.text.get_g_800227) <= 4, "блок get_g_800227 не влезает в отведённые ему 4 байт")
  .text.frag_8ca810 0x008ca810 : { KEEP(*(.text.frag_8ca810)) }
  ASSERT(SIZEOF(.text.frag_8ca810) <= 20, "блок frag_8ca810 не влезает в отведённые ему 20 байт")
  .text.tail_get_g_8003b0 0x008ca824 : { KEEP(*(.text.tail_get_g_8003b0)) }
  ASSERT(SIZEOF(.text.tail_get_g_8003b0) <= 4, "блок tail_get_g_8003b0 не влезает в отведённые ему 4 байт")
  .text.vring_ctx_by_index 0x008ca828 : { KEEP(*(.text.vring_ctx_by_index)) }
  ASSERT(SIZEOF(.text.vring_ctx_by_index) <= 12, "блок vring_ctx_by_index не влезает в отведённые ему 12 байт")
  .text.brd_if_multi_array__get_section_info 0x008ca834 : { KEEP(*(.text.brd_if_multi_array__get_section_info)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__get_section_info) <= 120, "блок brd_if_multi_array__get_section_info не влезает в отведённые ему 120 байт")
  .text.bcon_ss__call_vmethod_14 0x008ca8ac : { KEEP(*(.text.bcon_ss__call_vmethod_14)) }
  ASSERT(SIZEOF(.text.bcon_ss__call_vmethod_14) <= 8, "блок bcon_ss__call_vmethod_14 не влезает в отведённые ему 8 байт")
  .text.bitrev_fold_field_0x10 0x008ca8b4 : { KEEP(*(.text.bitrev_fold_field_0x10)) }
  ASSERT(SIZEOF(.text.bitrev_fold_field_0x10) <= 40, "блок bitrev_fold_field_0x10 не влезает в отведённые ему 40 байт")
  .text.bcon_ss__call_vmethod_10 0x008ca8dc : { KEEP(*(.text.bcon_ss__call_vmethod_10)) }
  ASSERT(SIZEOF(.text.bcon_ss__call_vmethod_10) <= 8, "блок bcon_ss__call_vmethod_10 не влезает в отведённые ему 8 байт")
  .text.bitrev_fold_field_0x14 0x008ca8e4 : { KEEP(*(.text.bitrev_fold_field_0x14)) }
  ASSERT(SIZEOF(.text.bitrev_fold_field_0x14) <= 40, "блок bitrev_fold_field_0x14 не влезает в отведённые ему 40 байт")
  .text.ps_conn__profile_params_by_index 0x008ca90c : { KEEP(*(.text.ps_conn__profile_params_by_index)) }
  ASSERT(SIZEOF(.text.ps_conn__profile_params_by_index) <= 28, "блок ps_conn__profile_params_by_index не влезает в отведённые ему 28 байт")
  .text.mid__copy_ssid 0x008ca928 : { KEEP(*(.text.mid__copy_ssid)) }
  ASSERT(SIZEOF(.text.mid__copy_ssid) <= 28, "блок mid__copy_ssid не влезает в отведённые ему 28 байт")
  .text.vring__read_macq_stats 0x008ca944 : { KEEP(*(.text.vring__read_macq_stats)) }
  ASSERT(SIZEOF(.text.vring__read_macq_stats) <= 32, "блок vring__read_macq_stats не влезает в отведённые ему 32 байт")
  .text.host_if__get_status_hal 0x008ca964 : { KEEP(*(.text.host_if__get_status_hal)) }
  ASSERT(SIZEOF(.text.host_if__get_status_hal) <= 380, "блок host_if__get_status_hal не влезает в отведённые ему 380 байт")
  .text.stream_mgr__find_pring_by_cid 0x008caae0 : { KEEP(*(.text.stream_mgr__find_pring_by_cid)) }
  ASSERT(SIZEOF(.text.stream_mgr__find_pring_by_cid) <= 48, "блок stream_mgr__find_pring_by_cid не влезает в отведённые ему 48 байт")
  .text.stream_mgr__find_vring_by_cid 0x008cab10 : { KEEP(*(.text.stream_mgr__find_vring_by_cid)) }
  ASSERT(SIZEOF(.text.stream_mgr__find_vring_by_cid) <= 64, "блок stream_mgr__find_vring_by_cid не влезает в отведённые ему 64 байт")
  .text.ba_sm__vring_field7 0x008cab50 : { KEEP(*(.text.ba_sm__vring_field7)) }
  ASSERT(SIZEOF(.text.ba_sm__vring_field7) <= 8, "блок ba_sm__vring_field7 не влезает в отведённые ему 8 байт")
  .text.sta_rec__unpack_5bit_caps 0x008cab58 : { KEEP(*(.text.sta_rec__unpack_5bit_caps)) }
  ASSERT(SIZEOF(.text.sta_rec__unpack_5bit_caps) <= 116, "блок sta_rec__unpack_5bit_caps не влезает в отведённые ему 116 байт")
  .text.get_g_8001f4 0x008cabcc : { KEEP(*(.text.get_g_8001f4)) }
  ASSERT(SIZEOF(.text.get_g_8001f4) <= 4, "блок get_g_8001f4 не влезает в отведённые ему 4 байт")
  .text.stub_ret_8cabd0 0x008cabd0 : { KEEP(*(.text.stub_ret_8cabd0)) }
  ASSERT(SIZEOF(.text.stub_ret_8cabd0) <= 8, "блок stub_ret_8cabd0 не влезает в отведённые ему 8 байт")
  .text.get_g_80001c 0x008cabd8 : { KEEP(*(.text.get_g_80001c)) }
  ASSERT(SIZEOF(.text.get_g_80001c) <= 4, "блок get_g_80001c не влезает в отведённые ему 4 байт")
  .text.get_g_800230 0x008cabdc : { KEEP(*(.text.get_g_800230)) }
  ASSERT(SIZEOF(.text.get_g_800230) <= 4, "блок get_g_800230 не влезает в отведённые ему 4 байт")
  .text.get_g_8001dc 0x008cabe0 : { KEEP(*(.text.get_g_8001dc)) }
  ASSERT(SIZEOF(.text.get_g_8001dc) <= 4, "блок get_g_8001dc не влезает в отведённые ему 4 байт")
  .text.mid__type_of 0x008cabe4 : { KEEP(*(.text.mid__type_of)) }
  ASSERT(SIZEOF(.text.mid__type_of) <= 64, "блок mid__type_of не влезает в отведённые ему 64 байт")
  .text.calib_base__vt2c 0x008cac24 : { KEEP(*(.text.calib_base__vt2c)) }
  ASSERT(SIZEOF(.text.calib_base__vt2c) <= 60, "блок calib_base__vt2c не влезает в отведённые ему 60 байт")
  .text.macq__is_queue_busy 0x008cac60 : { KEEP(*(.text.macq__is_queue_busy)) }
  ASSERT(SIZEOF(.text.macq__is_queue_busy) <= 72, "блок macq__is_queue_busy не влезает в отведённые ему 72 байт")
  .text.frag_8caca8 0x008caca8 : { KEEP(*(.text.frag_8caca8)) }
  ASSERT(SIZEOF(.text.frag_8caca8) <= 20, "блок frag_8caca8 не влезает в отведённые ему 20 байт")
  .text.tail_get_g_8003b4 0x008cacbc : { KEEP(*(.text.tail_get_g_8003b4)) }
  ASSERT(SIZEOF(.text.tail_get_g_8003b4) <= 4, "блок tail_get_g_8003b4 не влезает в отведённые ему 4 байт")
  .text.vring_by_index 0x008cacc0 : { KEEP(*(.text.vring_by_index)) }
  ASSERT(SIZEOF(.text.vring_by_index) <= 12, "блок vring_by_index не влезает в отведённые ему 12 байт")
  .text.brp_sectors__clear_table 0x008caccc : { KEEP(*(.text.brp_sectors__clear_table)) }
  ASSERT(SIZEOF(.text.brp_sectors__clear_table) <= 40, "блок brp_sectors__clear_table не влезает в отведённые ему 40 байт")
  .text.vring__find_busy_index 0x008cacf4 : { KEEP(*(.text.vring__find_busy_index)) }
  ASSERT(SIZEOF(.text.vring__find_busy_index) <= 40, "блок vring__find_busy_index не влезает в отведённые ему 40 байт")
  .text.vring__busy_index_or_zero 0x008cad1c : { KEEP(*(.text.vring__busy_index_or_zero)) }
  ASSERT(SIZEOF(.text.vring__busy_index_or_zero) <= 20, "блок vring__busy_index_or_zero не влезает в отведённые ему 20 байт")
  .text.vring__busy_index_or_ff 0x008cad30 : { KEEP(*(.text.vring__busy_index_or_ff)) }
  ASSERT(SIZEOF(.text.vring__busy_index_or_ff) <= 24, "блок vring__busy_index_or_ff не влезает в отведённые ему 24 байт")
  .text.psc__set_two_flags 0x008cad48 : { KEEP(*(.text.psc__set_two_flags)) }
  ASSERT(SIZEOF(.text.psc__set_two_flags) <= 8, "блок psc__set_two_flags не влезает в отведённые ему 8 байт")
  .text.radio_manager_main_sm__on_goto_idle 0x008cad50 : { KEEP(*(.text.radio_manager_main_sm__on_goto_idle)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_goto_idle) <= 4, "блок radio_manager_main_sm__on_goto_idle не влезает в отведённые ему 4 байт")
  .text.lmac_if__gtk_key_id 0x008cad54 : { KEEP(*(.text.lmac_if__gtk_key_id)) }
  ASSERT(SIZEOF(.text.lmac_if__gtk_key_id) <= 100, "блок lmac_if__gtk_key_id не влезает в отведённые ему 100 байт")
  .text.wmi_handler_get_rf_sector_params__handle 0x008cadb8 : { KEEP(*(.text.wmi_handler_get_rf_sector_params__handle)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_rf_sector_params__handle) <= 84, "блок wmi_handler_get_rf_sector_params__handle не влезает в отведённые ему 84 байт")
  .text.wmi_handler_set_rf_sector_params__handle 0x008cae0c : { KEEP(*(.text.wmi_handler_set_rf_sector_params__handle)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_rf_sector_params__handle) <= 88, "блок wmi_handler_set_rf_sector_params__handle не влезает в отведённые ему 88 байт")
  .text.lmac_if_send_get_selected_rf_sector_index 0x008cae64 : { KEEP(*(.text.lmac_if_send_get_selected_rf_sector_index)) }
  ASSERT(SIZEOF(.text.lmac_if_send_get_selected_rf_sector_index) <= 40, "блок lmac_if_send_get_selected_rf_sector_index не влезает в отведённые ему 40 байт")
  .text.lmac_if_send_set_selected_rf_sector_index 0x008cae8c : { KEEP(*(.text.lmac_if_send_set_selected_rf_sector_index)) }
  ASSERT(SIZEOF(.text.lmac_if_send_set_selected_rf_sector_index) <= 40, "блок lmac_if_send_set_selected_rf_sector_index не влезает в отведённые ему 40 байт")
  .text.bad_beacons_detector__handle_bcons_info 0x008caeb4 : { KEEP(*(.text.bad_beacons_detector__handle_bcons_info)) }
  ASSERT(SIZEOF(.text.bad_beacons_detector__handle_bcons_info) <= 220, "блок bad_beacons_detector__handle_bcons_info не влезает в отведённые ему 220 байт")
  .text.lmac_if_rx_on_off_rsp_handler 0x008caf90 : { KEEP(*(.text.lmac_if_rx_on_off_rsp_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_rx_on_off_rsp_handler) <= 8, "блок lmac_if_rx_on_off_rsp_handler не влезает в отведённые ему 8 байт")
  .text.rm_main_sm__inject_lock_evt 0x008caf98 : { KEEP(*(.text.rm_main_sm__inject_lock_evt)) }
  ASSERT(SIZEOF(.text.rm_main_sm__inject_lock_evt) <= 88, "блок rm_main_sm__inject_lock_evt не влезает в отведённые ему 88 байт")
  .text.wmi_handler_get_rf_sector_params__on_radio_locked_cb 0x008caff0 : { KEEP(*(.text.wmi_handler_get_rf_sector_params__on_radio_locked_cb)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_rf_sector_params__on_radio_locked_cb) <= 292, "блок wmi_handler_get_rf_sector_params__on_radio_locked_cb не влезает в отведённые ему 292 байт")
  .text.wmi_handler_set_rf_sector_params__set_rf_sector_params 0x008cb114 : { KEEP(*(.text.wmi_handler_set_rf_sector_params__set_rf_sector_params)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_rf_sector_params__set_rf_sector_params) <= 268, "блок wmi_handler_set_rf_sector_params__set_rf_sector_params не влезает в отведённые ему 268 байт")
  .text.lmac_if__send_get_rf_sector_done 0x008cb220 : { KEEP(*(.text.lmac_if__send_get_rf_sector_done)) }
  ASSERT(SIZEOF(.text.lmac_if__send_get_rf_sector_done) <= 84, "блок lmac_if__send_get_rf_sector_done не влезает в отведённые ему 84 байт")
  .text.lmac_if__send_set_rf_sector_done 0x008cb274 : { KEEP(*(.text.lmac_if__send_set_rf_sector_done)) }
  ASSERT(SIZEOF(.text.lmac_if__send_set_rf_sector_done) <= 76, "блок lmac_if__send_set_rf_sector_done не влезает в отведённые ему 76 байт")
  .text.TX_API__handle_completed_packets 0x008cb2c0 : { KEEP(*(.text.TX_API__handle_completed_packets)) }
  ASSERT(SIZEOF(.text.TX_API__handle_completed_packets) <= 384, "блок TX_API__handle_completed_packets не влезает в отведённые ему 384 байт")
  .text.irq_880b60__ack_b18_post_mbox_oper 0x008cb440 : { KEEP(*(.text.irq_880b60__ack_b18_post_mbox_oper)) }
  ASSERT(SIZEOF(.text.irq_880b60__ack_b18_post_mbox_oper) <= 32, "блок irq_880b60__ack_b18_post_mbox_oper не влезает в отведённые ему 32 байт")
  .text.irq_880b60__ack_b19_post_mbox_dbg 0x008cb460 : { KEEP(*(.text.irq_880b60__ack_b19_post_mbox_dbg)) }
  ASSERT(SIZEOF(.text.irq_880b60__ack_b19_post_mbox_dbg) <= 40, "блок irq_880b60__ack_b19_post_mbox_dbg не влезает в отведённые ему 40 байт")
  .text.hw_880b60__set_and_schedule 0x008cb488 : { KEEP(*(.text.hw_880b60__set_and_schedule)) }
  ASSERT(SIZEOF(.text.hw_880b60__set_and_schedule) <= 28, "блок hw_880b60__set_and_schedule не влезает в отведённые ему 28 байт")
  .text.conn__feed_bcons_info 0x008cb4a4 : { KEEP(*(.text.conn__feed_bcons_info)) }
  ASSERT(SIZEOF(.text.conn__feed_bcons_info) <= 28, "блок conn__feed_bcons_info не влезает в отведённые ему 28 байт")
  .text.conn_mgr__foreach_on_boot_done 0x008cb4c0 : { KEEP(*(.text.conn_mgr__foreach_on_boot_done)) }
  ASSERT(SIZEOF(.text.conn_mgr__foreach_on_boot_done) <= 60, "блок conn_mgr__foreach_on_boot_done не влезает в отведённые ему 60 байт")
  .text.low_sme__handle_rf_kill 0x008cb4fc : { KEEP(*(.text.low_sme__handle_rf_kill)) }
  ASSERT(SIZEOF(.text.low_sme__handle_rf_kill) <= 148, "блок low_sme__handle_rf_kill не влезает в отведённые ему 148 байт")
  .text.irq_880b60__ack_b27_post_rf_kill 0x008cb590 : { KEEP(*(.text.irq_880b60__ack_b27_post_rf_kill)) }
  ASSERT(SIZEOF(.text.irq_880b60__ack_b27_post_rf_kill) <= 32, "блок irq_880b60__ack_b27_post_rf_kill не влезает в отведённые ему 32 байт")
  .text.stub_ret_8cb5b0 0x008cb5b0 : { KEEP(*(.text.stub_ret_8cb5b0)) }
  ASSERT(SIZEOF(.text.stub_ret_8cb5b0) <= 4, "блок stub_ret_8cb5b0 не влезает в отведённые ему 4 байт")
  .text.maintain_sm__on_rs_results 0x008cb5b4 : { KEEP(*(.text.maintain_sm__on_rs_results)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_rs_results) <= 76, "блок maintain_sm__on_rs_results не влезает в отведённые ему 76 байт")
  .text.periodic_service__run 0x008cb600 : { KEEP(*(.text.periodic_service__run)) }
  ASSERT(SIZEOF(.text.periodic_service__run) <= 104, "блок periodic_service__run не влезает в отведённые ему 104 байт")
  .text.ies__has_buffer 0x008cb668 : { KEEP(*(.text.ies__has_buffer)) }
  ASSERT(SIZEOF(.text.ies__has_buffer) <= 12, "блок ies__has_buffer не влезает в отведённые ему 12 байт")
  .text.iter__has_more 0x008cb674 : { KEEP(*(.text.iter__has_more)) }
  ASSERT(SIZEOF(.text.iter__has_more) <= 12, "блок iter__has_more не влезает в отведённые ему 12 байт")
  .text.bitmap__any_free 0x008cb680 : { KEEP(*(.text.bitmap__any_free)) }
  ASSERT(SIZEOF(.text.bitmap__any_free) <= 12, "блок bitmap__any_free не влезает в отведённые ему 12 байт")
  .text.ies__has_ptr 0x008cb68c : { KEEP(*(.text.ies__has_ptr)) }
  ASSERT(SIZEOF(.text.ies__has_ptr) <= 12, "блок ies__has_ptr не влезает в отведённые ему 12 байт")
  .text.WBE_DRIVER__HOST 0x008cb698 : { KEEP(*(.text.WBE_DRIVER__HOST)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__HOST) <= 64, "блок WBE_DRIVER__HOST не влезает в отведённые ему 64 байт")
  .text.lmac_if__send_fw_ready_evt 0x008cb6d8 : { KEEP(*(.text.lmac_if__send_fw_ready_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__send_fw_ready_evt) <= 60, "блок lmac_if__send_fw_ready_evt не влезает в отведённые ему 60 байт")
  .text.hw_sysapi_config_short_vec 0x008cb714 : { KEEP(*(.text.hw_sysapi_config_short_vec)) }
  ASSERT(SIZEOF(.text.hw_sysapi_config_short_vec) <= 64, "блок hw_sysapi_config_short_vec не влезает в отведённые ему 64 байт")
  .text.hw_sysapi_force_mcs 0x008cb754 : { KEEP(*(.text.hw_sysapi_force_mcs)) }
  ASSERT(SIZEOF(.text.hw_sysapi_force_mcs) <= 108, "блок hw_sysapi_force_mcs не влезает в отведённые ему 108 байт")
  .text.set_reg_88af00 0x008cb7c0 : { KEEP(*(.text.set_reg_88af00)) }
  ASSERT(SIZEOF(.text.set_reg_88af00) <= 20, "блок set_reg_88af00 не влезает в отведённые ему 20 байт")
  .text.rgf_reg_88af00 0x008cb7d4 : { KEEP(*(.text.rgf_reg_88af00)) }
  ASSERT(SIZEOF(.text.rgf_reg_88af00) <= 24, "блок rgf_reg_88af00 не влезает в отведённые ему 24 байт")
  .text.ut_hw_drivers_cmd_0x10b 0x008cb7ec : { KEEP(*(.text.ut_hw_drivers_cmd_0x10b)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x10b) <= 28, "блок ut_hw_drivers_cmd_0x10b не влезает в отведённые ему 28 байт")
  .text.hwd_abif_battery_config 0x008cb808 : { KEEP(*(.text.hwd_abif_battery_config)) }
  ASSERT(SIZEOF(.text.hwd_abif_battery_config) <= 168, "блок hwd_abif_battery_config не влезает в отведённые ему 168 байт")
  .text.ut_hw_drivers_cmd_0x131 0x008cb8b0 : { KEEP(*(.text.ut_hw_drivers_cmd_0x131)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x131) <= 24, "блок ut_hw_drivers_cmd_0x131 не влезает в отведённые ему 24 байт")
  .text.hwd_abif__get_88af00 0x008cb8c8 : { KEEP(*(.text.hwd_abif__get_88af00)) }
  ASSERT(SIZEOF(.text.hwd_abif__get_88af00) <= 16, "блок hwd_abif__get_88af00 не влезает в отведённые ему 16 байт")
  .text.hwd_abif__rgf_88af80_8cb8d8 0x008cb8d8 : { KEEP(*(.text.hwd_abif__rgf_88af80_8cb8d8)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88af80_8cb8d8) <= 52, "блок hwd_abif__rgf_88af80_8cb8d8 не влезает в отведённые ему 52 байт")
  .text.hwd_abif__get_88af80 0x008cb90c : { KEEP(*(.text.hwd_abif__get_88af80)) }
  ASSERT(SIZEOF(.text.hwd_abif__get_88af80) <= 64, "блок hwd_abif__get_88af80 не влезает в отведённые ему 64 байт")
  .text.ut_hw_drivers_cmd_0x108 0x008cb94c : { KEEP(*(.text.ut_hw_drivers_cmd_0x108)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x108) <= 24, "блок ut_hw_drivers_cmd_0x108 не влезает в отведённые ему 24 байт")
  .text.hwd_abif__rgf_88af80_8cb964 0x008cb964 : { KEEP(*(.text.hwd_abif__rgf_88af80_8cb964)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88af80_8cb964) <= 68, "блок hwd_abif__rgf_88af80_8cb964 не влезает в отведённые ему 68 байт")
  .text.hwd_abif__rgf_88ae00 0x008cb9a8 : { KEEP(*(.text.hwd_abif__rgf_88ae00)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88ae00) <= 52, "блок hwd_abif__rgf_88ae00 не влезает в отведённые ему 52 байт")
  .text.hwd_abif__program_rf_clk 0x008cb9dc : { KEEP(*(.text.hwd_abif__program_rf_clk)) }
  ASSERT(SIZEOF(.text.hwd_abif__program_rf_clk) <= 52, "блок hwd_abif__program_rf_clk не влезает в отведённые ему 52 байт")
  .text.abif__program_rf_clock_and_wait 0x008cba10 : { KEEP(*(.text.abif__program_rf_clock_and_wait)) }
  ASSERT(SIZEOF(.text.abif__program_rf_clock_and_wait) <= 272, "блок abif__program_rf_clock_and_wait не влезает в отведённые ему 272 байт")
  .text.hwd_abif__set_sel_nibbles 0x008cbb20 : { KEEP(*(.text.hwd_abif__set_sel_nibbles)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_sel_nibbles) <= 160, "блок hwd_abif__set_sel_nibbles не влезает в отведённые ему 160 байт")
  .text.abif__power_up_analog 0x008cbbc0 : { KEEP(*(.text.abif__power_up_analog)) }
  ASSERT(SIZEOF(.text.abif__power_up_analog) <= 208, "блок abif__power_up_analog не влезает в отведённые ему 208 байт")
  .text.hwd_abif__rgf_889480_8cbc90 0x008cbc90 : { KEEP(*(.text.hwd_abif__rgf_889480_8cbc90)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889480_8cbc90) <= 40, "блок hwd_abif__rgf_889480_8cbc90 не влезает в отведённые ему 40 байт")
  .text.hwd_abif__rgf_889400 0x008cbcb8 : { KEEP(*(.text.hwd_abif__rgf_889400)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889400) <= 24, "блок hwd_abif__rgf_889400 не влезает в отведённые ему 24 байт")
  .text.hwd_abif__rgf_889380_8cbcd0 0x008cbcd0 : { KEEP(*(.text.hwd_abif__rgf_889380_8cbcd0)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889380_8cbcd0) <= 24, "блок hwd_abif__rgf_889380_8cbcd0 не влезает в отведённые ему 24 байт")
  .text.hwd_abif_rfc_divider_restart 0x008cbce8 : { KEEP(*(.text.hwd_abif_rfc_divider_restart)) }
  ASSERT(SIZEOF(.text.hwd_abif_rfc_divider_restart) <= 72, "блок hwd_abif_rfc_divider_restart не влезает в отведённые ему 72 байт")
  .text.abif__set_88afa4_bit1_and_wait 0x008cbd30 : { KEEP(*(.text.abif__set_88afa4_bit1_and_wait)) }
  ASSERT(SIZEOF(.text.abif__set_88afa4_bit1_and_wait) <= 92, "блок abif__set_88afa4_bit1_and_wait не влезает в отведённые ему 92 байт")
  .text.hwd_abif__set_88ae60_flags 0x008cbd8c : { KEEP(*(.text.hwd_abif__set_88ae60_flags)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_88ae60_flags) <= 136, "блок hwd_abif__set_88ae60_flags не влезает в отведённые ему 136 байт")
  .text.ut_hw_drivers_cmd_0x12d 0x008cbe14 : { KEEP(*(.text.ut_hw_drivers_cmd_0x12d)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x12d) <= 56, "блок ut_hw_drivers_cmd_0x12d не влезает в отведённые ему 56 байт")
  .text.ut_hw_drivers_cmd_0x12c 0x008cbe4c : { KEEP(*(.text.ut_hw_drivers_cmd_0x12c)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x12c) <= 16, "блок ut_hw_drivers_cmd_0x12c не влезает в отведённые ему 16 байт")
  .text.ut_hw_drivers_cmd_0x12e 0x008cbe5c : { KEEP(*(.text.ut_hw_drivers_cmd_0x12e)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x12e) <= 16, "блок ut_hw_drivers_cmd_0x12e не влезает в отведённые ему 16 байт")
  .text.ut_hw_drivers_cmd_0x111 0x008cbe6c : { KEEP(*(.text.ut_hw_drivers_cmd_0x111)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x111) <= 140, "блок ut_hw_drivers_cmd_0x111 не влезает в отведённые ему 140 байт")
  .text.ut_hw_drivers_cmd_0x116 0x008cbef8 : { KEEP(*(.text.ut_hw_drivers_cmd_0x116)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x116) <= 100, "блок ut_hw_drivers_cmd_0x116 не влезает в отведённые ему 100 байт")
  .text.hwd_abif__get_88af10 0x008cbf5c : { KEEP(*(.text.hwd_abif__get_88af10)) }
  ASSERT(SIZEOF(.text.hwd_abif__get_88af10) <= 40, "блок hwd_abif__get_88af10 не влезает в отведённые ему 40 байт")
  .text.hwd_abif__rgf_88a200_8cbf84 0x008cbf84 : { KEEP(*(.text.hwd_abif__rgf_88a200_8cbf84)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88a200_8cbf84) <= 20, "блок hwd_abif__rgf_88a200_8cbf84 не влезает в отведённые ему 20 байт")
  .text.hwd_abif__adjust_5bit_pair 0x008cbf98 : { KEEP(*(.text.hwd_abif__adjust_5bit_pair)) }
  ASSERT(SIZEOF(.text.hwd_abif__adjust_5bit_pair) <= 184, "блок hwd_abif__adjust_5bit_pair не влезает в отведённые ему 184 байт")
  .text.hwd_abif__set_agc_column 0x008cc050 : { KEEP(*(.text.hwd_abif__set_agc_column)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_agc_column) <= 44, "блок hwd_abif__set_agc_column не влезает в отведённые ему 44 байт")
  .text.hwd_abif__config_vga_rows 0x008cc07c : { KEEP(*(.text.hwd_abif__config_vga_rows)) }
  ASSERT(SIZEOF(.text.hwd_abif__config_vga_rows) <= 76, "блок hwd_abif__config_vga_rows не влезает в отведённые ему 76 байт")
  .text.hwd_abif__set_agc208_w4 0x008cc0c8 : { KEEP(*(.text.hwd_abif__set_agc208_w4)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_agc208_w4) <= 120, "блок hwd_abif__set_agc208_w4 не влезает в отведённые ему 120 байт")
  .text.ut_hw_drivers_cmd_0x11c 0x008cc140 : { KEEP(*(.text.ut_hw_drivers_cmd_0x11c)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x11c) <= 72, "блок ut_hw_drivers_cmd_0x11c не влезает в отведённые ему 72 байт")
  .text.hwd_abif__write_checked 0x008cc188 : { KEEP(*(.text.hwd_abif__write_checked)) }
  ASSERT(SIZEOF(.text.hwd_abif__write_checked) <= 240, "блок hwd_abif__write_checked не влезает в отведённые ему 240 байт")
  .text.hwd_abif__set_vga_gain 0x008cc278 : { KEEP(*(.text.hwd_abif__set_vga_gain)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_vga_gain) <= 156, "блок hwd_abif__set_vga_gain не влезает в отведённые ему 156 байт")
  .text.ut_hw_drivers_cmd_0x133 0x008cc314 : { KEEP(*(.text.ut_hw_drivers_cmd_0x133)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x133) <= 132, "блок ut_hw_drivers_cmd_0x133 не влезает в отведённые ему 132 байт")
  .text.ut_hw_drivers_cmd_0x155 0x008cc398 : { KEEP(*(.text.ut_hw_drivers_cmd_0x155)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x155) <= 48, "блок ut_hw_drivers_cmd_0x155 не влезает в отведённые ему 48 байт")
  .text.hwd_abif__set_agc_field 0x008cc3c8 : { KEEP(*(.text.hwd_abif__set_agc_field)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_agc_field) <= 148, "блок hwd_abif__set_agc_field не влезает в отведённые ему 148 байт")
  .text.ut_hw_drivers_cmd_0x130 0x008cc45c : { KEEP(*(.text.ut_hw_drivers_cmd_0x130)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x130) <= 68, "блок ut_hw_drivers_cmd_0x130 не влезает в отведённые ему 68 байт")
  .text.hwd_abif_rx_table_config_vga_gain 0x008cc4a0 : { KEEP(*(.text.hwd_abif_rx_table_config_vga_gain)) }
  ASSERT(SIZEOF(.text.hwd_abif_rx_table_config_vga_gain) <= 272, "блок hwd_abif_rx_table_config_vga_gain не влезает в отведённые ему 272 байт")
  .text.ut_hw_drivers_cmd_0x142 0x008cc5b0 : { KEEP(*(.text.ut_hw_drivers_cmd_0x142)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x142) <= 108, "блок ut_hw_drivers_cmd_0x142 не влезает в отведённые ему 108 байт")
  .text.ut_hw_drivers_cmd_0x154 0x008cc61c : { KEEP(*(.text.ut_hw_drivers_cmd_0x154)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x154) <= 56, "блок ut_hw_drivers_cmd_0x154 не влезает в отведённые ему 56 байт")
  .text.ut_hw_drivers_cmd_0x151 0x008cc654 : { KEEP(*(.text.ut_hw_drivers_cmd_0x151)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x151) <= 20, "блок ut_hw_drivers_cmd_0x151 не влезает в отведённые ему 20 байт")
  .text.ut_hw_drivers_cmd_0x129 0x008cc668 : { KEEP(*(.text.ut_hw_drivers_cmd_0x129)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x129) <= 12, "блок ut_hw_drivers_cmd_0x129 не влезает в отведённые ему 12 байт")
  .text.hwd_abif__rgf_88a200_8cc674 0x008cc674 : { KEEP(*(.text.hwd_abif__rgf_88a200_8cc674)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88a200_8cc674) <= 88, "блок hwd_abif__rgf_88a200_8cc674 не влезает в отведённые ему 88 байт")
  .text.get_reg88a204_s1_w32 0x008cc6cc : { KEEP(*(.text.get_reg88a204_s1_w32)) }
  ASSERT(SIZEOF(.text.get_reg88a204_s1_w32) <= 16, "блок get_reg88a204_s1_w32 не влезает в отведённые ему 16 байт")
  .text.ut_hw_drivers_cmd_0x135 0x008cc6dc : { KEEP(*(.text.ut_hw_drivers_cmd_0x135)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x135) <= 76, "блок ut_hw_drivers_cmd_0x135 не влезает в отведённые ему 76 байт")
  .text.ut_hw_drivers_cmd_0x141 0x008cc728 : { KEEP(*(.text.ut_hw_drivers_cmd_0x141)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x141) <= 144, "блок ut_hw_drivers_cmd_0x141 не влезает в отведённые ему 144 байт")
  .text.ut_hw_drivers_cmd_0x134 0x008cc7b8 : { KEEP(*(.text.ut_hw_drivers_cmd_0x134)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x134) <= 124, "блок ut_hw_drivers_cmd_0x134 не влезает в отведённые ему 124 байт")
  .text.hwd_abif__get_agc_field 0x008cc834 : { KEEP(*(.text.hwd_abif__get_agc_field)) }
  ASSERT(SIZEOF(.text.hwd_abif__get_agc_field) <= 140, "блок hwd_abif__get_agc_field не влезает в отведённые ему 140 байт")
  .text.hwd_abif_rx_table_read_vga_gain 0x008cc8c0 : { KEEP(*(.text.hwd_abif_rx_table_read_vga_gain)) }
  ASSERT(SIZEOF(.text.hwd_abif_rx_table_read_vga_gain) <= 224, "блок hwd_abif_rx_table_read_vga_gain не влезает в отведённые ему 224 байт")
  .text.ut_hw_drivers_cmd_0x143 0x008cc9a0 : { KEEP(*(.text.ut_hw_drivers_cmd_0x143)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x143) <= 96, "блок ut_hw_drivers_cmd_0x143 не влезает в отведённые ему 96 байт")
  .text.abif__agc_field_rmw 0x008cca00 : { KEEP(*(.text.abif__agc_field_rmw)) }
  ASSERT(SIZEOF(.text.abif__agc_field_rmw) <= 44, "блок abif__agc_field_rmw не влезает в отведённые ему 44 байт")
  .text.hwd_abif__write_agc208_row 0x008cca2c : { KEEP(*(.text.hwd_abif__write_agc208_row)) }
  ASSERT(SIZEOF(.text.hwd_abif__write_agc208_row) <= 76, "блок hwd_abif__write_agc208_row не влезает в отведённые ему 76 байт")
  .text.hwd_abif__set_88af10 0x008cca78 : { KEEP(*(.text.hwd_abif__set_88af10)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_88af10) <= 28, "блок hwd_abif__set_88af10 не влезает в отведённые ему 28 байт")
  .text.hwd_abif__rgf_88a200_8cca94 0x008cca94 : { KEEP(*(.text.hwd_abif__rgf_88a200_8cca94)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88a200_8cca94) <= 52, "блок hwd_abif__rgf_88a200_8cca94 не влезает в отведённые ему 52 байт")
  .text.ut_hw_drivers_cmd_0x128 0x008ccac8 : { KEEP(*(.text.ut_hw_drivers_cmd_0x128)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x128) <= 16, "блок ut_hw_drivers_cmd_0x128 не влезает в отведённые ему 16 байт")
  .text.hwd_abif__rgf_889480_8ccad8 0x008ccad8 : { KEEP(*(.text.hwd_abif__rgf_889480_8ccad8)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889480_8ccad8) <= 112, "блок hwd_abif__rgf_889480_8ccad8 не влезает в отведённые ему 112 байт")
  .text.ut_hw_drivers_cmd_0x127 0x008ccb48 : { KEEP(*(.text.ut_hw_drivers_cmd_0x127)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x127) <= 52, "блок ut_hw_drivers_cmd_0x127 не влезает в отведённые ему 52 байт")
  .text.hwd_abif__rgf_889300_8ccb7c 0x008ccb7c : { KEEP(*(.text.hwd_abif__rgf_889300_8ccb7c)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889300_8ccb7c) <= 84, "блок hwd_abif__rgf_889300_8ccb7c не влезает в отведённые ему 84 байт")
  .text.ut_hw_drivers_cmd_0x139 0x008ccbd0 : { KEEP(*(.text.ut_hw_drivers_cmd_0x139)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x139) <= 156, "блок ut_hw_drivers_cmd_0x139 не влезает в отведённые ему 156 байт")
  .text.ut_hw_drivers_cmd_0x126 0x008ccc6c : { KEEP(*(.text.ut_hw_drivers_cmd_0x126)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x126) <= 12, "блок ut_hw_drivers_cmd_0x126 не влезает в отведённые ему 12 байт")
  .text.hwd_abif__rgf_889300_8ccc78 0x008ccc78 : { KEEP(*(.text.hwd_abif__rgf_889300_8ccc78)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889300_8ccc78) <= 60, "блок hwd_abif__rgf_889300_8ccc78 не влезает в отведённые ему 60 байт")
  .text.ut_hw_drivers_cmd_0x11d 0x008cccb4 : { KEEP(*(.text.ut_hw_drivers_cmd_0x11d)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x11d) <= 64, "блок ut_hw_drivers_cmd_0x11d не влезает в отведённые ему 64 байт")
  .text.hwd_abif__set_agc004_w4 0x008cccf4 : { KEEP(*(.text.hwd_abif__set_agc004_w4)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_agc004_w4) <= 120, "блок hwd_abif__set_agc004_w4 не влезает в отведённые ему 120 байт")
  .text.ut_hw_drivers_cmd_0x121 0x008ccd6c : { KEEP(*(.text.ut_hw_drivers_cmd_0x121)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x121) <= 64, "блок ut_hw_drivers_cmd_0x121 не влезает в отведённые ему 64 байт")
  .text.hwd_abif__set_agc004_w7 0x008ccdac : { KEEP(*(.text.hwd_abif__set_agc004_w7)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_agc004_w7) <= 140, "блок hwd_abif__set_agc004_w7 не влезает в отведённые ему 140 байт")
  .text.hwd_abif__set_agc004_w2 0x008cce38 : { KEEP(*(.text.hwd_abif__set_agc004_w2)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_agc004_w2) <= 136, "блок hwd_abif__set_agc004_w2 не влезает в отведённые ему 136 байт")
  .text.ut_hw_drivers_cmd_0x12f 0x008ccec0 : { KEEP(*(.text.ut_hw_drivers_cmd_0x12f)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x12f) <= 64, "блок ut_hw_drivers_cmd_0x12f не влезает в отведённые ему 64 байт")
  .text.ut_hw_drivers_cmd_0x123 0x008ccf00 : { KEEP(*(.text.ut_hw_drivers_cmd_0x123)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x123) <= 72, "блок ut_hw_drivers_cmd_0x123 не влезает в отведённые ему 72 байт")
  .text.ut_hw_drivers_cmd_0x122 0x008ccf48 : { KEEP(*(.text.ut_hw_drivers_cmd_0x122)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x122) <= 72, "блок ut_hw_drivers_cmd_0x122 не влезает в отведённые ему 72 байт")
  .text.ut_hw_drivers_cmd_0x150 0x008ccf90 : { KEEP(*(.text.ut_hw_drivers_cmd_0x150)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x150) <= 20, "блок ut_hw_drivers_cmd_0x150 не влезает в отведённые ему 20 байт")
  .text.ut_hw_drivers_cmd_0x137 0x008ccfa4 : { KEEP(*(.text.ut_hw_drivers_cmd_0x137)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x137) <= 12, "блок ut_hw_drivers_cmd_0x137 не влезает в отведённые ему 12 байт")
  .text.hwd_abif__rgf_88a000_8ccfb0 0x008ccfb0 : { KEEP(*(.text.hwd_abif__rgf_88a000_8ccfb0)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88a000_8ccfb0) <= 88, "блок hwd_abif__rgf_88a000_8ccfb0 не влезает в отведённые ему 88 байт")
  .text.ut_hw_drivers_cmd_0x138 0x008cd008 : { KEEP(*(.text.ut_hw_drivers_cmd_0x138)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x138) <= 16, "блок ut_hw_drivers_cmd_0x138 не влезает в отведённые ему 16 байт")
  .text.hwd_abif__rgf_88a000_8cd018 0x008cd018 : { KEEP(*(.text.hwd_abif__rgf_88a000_8cd018)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88a000_8cd018) <= 112, "блок hwd_abif__rgf_88a000_8cd018 не влезает в отведённые ему 112 байт")
  .text.abif__set_88afa4_bit0_and_wait 0x008cd088 : { KEEP(*(.text.abif__set_88afa4_bit0_and_wait)) }
  ASSERT(SIZEOF(.text.abif__set_88afa4_bit0_and_wait) <= 88, "блок abif__set_88afa4_bit0_and_wait не влезает в отведённые ему 88 байт")
  .text.abif__wait_88afec_bit0_clear 0x008cd0e0 : { KEEP(*(.text.abif__wait_88afec_bit0_clear)) }
  ASSERT(SIZEOF(.text.abif__wait_88afec_bit0_clear) <= 68, "блок abif__wait_88afec_bit0_clear не влезает в отведённые ему 68 байт")
  .text.abif__power_down_88af80 0x008cd124 : { KEEP(*(.text.abif__power_down_88af80)) }
  ASSERT(SIZEOF(.text.abif__power_down_88af80) <= 40, "блок abif__power_down_88af80 не влезает в отведённые ему 40 байт")
  .text.abif__power_down_889300 0x008cd14c : { KEEP(*(.text.abif__power_down_889300)) }
  ASSERT(SIZEOF(.text.abif__power_down_889300) <= 40, "блок abif__power_down_889300 не влезает в отведённые ему 40 байт")
  .text.hwd_abif__rgf_889380_8cd174 0x008cd174 : { KEEP(*(.text.hwd_abif__rgf_889380_8cd174)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889380_8cd174) <= 56, "блок hwd_abif__rgf_889380_8cd174 не влезает в отведённые ему 56 байт")
  .text.hwd_abif__rgf_880b00 0x008cd1ac : { KEEP(*(.text.hwd_abif__rgf_880b00)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_880b00) <= 28, "блок hwd_abif__rgf_880b00 не влезает в отведённые ему 28 байт")
  .text.set_reg_889480 0x008cd1c8 : { KEEP(*(.text.set_reg_889480)) }
  ASSERT(SIZEOF(.text.set_reg_889480) <= 12, "блок set_reg_889480 не влезает в отведённые ему 12 байт")
  .text.set_reg_889480_8cd1d4 0x008cd1d4 : { KEEP(*(.text.set_reg_889480_8cd1d4)) }
  ASSERT(SIZEOF(.text.set_reg_889480_8cd1d4) <= 12, "блок set_reg_889480_8cd1d4 не влезает в отведённые ему 12 байт")
  .text.hwd_abif__set_889800_8cd1e0 0x008cd1e0 : { KEEP(*(.text.hwd_abif__set_889800_8cd1e0)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_889800_8cd1e0) <= 20, "блок hwd_abif__set_889800_8cd1e0 не влезает в отведённые ему 20 байт")
  .text.hwd_abif__set_889800_8cd1f4 0x008cd1f4 : { KEEP(*(.text.hwd_abif__set_889800_8cd1f4)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_889800_8cd1f4) <= 60, "блок hwd_abif__set_889800_8cd1f4 не влезает в отведённые ему 60 байт")
  .text.hwd_abif__rgf_880b80 0x008cd230 : { KEEP(*(.text.hwd_abif__rgf_880b80)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_880b80) <= 76, "блок hwd_abif__rgf_880b80 не влезает в отведённые ему 76 байт")
  .text.get_reg88afec_s3_w32 0x008cd27c : { KEEP(*(.text.get_reg88afec_s3_w32)) }
  ASSERT(SIZEOF(.text.get_reg88afec_s3_w32) <= 16, "блок get_reg88afec_s3_w32 не влезает в отведённые ему 16 байт")
  .text.hwd_abif__rgf_889480_8cd28c 0x008cd28c : { KEEP(*(.text.hwd_abif__rgf_889480_8cd28c)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_889480_8cd28c) <= 68, "блок hwd_abif__rgf_889480_8cd28c не влезает в отведённые ему 68 байт")
  .text.hwd_abif__rgf_88af00 0x008cd2d0 : { KEEP(*(.text.hwd_abif__rgf_88af00)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88af00) <= 124, "блок hwd_abif__rgf_88af00 не влезает в отведённые ему 124 байт")
  .text.hwd_abif__set_3bit_chain_sel 0x008cd34c : { KEEP(*(.text.hwd_abif__set_3bit_chain_sel)) }
  ASSERT(SIZEOF(.text.hwd_abif__set_3bit_chain_sel) <= 148, "блок hwd_abif__set_3bit_chain_sel не влезает в отведённые ему 148 байт")
  .text.car__toggle_pll_and_wait 0x008cd3e0 : { KEEP(*(.text.car__toggle_pll_and_wait)) }
  ASSERT(SIZEOF(.text.car__toggle_pll_and_wait) <= 152, "блок car__toggle_pll_and_wait не влезает в отведённые ему 152 байт")
  .text.car__enable_pll3_and_wait 0x008cd478 : { KEEP(*(.text.car__enable_pll3_and_wait)) }
  ASSERT(SIZEOF(.text.car__enable_pll3_and_wait) <= 212, "блок car__enable_pll3_and_wait не влезает в отведённые ему 212 байт")
  .text.ut_hw_drivers_cmd_0x203 0x008cd54c : { KEEP(*(.text.ut_hw_drivers_cmd_0x203)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x203) <= 20, "блок ut_hw_drivers_cmd_0x203 не влезает в отведённые ему 20 байт")
  .text.ut_hw_drivers_cmd_0x201 0x008cd560 : { KEEP(*(.text.ut_hw_drivers_cmd_0x201)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x201) <= 8, "блок ut_hw_drivers_cmd_0x201 не влезает в отведённые ему 8 байт")
  .text.rgf_reg_880c00_8cd568 0x008cd568 : { KEEP(*(.text.rgf_reg_880c00_8cd568)) }
  ASSERT(SIZEOF(.text.rgf_reg_880c00_8cd568) <= 40, "блок rgf_reg_880c00_8cd568 не влезает в отведённые ему 40 байт")
  .text.hwd__wait_pll_lock 0x008cd590 : { KEEP(*(.text.hwd__wait_pll_lock)) }
  ASSERT(SIZEOF(.text.hwd__wait_pll_lock) <= 40, "блок hwd__wait_pll_lock не влезает в отведённые ему 40 байт")
  .text.rgf_reg_880c00_8cd5b8 0x008cd5b8 : { KEEP(*(.text.rgf_reg_880c00_8cd5b8)) }
  ASSERT(SIZEOF(.text.rgf_reg_880c00_8cd5b8) <= 36, "блок rgf_reg_880c00_8cd5b8 не влезает в отведённые ему 36 байт")
  .text.hwd_dma__set_ring_base 0x008cd5dc : { KEEP(*(.text.hwd_dma__set_ring_base)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_ring_base) <= 80, "блок hwd_dma__set_ring_base не влезает в отведённые ему 80 байт")
  .text.rgf_reg_880a80_8cd62c 0x008cd62c : { KEEP(*(.text.rgf_reg_880a80_8cd62c)) }
  ASSERT(SIZEOF(.text.rgf_reg_880a80_8cd62c) <= 32, "блок rgf_reg_880a80_8cd62c не влезает в отведённые ему 32 байт")
  .text.vring__reg_write_locked_0c 0x008cd64c : { KEEP(*(.text.vring__reg_write_locked_0c)) }
  ASSERT(SIZEOF(.text.vring__reg_write_locked_0c) <= 48, "блок vring__reg_write_locked_0c не влезает в отведённые ему 48 байт")
  .text.vring__reg_write_locked_20 0x008cd67c : { KEEP(*(.text.vring__reg_write_locked_20)) }
  ASSERT(SIZEOF(.text.vring__reg_write_locked_20) <= 48, "блок vring__reg_write_locked_20 не влезает в отведённые ему 48 байт")
  .text.vring__reg_write_locked_28 0x008cd6ac : { KEEP(*(.text.vring__reg_write_locked_28)) }
  ASSERT(SIZEOF(.text.vring__reg_write_locked_28) <= 48, "блок vring__reg_write_locked_28 не влезает в отведённые ему 48 байт")
  .text.vring__reg_write_locked_3c 0x008cd6dc : { KEEP(*(.text.vring__reg_write_locked_3c)) }
  ASSERT(SIZEOF(.text.vring__reg_write_locked_3c) <= 48, "блок vring__reg_write_locked_3c не влезает в отведённые ему 48 байт")
  .text.vring_hw__set_ready_bit 0x008cd70c : { KEEP(*(.text.vring_hw__set_ready_bit)) }
  ASSERT(SIZEOF(.text.vring_hw__set_ready_bit) <= 40, "блок vring_hw__set_ready_bit не влезает в отведённые ему 40 байт")
  .text.hwd_dma__ack_881c44 0x008cd734 : { KEEP(*(.text.hwd_dma__ack_881c44)) }
  ASSERT(SIZEOF(.text.hwd_dma__ack_881c44) <= 48, "блок hwd_dma__ack_881c44 не влезает в отведённые ему 48 байт")
  .text.vring_hw__write_disable 0x008cd764 : { KEEP(*(.text.vring_hw__write_disable)) }
  ASSERT(SIZEOF(.text.vring_hw__write_disable) <= 48, "блок vring_hw__write_disable не влезает в отведённые ему 48 байт")
  .text.hw_rgf_block_program 0x008cd794 : { KEEP(*(.text.hw_rgf_block_program)) }
  ASSERT(SIZEOF(.text.hw_rgf_block_program) <= 372, "блок hw_rgf_block_program не влезает в отведённые ему 372 байт")
  .text.hwd_dma__reset_ring 0x008cd908 : { KEEP(*(.text.hwd_dma__reset_ring)) }
  ASSERT(SIZEOF(.text.hwd_dma__reset_ring) <= 28, "блок hwd_dma__reset_ring не влезает в отведённые ему 28 байт")
  .text.hwd_dma__enable_ring_bits 0x008cd924 : { KEEP(*(.text.hwd_dma__enable_ring_bits)) }
  ASSERT(SIZEOF(.text.hwd_dma__enable_ring_bits) <= 84, "блок hwd_dma__enable_ring_bits не влезает в отведённые ему 84 байт")
  .text.hwd_dma__bad_cause 0x008cd978 : { KEEP(*(.text.hwd_dma__bad_cause)) }
  ASSERT(SIZEOF(.text.hwd_dma__bad_cause) <= 60, "блок hwd_dma__bad_cause не влезает в отведённые ему 60 байт")
  .text.hwd_dma__init_881c00 0x008cd9b4 : { KEEP(*(.text.hwd_dma__init_881c00)) }
  ASSERT(SIZEOF(.text.hwd_dma__init_881c00) <= 24, "блок hwd_dma__init_881c00 не влезает в отведённые ему 24 байт")
  .text.hwd_dma__set_881c00_8cd9cc 0x008cd9cc : { KEEP(*(.text.hwd_dma__set_881c00_8cd9cc)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_881c00_8cd9cc) <= 20, "блок hwd_dma__set_881c00_8cd9cc не влезает в отведённые ему 20 байт")
  .text.get_reg_881c84 0x008cd9e0 : { KEEP(*(.text.get_reg_881c84)) }
  ASSERT(SIZEOF(.text.get_reg_881c84) <= 12, "блок get_reg_881c84 не влезает в отведённые ему 12 байт")
  .text.vring_hw__read_status_bit 0x008cd9ec : { KEEP(*(.text.vring_hw__read_status_bit)) }
  ASSERT(SIZEOF(.text.vring_hw__read_status_bit) <= 32, "блок vring_hw__read_status_bit не влезает в отведённые ему 32 байт")
  .text.get_reg881bf0_s27_w32 0x008cda0c : { KEEP(*(.text.get_reg881bf0_s27_w32)) }
  ASSERT(SIZEOF(.text.get_reg881bf0_s27_w32) <= 16, "блок get_reg881bf0_s27_w32 не влезает в отведённые ему 16 байт")
  .text.get_reg_8812d4 0x008cda1c : { KEEP(*(.text.get_reg_8812d4)) }
  ASSERT(SIZEOF(.text.get_reg_8812d4) <= 12, "блок get_reg_8812d4 не влезает в отведённые ему 12 байт")
  .text.hwd_dma__get_881c00 0x008cda28 : { KEEP(*(.text.hwd_dma__get_881c00)) }
  ASSERT(SIZEOF(.text.hwd_dma__get_881c00) <= 36, "блок hwd_dma__get_881c00 не влезает в отведённые ему 36 байт")
  .text.hwd_dma__read_cause_881c2c 0x008cda4c : { KEEP(*(.text.hwd_dma__read_cause_881c2c)) }
  ASSERT(SIZEOF(.text.hwd_dma__read_cause_881c2c) <= 36, "блок hwd_dma__read_cause_881c2c не влезает в отведённые ему 36 байт")
  .text.get_reg_8813f0 0x008cda70 : { KEEP(*(.text.get_reg_8813f0)) }
  ASSERT(SIZEOF(.text.get_reg_8813f0) <= 12, "блок get_reg_8813f0 не влезает в отведённые ему 12 байт")
  .text.get_reg_8813c8 0x008cda7c : { KEEP(*(.text.get_reg_8813c8)) }
  ASSERT(SIZEOF(.text.get_reg_8813c8) <= 12, "блок get_reg_8813c8 не влезает в отведённые ему 12 байт")
  .text.stub_ret_8cda88 0x008cda88 : { KEEP(*(.text.stub_ret_8cda88)) }
  ASSERT(SIZEOF(.text.stub_ret_8cda88) <= 8, "блок stub_ret_8cda88 не влезает в отведённые ему 8 байт")
  .text.hwd_dma__macq_reg_addr 0x008cda90 : { KEEP(*(.text.hwd_dma__macq_reg_addr)) }
  ASSERT(SIZEOF(.text.hwd_dma__macq_reg_addr) <= 12, "блок hwd_dma__macq_reg_addr не влезает в отведённые ему 12 байт")
  .text.vring_hw__field_addr_440c0c0 0x008cda9c : { KEEP(*(.text.vring_hw__field_addr_440c0c0)) }
  ASSERT(SIZEOF(.text.vring_hw__field_addr_440c0c0) <= 20, "блок vring_hw__field_addr_440c0c0 не влезает в отведённые ему 20 байт")
  .text.vring_hw__field_addr_440c100 0x008cdab0 : { KEEP(*(.text.vring_hw__field_addr_440c100)) }
  ASSERT(SIZEOF(.text.vring_hw__field_addr_440c100) <= 20, "блок vring_hw__field_addr_440c100 не влезает в отведённые ему 20 байт")
  .text.hwd_dma__read_cause_881c48 0x008cdac4 : { KEEP(*(.text.hwd_dma__read_cause_881c48)) }
  ASSERT(SIZEOF(.text.hwd_dma__read_cause_881c48) <= 36, "блок hwd_dma__read_cause_881c48 не влезает в отведённые ему 36 байт")
  .text.hwd_dma__get_881c80 0x008cdae8 : { KEEP(*(.text.hwd_dma__get_881c80)) }
  ASSERT(SIZEOF(.text.hwd_dma__get_881c80) <= 16, "блок hwd_dma__get_881c80 не влезает в отведённые ему 16 байт")
  .text.dma_is_idle 0x008cdaf8 : { KEEP(*(.text.dma_is_idle)) }
  ASSERT(SIZEOF(.text.dma_is_idle) <= 72, "блок dma_is_idle не влезает в отведённые ему 72 байт")
  .text.hwd_dma__set_prio_map_by_mode 0x008cdb40 : { KEEP(*(.text.hwd_dma__set_prio_map_by_mode)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_prio_map_by_mode) <= 112, "блок hwd_dma__set_prio_map_by_mode не влезает в отведённые ему 112 байт")
  .text.dma_reset 0x008cdbb0 : { KEEP(*(.text.dma_reset)) }
  ASSERT(SIZEOF(.text.dma_reset) <= 56, "блок dma_reset не влезает в отведённые ему 56 байт")
  .text.hwd_dma__reset_vring 0x008cdbe8 : { KEEP(*(.text.hwd_dma__reset_vring)) }
  ASSERT(SIZEOF(.text.hwd_dma__reset_vring) <= 196, "блок hwd_dma__reset_vring не влезает в отведённые ему 196 байт")
  .text.hwd_dma__pack_ring_cfg 0x008cdcac : { KEEP(*(.text.hwd_dma__pack_ring_cfg)) }
  ASSERT(SIZEOF(.text.hwd_dma__pack_ring_cfg) <= 120, "блок hwd_dma__pack_ring_cfg не влезает в отведённые ему 120 байт")
  .text.hwd_dma__set_ring_field_99e0 0x008cdd24 : { KEEP(*(.text.hwd_dma__set_ring_field_99e0)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_ring_field_99e0) <= 96, "блок hwd_dma__set_ring_field_99e0 не влезает в отведённые ему 96 байт")
  .text.hwd_dma__kick_channel 0x008cdd84 : { KEEP(*(.text.hwd_dma__kick_channel)) }
  ASSERT(SIZEOF(.text.hwd_dma__kick_channel) <= 60, "блок hwd_dma__kick_channel не влезает в отведённые ему 60 байт")
  .text.hwd_dma__set_881c00_8cddc0 0x008cddc0 : { KEEP(*(.text.hwd_dma__set_881c00_8cddc0)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_881c00_8cddc0) <= 48, "блок hwd_dma__set_881c00_8cddc0 не влезает в отведённые ему 48 байт")
  .text.hwd_dma__set_881c00_8cddf0 0x008cddf0 : { KEEP(*(.text.hwd_dma__set_881c00_8cddf0)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_881c00_8cddf0) <= 48, "блок hwd_dma__set_881c00_8cddf0 не влезает в отведённые ему 48 байт")
  .text.hwd_dma__ack_881c38 0x008cde20 : { KEEP(*(.text.hwd_dma__ack_881c38)) }
  ASSERT(SIZEOF(.text.hwd_dma__ack_881c38) <= 48, "блок hwd_dma__ack_881c38 не влезает в отведённые ему 48 байт")
  .text.hwd_dma__set_881000 0x008cde50 : { KEEP(*(.text.hwd_dma__set_881000)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_881000) <= 92, "блок hwd_dma__set_881000 не влезает в отведённые ему 92 байт")
  .text.hwd_dma__write_ring_reg 0x008cdeac : { KEEP(*(.text.hwd_dma__write_ring_reg)) }
  ASSERT(SIZEOF(.text.hwd_dma__write_ring_reg) <= 24, "блок hwd_dma__write_ring_reg не влезает в отведённые ему 24 байт")
  .text.hwd_dma__ack_881c54 0x008cdec4 : { KEEP(*(.text.hwd_dma__ack_881c54)) }
  ASSERT(SIZEOF(.text.hwd_dma__ack_881c54) <= 48, "блок hwd_dma__ack_881c54 не влезает в отведённые ему 48 байт")
  .text.hwd_dma__set_ring_field_9a10 0x008cdef4 : { KEEP(*(.text.hwd_dma__set_ring_field_9a10)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_ring_field_9a10) <= 92, "блок hwd_dma__set_ring_field_9a10 не влезает в отведённые ему 92 байт")
  .text.vring_hw__clear_enable_bit 0x008cdf50 : { KEEP(*(.text.vring_hw__clear_enable_bit)) }
  ASSERT(SIZEOF(.text.vring_hw__clear_enable_bit) <= 60, "блок vring_hw__clear_enable_bit не влезает в отведённые ему 60 байт")
  .text.tail_hwd_dma__kick_channel 0x008cdf8c : { KEEP(*(.text.tail_hwd_dma__kick_channel)) }
  ASSERT(SIZEOF(.text.tail_hwd_dma__kick_channel) <= 8, "блок tail_hwd_dma__kick_channel не влезает в отведённые ему 8 байт")
  .text.tail_hwd_dma__kick_channel_8cdf94 0x008cdf94 : { KEEP(*(.text.tail_hwd_dma__kick_channel_8cdf94)) }
  ASSERT(SIZEOF(.text.tail_hwd_dma__kick_channel_8cdf94) <= 8, "блок tail_hwd_dma__kick_channel_8cdf94 не влезает в отведённые ему 8 байт")
  .text.tail_hwd_dma__kick_channel_8cdf9c 0x008cdf9c : { KEEP(*(.text.tail_hwd_dma__kick_channel_8cdf9c)) }
  ASSERT(SIZEOF(.text.tail_hwd_dma__kick_channel_8cdf9c) <= 8, "блок tail_hwd_dma__kick_channel_8cdf9c не влезает в отведённые ему 8 байт")
  .text.tail_hwd_dma__kick_channel_8cdfa4 0x008cdfa4 : { KEEP(*(.text.tail_hwd_dma__kick_channel_8cdfa4)) }
  ASSERT(SIZEOF(.text.tail_hwd_dma__kick_channel_8cdfa4) <= 8, "блок tail_hwd_dma__kick_channel_8cdfa4 не влезает в отведённые ему 8 байт")
  .text.hwd_dma__program_vring_desc 0x008cdfac : { KEEP(*(.text.hwd_dma__program_vring_desc)) }
  ASSERT(SIZEOF(.text.hwd_dma__program_vring_desc) <= 56, "блок hwd_dma__program_vring_desc не влезает в отведённые ему 56 байт")
  .text.hwd_dma__kick_macq 0x008cdfe4 : { KEEP(*(.text.hwd_dma__kick_macq)) }
  ASSERT(SIZEOF(.text.hwd_dma__kick_macq) <= 96, "блок hwd_dma__kick_macq не влезает в отведённые ему 96 байт")
  .text.pcie__l1_dwell_stats 0x008ce044 : { KEEP(*(.text.pcie__l1_dwell_stats)) }
  ASSERT(SIZEOF(.text.pcie__l1_dwell_stats) <= 132, "блок pcie__l1_dwell_stats не влезает в отведённые ему 132 байт")
  .text.mac__pack_addr_word 0x008ce0c8 : { KEEP(*(.text.mac__pack_addr_word)) }
  ASSERT(SIZEOF(.text.mac__pack_addr_word) <= 52, "блок mac__pack_addr_word не влезает в отведённые ему 52 байт")
  .text.set_reg_88c048_x2 0x008ce0fc : { KEEP(*(.text.set_reg_88c048_x2)) }
  ASSERT(SIZEOF(.text.set_reg_88c048_x2) <= 20, "блок set_reg_88c048_x2 не влезает в отведённые ему 20 байт")
  .text.hwd_pcie__set_clk_gating 0x008ce110 : { KEEP(*(.text.hwd_pcie__set_clk_gating)) }
  ASSERT(SIZEOF(.text.hwd_pcie__set_clk_gating) <= 76, "блок hwd_pcie__set_clk_gating не влезает в отведённые ему 76 байт")
  .text.hwd_mac__enable_multicast 0x008ce15c : { KEEP(*(.text.hwd_mac__enable_multicast)) }
  ASSERT(SIZEOF(.text.hwd_mac__enable_multicast) <= 32, "блок hwd_mac__enable_multicast не влезает в отведённые ему 32 байт")
  .text.add_key 0x008ce17c : { KEEP(*(.text.add_key)) }
  ASSERT(SIZEOF(.text.add_key) <= 104, "блок add_key не влезает в отведённые ему 104 байт")
  .text.hwd_mac__set_prio_map_by_mode 0x008ce1e4 : { KEEP(*(.text.hwd_mac__set_prio_map_by_mode)) }
  ASSERT(SIZEOF(.text.hwd_mac__set_prio_map_by_mode) <= 124, "блок hwd_mac__set_prio_map_by_mode не влезает в отведённые ему 124 байт")
  .text.hwd_mac__rgf_886200 0x008ce260 : { KEEP(*(.text.hwd_mac__rgf_886200)) }
  ASSERT(SIZEOF(.text.hwd_mac__rgf_886200) <= 52, "блок hwd_mac__rgf_886200 не влезает в отведённые ему 52 байт")
  .text.hwd_mac__set_886d80_8ce294 0x008ce294 : { KEEP(*(.text.hwd_mac__set_886d80_8ce294)) }
  ASSERT(SIZEOF(.text.hwd_mac__set_886d80_8ce294) <= 24, "блок hwd_mac__set_886d80_8ce294 не влезает в отведённые ему 24 байт")
  .text.set_reg_886dc8 0x008ce2ac : { KEEP(*(.text.set_reg_886dc8)) }
  ASSERT(SIZEOF(.text.set_reg_886dc8) <= 16, "блок set_reg_886dc8 не влезает в отведённые ему 16 байт")
  .text.hwd_mac__set_886d80_8ce2bc 0x008ce2bc : { KEEP(*(.text.hwd_mac__set_886d80_8ce2bc)) }
  ASSERT(SIZEOF(.text.hwd_mac__set_886d80_8ce2bc) <= 68, "блок hwd_mac__set_886d80_8ce2bc не влезает в отведённые ему 68 байт")
  .text.set_reg_886dc8_8ce300 0x008ce300 : { KEEP(*(.text.set_reg_886dc8_8ce300)) }
  ASSERT(SIZEOF(.text.set_reg_886dc8_8ce300) <= 16, "блок set_reg_886dc8_8ce300 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie__is_l1_state 0x008ce310 : { KEEP(*(.text.hwd_pcie__is_l1_state)) }
  ASSERT(SIZEOF(.text.hwd_pcie__is_l1_state) <= 28, "блок hwd_pcie__is_l1_state не влезает в отведённые ему 28 байт")
  .text.hwd_pcie_ltssm_is_l1_idle 0x008ce32c : { KEEP(*(.text.hwd_pcie_ltssm_is_l1_idle)) }
  ASSERT(SIZEOF(.text.hwd_pcie_ltssm_is_l1_idle) <= 24, "блок hwd_pcie_ltssm_is_l1_idle не влезает в отведённые ему 24 байт")
  .text.pcie__ready_for_deep_sleep 0x008ce344 : { KEEP(*(.text.pcie__ready_for_deep_sleep)) }
  ASSERT(SIZEOF(.text.pcie__ready_for_deep_sleep) <= 36, "блок pcie__ready_for_deep_sleep не влезает в отведённые ему 36 байт")
  .text.pcie__l1_idle_and_park 0x008ce368 : { KEEP(*(.text.pcie__l1_idle_and_park)) }
  ASSERT(SIZEOF(.text.pcie__l1_idle_and_park) <= 28, "блок pcie__l1_idle_and_park не влезает в отведённые ему 28 байт")
  .text.pcie__apply_880a80_mode 0x008ce384 : { KEEP(*(.text.pcie__apply_880a80_mode)) }
  ASSERT(SIZEOF(.text.pcie__apply_880a80_mode) <= 76, "блок pcie__apply_880a80_mode не влезает в отведённые ему 76 байт")
  .text.pcie__program_880a80_seq 0x008ce3d0 : { KEEP(*(.text.pcie__program_880a80_seq)) }
  ASSERT(SIZEOF(.text.pcie__program_880a80_seq) <= 104, "блок pcie__program_880a80_seq не влезает в отведённые ему 104 байт")
  .text.pcie__mirror_link_bit 0x008ce438 : { KEEP(*(.text.pcie__mirror_link_bit)) }
  ASSERT(SIZEOF(.text.pcie__mirror_link_bit) <= 44, "блок pcie__mirror_link_bit не влезает в отведённые ему 44 байт")
  .text.mac__reset_882680 0x008ce464 : { KEEP(*(.text.mac__reset_882680)) }
  ASSERT(SIZEOF(.text.mac__reset_882680) <= 16, "блок mac__reset_882680 не влезает в отведённые ему 16 байт")
  .text.rgf_reg_882680 0x008ce474 : { KEEP(*(.text.rgf_reg_882680)) }
  ASSERT(SIZEOF(.text.rgf_reg_882680) <= 12, "блок rgf_reg_882680 не влезает в отведённые ему 12 байт")
  .text.pcie_debug__code_to_index 0x008ce480 : { KEEP(*(.text.pcie_debug__code_to_index)) }
  ASSERT(SIZEOF(.text.pcie_debug__code_to_index) <= 36, "блок pcie_debug__code_to_index не влезает в отведённые ему 36 байт")
  .text.set_reg_882644 0x008ce4a4 : { KEEP(*(.text.set_reg_882644)) }
  ASSERT(SIZEOF(.text.set_reg_882644) <= 16, "блок set_reg_882644 не влезает в отведённые ему 16 байт")
  .text.pcie__wait_882644_ready 0x008ce4b4 : { KEEP(*(.text.pcie__wait_882644_ready)) }
  ASSERT(SIZEOF(.text.pcie__wait_882644_ready) <= 40, "блок pcie__wait_882644_ready не влезает в отведённые ему 40 байт")
  .text.set_reg_88264c 0x008ce4dc : { KEEP(*(.text.set_reg_88264c)) }
  ASSERT(SIZEOF(.text.set_reg_88264c) <= 12, "блок set_reg_88264c не влезает в отведённые ему 12 байт")
  .text.set_reg_882600 0x008ce4e8 : { KEEP(*(.text.set_reg_882600)) }
  ASSERT(SIZEOF(.text.set_reg_882600) <= 20, "блок set_reg_882600 не влезает в отведённые ему 20 байт")
  .text.set_reg_882684 0x008ce4fc : { KEEP(*(.text.set_reg_882684)) }
  ASSERT(SIZEOF(.text.set_reg_882684) <= 16, "блок set_reg_882684 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie__rgf_880a80_8ce50c 0x008ce50c : { KEEP(*(.text.hwd_pcie__rgf_880a80_8ce50c)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_880a80_8ce50c) <= 84, "блок hwd_pcie__rgf_880a80_8ce50c не влезает в отведённые ему 84 байт")
  .text.hwd_pcie__rgf_882b80 0x008ce560 : { KEEP(*(.text.hwd_pcie__rgf_882b80)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_882b80) <= 24, "блок hwd_pcie__rgf_882b80 не влезает в отведённые ему 24 байт")
  .text.hwd_pcie_exit_l1 0x008ce578 : { KEEP(*(.text.hwd_pcie_exit_l1)) }
  ASSERT(SIZEOF(.text.hwd_pcie_exit_l1) <= 304, "блок hwd_pcie_exit_l1 не влезает в отведённые ему 304 байт")
  .text.pcie__read_error_counters 0x008ce6a8 : { KEEP(*(.text.pcie__read_error_counters)) }
  ASSERT(SIZEOF(.text.pcie__read_error_counters) <= 32, "блок pcie__read_error_counters не влезает в отведённые ему 32 байт")
  .text.get_reg88265c_s1_w32 0x008ce6c8 : { KEEP(*(.text.get_reg88265c_s1_w32)) }
  ASSERT(SIZEOF(.text.get_reg88265c_s1_w32) <= 16, "блок get_reg88265c_s1_w32 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie__rgf_882600 0x008ce6d8 : { KEEP(*(.text.hwd_pcie__rgf_882600)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_882600) <= 12, "блок hwd_pcie__rgf_882600 не влезает в отведённые ему 12 байт")
  .text.hwd_pcie__rgf_882f80 0x008ce6e4 : { KEEP(*(.text.hwd_pcie__rgf_882f80)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_882f80) <= 12, "блок hwd_pcie__rgf_882f80 не влезает в отведённые ему 12 байт")
  .text.get_reg88b0c0_s2_w32 0x008ce6f0 : { KEEP(*(.text.get_reg88b0c0_s2_w32)) }
  ASSERT(SIZEOF(.text.get_reg88b0c0_s2_w32) <= 16, "блок get_reg88b0c0_s2_w32 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie__get_ltssm_state 0x008ce700 : { KEEP(*(.text.hwd_pcie__get_ltssm_state)) }
  ASSERT(SIZEOF(.text.hwd_pcie__get_ltssm_state) <= 32, "блок hwd_pcie__get_ltssm_state не влезает в отведённые ему 32 байт")
  .text.get_reg_8825c0 0x008ce720 : { KEEP(*(.text.get_reg_8825c0)) }
  ASSERT(SIZEOF(.text.get_reg_8825c0) <= 12, "блок get_reg_8825c0 не влезает в отведённые ему 12 байт")
  .text.hwd_pcie__get_882b80 0x008ce72c : { KEEP(*(.text.hwd_pcie__get_882b80)) }
  ASSERT(SIZEOF(.text.hwd_pcie__get_882b80) <= 12, "блок hwd_pcie__get_882b80 не влезает в отведённые ему 12 байт")
  .text.get_reg88262c_s11_w32 0x008ce738 : { KEEP(*(.text.get_reg88262c_s11_w32)) }
  ASSERT(SIZEOF(.text.get_reg88262c_s11_w32) <= 16, "блок get_reg88262c_s11_w32 не влезает в отведённые ему 16 байт")
  .text.set_reg_882648 0x008ce748 : { KEEP(*(.text.set_reg_882648)) }
  ASSERT(SIZEOF(.text.set_reg_882648) <= 20, "блок set_reg_882648 не влезает в отведённые ему 20 байт")
  .text.get_reg_882650 0x008ce75c : { KEEP(*(.text.get_reg_882650)) }
  ASSERT(SIZEOF(.text.get_reg_882650) <= 12, "блок get_reg_882650 не влезает в отведённые ему 12 байт")
  .text.set_reg_882650 0x008ce768 : { KEEP(*(.text.set_reg_882650)) }
  ASSERT(SIZEOF(.text.set_reg_882650) <= 12, "блок set_reg_882650 не влезает в отведённые ему 12 байт")
  .text.get_reg8825bc_bit3_inv 0x008ce774 : { KEEP(*(.text.get_reg8825bc_bit3_inv)) }
  ASSERT(SIZEOF(.text.get_reg8825bc_bit3_inv) <= 20, "блок get_reg8825bc_bit3_inv не влезает в отведённые ему 20 байт")
  .text.pcie_irq__extract_bit_by_code 0x008ce788 : { KEEP(*(.text.pcie_irq__extract_bit_by_code)) }
  ASSERT(SIZEOF(.text.pcie_irq__extract_bit_by_code) <= 80, "блок pcie_irq__extract_bit_by_code не влезает в отведённые ему 80 байт")
  .text.pcie__force_clear_l0s 0x008ce7d8 : { KEEP(*(.text.pcie__force_clear_l0s)) }
  ASSERT(SIZEOF(.text.pcie__force_clear_l0s) <= 132, "блок pcie__force_clear_l0s не влезает в отведённые ему 132 байт")
  .text.hwd_pcie__toggle_882f80_bits 0x008ce85c : { KEEP(*(.text.hwd_pcie__toggle_882f80_bits)) }
  ASSERT(SIZEOF(.text.hwd_pcie__toggle_882f80_bits) <= 56, "блок hwd_pcie__toggle_882f80_bits не влезает в отведённые ему 56 байт")
  .text.pcie_ltssm__code_to_index 0x008ce894 : { KEEP(*(.text.pcie_ltssm__code_to_index)) }
  ASSERT(SIZEOF(.text.pcie_ltssm__code_to_index) <= 24, "блок pcie_ltssm__code_to_index не влезает в отведённые ему 24 байт")
  .text.set_reg_882fe0 0x008ce8ac : { KEEP(*(.text.set_reg_882fe0)) }
  ASSERT(SIZEOF(.text.set_reg_882fe0) <= 16, "блок set_reg_882fe0 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie__rgf_882f80_8ce8bc 0x008ce8bc : { KEEP(*(.text.hwd_pcie__rgf_882f80_8ce8bc)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_882f80_8ce8bc) <= 28, "блок hwd_pcie__rgf_882f80_8ce8bc не влезает в отведённые ему 28 байт")
  .text.set_reg_882fd0 0x008ce8f8 : { KEEP(*(.text.set_reg_882fd0)) }
  ASSERT(SIZEOF(.text.set_reg_882fd0) <= 16, "блок set_reg_882fd0 не влезает в отведённые ему 16 байт")
  .text.set_reg_882fe0_8ce908 0x008ce908 : { KEEP(*(.text.set_reg_882fe0_8ce908)) }
  ASSERT(SIZEOF(.text.set_reg_882fe0_8ce908) <= 16, "блок set_reg_882fe0_8ce908 не влезает в отведённые ему 16 байт")
  .text.set_reg_882fe4 0x008ce918 : { KEEP(*(.text.set_reg_882fe4)) }
  ASSERT(SIZEOF(.text.set_reg_882fe4) <= 16, "блок set_reg_882fe4 не влезает в отведённые ему 16 байт")
  .text.set_reg_882fd8 0x008ce928 : { KEEP(*(.text.set_reg_882fd8)) }
  ASSERT(SIZEOF(.text.set_reg_882fd8) <= 16, "блок set_reg_882fd8 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie_l1_exit_isr 0x008ce938 : { KEEP(*(.text.hwd_pcie_l1_exit_isr)) }
  ASSERT(SIZEOF(.text.hwd_pcie_l1_exit_isr) <= 16, "блок hwd_pcie_l1_exit_isr не влезает в отведённые ему 16 байт")
  .text.get_reg882fd4_s19_w32 0x008ce948 : { KEEP(*(.text.get_reg882fd4_s19_w32)) }
  ASSERT(SIZEOF(.text.get_reg882fd4_s19_w32) <= 16, "блок get_reg882fd4_s19_w32 не влезает в отведённые ему 16 байт")
  .text.hwd_pcie_l1_pm_sub_ctl_get 0x008ce958 : { KEEP(*(.text.hwd_pcie_l1_pm_sub_ctl_get)) }
  ASSERT(SIZEOF(.text.hwd_pcie_l1_pm_sub_ctl_get) <= 52, "блок hwd_pcie_l1_pm_sub_ctl_get не влезает в отведённые ему 52 байт")
  .text.pcie__dbi_write_seq 0x008ce98c : { KEEP(*(.text.pcie__dbi_write_seq)) }
  ASSERT(SIZEOF(.text.pcie__dbi_write_seq) <= 32, "блок pcie__dbi_write_seq не влезает в отведённые ему 32 байт")
  .text.hwd_pcie_l1_sub_timing_config 0x008ce9ac : { KEEP(*(.text.hwd_pcie_l1_sub_timing_config)) }
  ASSERT(SIZEOF(.text.hwd_pcie_l1_sub_timing_config) <= 140, "блок hwd_pcie_l1_sub_timing_config не влезает в отведённые ему 140 байт")
  .text.pcie__serdes_program_all 0x008cea38 : { KEEP(*(.text.pcie__serdes_program_all)) }
  ASSERT(SIZEOF(.text.pcie__serdes_program_all) <= 28, "блок pcie__serdes_program_all не влезает в отведённые ему 28 байт")
  .text.hwd_pcie__rgf_880c00 0x008cea54 : { KEEP(*(.text.hwd_pcie__rgf_880c00)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_880c00) <= 40, "блок hwd_pcie__rgf_880c00 не влезает в отведённые ему 40 байт")
  .text.hwd_pcie__clear_88b000_bits 0x008cea7c : { KEEP(*(.text.hwd_pcie__clear_88b000_bits)) }
  ASSERT(SIZEOF(.text.hwd_pcie__clear_88b000_bits) <= 60, "блок hwd_pcie__clear_88b000_bits не влезает в отведённые ему 60 байт")
  .text.pcie__l1ss_enable 0x008ceab8 : { KEEP(*(.text.pcie__l1ss_enable)) }
  ASSERT(SIZEOF(.text.pcie__l1ss_enable) <= 88, "блок pcie__l1ss_enable не влезает в отведённые ему 88 байт")
  .text.hwd_pcie_config_lnkctl 0x008ceb10 : { KEEP(*(.text.hwd_pcie_config_lnkctl)) }
  ASSERT(SIZEOF(.text.hwd_pcie_config_lnkctl) <= 48, "блок hwd_pcie_config_lnkctl не влезает в отведённые ему 48 байт")
  .text.hwd_pcie_lnkctl_set 0x008ceb40 : { KEEP(*(.text.hwd_pcie_lnkctl_set)) }
  ASSERT(SIZEOF(.text.hwd_pcie_lnkctl_set) <= 64, "блок hwd_pcie_lnkctl_set не влезает в отведённые ему 64 байт")
  .text.pcie__fix_max_read_req 0x008ceb80 : { KEEP(*(.text.pcie__fix_max_read_req)) }
  ASSERT(SIZEOF(.text.pcie__fix_max_read_req) <= 140, "блок pcie__fix_max_read_req не влезает в отведённые ему 140 байт")
  .text.hwd_pcie__set_mode_map 0x008cec0c : { KEEP(*(.text.hwd_pcie__set_mode_map)) }
  ASSERT(SIZEOF(.text.hwd_pcie__set_mode_map) <= 140, "блок hwd_pcie__set_mode_map не влезает в отведённые ему 140 байт")
  .text.hwd_pcie__rgf_882f80_8cec98 0x008cec98 : { KEEP(*(.text.hwd_pcie__rgf_882f80_8cec98)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_882f80_8cec98) <= 20, "блок hwd_pcie__rgf_882f80_8cec98 не влезает в отведённые ему 20 байт")
  .text.set_reg_882684_8cecac 0x008cecac : { KEEP(*(.text.set_reg_882684_8cecac)) }
  ASSERT(SIZEOF(.text.set_reg_882684_8cecac) <= 12, "блок set_reg_882684_8cecac не влезает в отведённые ему 12 байт")
  .text.set_reg_882670 0x008cecb8 : { KEEP(*(.text.set_reg_882670)) }
  ASSERT(SIZEOF(.text.set_reg_882670) <= 12, "блок set_reg_882670 не влезает в отведённые ему 12 байт")
  .text.set_reg_882684_8cecc4 0x008cecc4 : { KEEP(*(.text.set_reg_882684_8cecc4)) }
  ASSERT(SIZEOF(.text.set_reg_882684_8cecc4) <= 12, "блок set_reg_882684_8cecc4 не влезает в отведённые ему 12 байт")
  .text.hwd_pcie__rgf_880a80_8cecd0 0x008cecd0 : { KEEP(*(.text.hwd_pcie__rgf_880a80_8cecd0)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_880a80_8cecd0) <= 116, "блок hwd_pcie__rgf_880a80_8cecd0 не влезает в отведённые ему 116 байт")
  .text.pcie__serdes_clk_gate 0x008ced44 : { KEEP(*(.text.pcie__serdes_clk_gate)) }
  ASSERT(SIZEOF(.text.pcie__serdes_clk_gate) <= 52, "блок pcie__serdes_clk_gate не влезает в отведённые ему 52 байт")
  .text.hwd_pcie__rgf_880a80_8ced78 0x008ced78 : { KEEP(*(.text.hwd_pcie__rgf_880a80_8ced78)) }
  ASSERT(SIZEOF(.text.hwd_pcie__rgf_880a80_8ced78) <= 84, "блок hwd_pcie__rgf_880a80_8ced78 не влезает в отведённые ему 84 байт")
  .text.pcie__mask_interrupts 0x008cedcc : { KEEP(*(.text.pcie__mask_interrupts)) }
  ASSERT(SIZEOF(.text.pcie__mask_interrupts) <= 36, "блок pcie__mask_interrupts не влезает в отведённые ему 36 байт")
  .text.pcie__set_event_bit 0x008cedf0 : { KEEP(*(.text.pcie__set_event_bit)) }
  ASSERT(SIZEOF(.text.pcie__set_event_bit) <= 40, "блок pcie__set_event_bit не влезает в отведённые ему 40 байт")
  .text.rgf_reg_880a80_8cee18 0x008cee18 : { KEEP(*(.text.rgf_reg_880a80_8cee18)) }
  ASSERT(SIZEOF(.text.rgf_reg_880a80_8cee18) <= 48, "блок rgf_reg_880a80_8cee18 не влезает в отведённые ему 48 байт")
  .text.tail_pcie__set_event_bit 0x008cee48 : { KEEP(*(.text.tail_pcie__set_event_bit)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit) <= 8, "блок tail_pcie__set_event_bit не влезает в отведённые ему 8 байт")
  .text.tail_pcie__set_event_bit_8cee50 0x008cee50 : { KEEP(*(.text.tail_pcie__set_event_bit_8cee50)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8cee50) <= 8, "блок tail_pcie__set_event_bit_8cee50 не влезает в отведённые ему 8 байт")
  .text.tail_pcie__set_event_bit_8cee58 0x008cee58 : { KEEP(*(.text.tail_pcie__set_event_bit_8cee58)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8cee58) <= 8, "блок tail_pcie__set_event_bit_8cee58 не влезает в отведённые ему 8 байт")
  .text.tail_pcie__set_event_bit_8cee60 0x008cee60 : { KEEP(*(.text.tail_pcie__set_event_bit_8cee60)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8cee60) <= 8, "блок tail_pcie__set_event_bit_8cee60 не влезает в отведённые ему 8 байт")
  .text.tail_pcie__set_event_bit_8cee68 0x008cee68 : { KEEP(*(.text.tail_pcie__set_event_bit_8cee68)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8cee68) <= 8, "блок tail_pcie__set_event_bit_8cee68 не влезает в отведённые ему 8 байт")
  .text.tail_pcie__set_event_bit_8cee70 0x008cee70 : { KEEP(*(.text.tail_pcie__set_event_bit_8cee70)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8cee70) <= 8, "блок tail_pcie__set_event_bit_8cee70 не влезает в отведённые ему 8 байт")
  .text.rgf_reg_88b080 0x008cee78 : { KEEP(*(.text.rgf_reg_88b080)) }
  ASSERT(SIZEOF(.text.rgf_reg_88b080) <= 24, "блок rgf_reg_88b080 не влезает в отведённые ему 24 байт")
  .text.hwd_phy__enable_880a80 0x008cee90 : { KEEP(*(.text.hwd_phy__enable_880a80)) }
  ASSERT(SIZEOF(.text.hwd_phy__enable_880a80) <= 68, "блок hwd_phy__enable_880a80 не влезает в отведённые ему 68 байт")
  .text.hwd_phy_dbg_clk_enable 0x008ceed4 : { KEEP(*(.text.hwd_phy_dbg_clk_enable)) }
  ASSERT(SIZEOF(.text.hwd_phy_dbg_clk_enable) <= 104, "блок hwd_phy_dbg_clk_enable не влезает в отведённые ему 104 байт")
  .text.ut_hw_drivers_cmd_0x434 0x008cef3c : { KEEP(*(.text.ut_hw_drivers_cmd_0x434)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x434) <= 16, "блок ut_hw_drivers_cmd_0x434 не влезает в отведённые ему 16 байт")
  .text.hwd_phy_get_rx_swap_iq 0x008cef4c : { KEEP(*(.text.hwd_phy_get_rx_swap_iq)) }
  ASSERT(SIZEOF(.text.hwd_phy_get_rx_swap_iq) <= 100, "блок hwd_phy_get_rx_swap_iq не влезает в отведённые ему 100 байт")
  .text.hwd_phy_get_tx_swap_iq 0x008cefb0 : { KEEP(*(.text.hwd_phy_get_tx_swap_iq)) }
  ASSERT(SIZEOF(.text.hwd_phy_get_tx_swap_iq) <= 64, "блок hwd_phy_get_tx_swap_iq не влезает в отведённые ему 64 байт")
  .text.hwd_phy_init 0x008ceff0 : { KEEP(*(.text.hwd_phy_init)) }
  ASSERT(SIZEOF(.text.hwd_phy_init) <= 92, "блок hwd_phy_init не влезает в отведённые ему 92 байт")
  .text.hwd_phy__rgf_880c00 0x008cf04c : { KEEP(*(.text.hwd_phy__rgf_880c00)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_880c00) <= 48, "блок hwd_phy__rgf_880c00 не влезает в отведённые ему 48 байт")
  .text.hwd_phy__set_880c00 0x008cf07c : { KEEP(*(.text.hwd_phy__set_880c00)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_880c00) <= 104, "блок hwd_phy__set_880c00 не влезает в отведённые ему 104 байт")
  .text.hwd_phy__get_885110 0x008cf0e4 : { KEEP(*(.text.hwd_phy__get_885110)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_885110) <= 52, "блок hwd_phy__get_885110 не влезает в отведённые ему 52 байт")
  .text.ut_hw_drivers_cmd_0x41f 0x008cf118 : { KEEP(*(.text.ut_hw_drivers_cmd_0x41f)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x41f) <= 24, "блок ut_hw_drivers_cmd_0x41f не влезает в отведённые ему 24 байт")
  .text.ut_hw_drivers_cmd_0x436 0x008cf130 : { KEEP(*(.text.ut_hw_drivers_cmd_0x436)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x436) <= 16, "блок ut_hw_drivers_cmd_0x436 не влезает в отведённые ему 16 байт")
  .text.hwd_phy__set_885000 0x008cf140 : { KEEP(*(.text.hwd_phy__set_885000)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_885000) <= 68, "блок hwd_phy__set_885000 не влезает в отведённые ему 68 байт")
  .text.hwd_phy__rgf_885000_8cf184 0x008cf184 : { KEEP(*(.text.hwd_phy__rgf_885000_8cf184)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_885000_8cf184) <= 20, "блок hwd_phy__rgf_885000_8cf184 не влезает в отведённые ему 20 байт")
  .text.hwd_phy__rgf_885000_8cf198 0x008cf198 : { KEEP(*(.text.hwd_phy__rgf_885000_8cf198)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_885000_8cf198) <= 16, "блок hwd_phy__rgf_885000_8cf198 не влезает в отведённые ему 16 байт")
  .text.ut_hw_drivers_cmd_0x41d 0x008cf1a8 : { KEEP(*(.text.ut_hw_drivers_cmd_0x41d)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x41d) <= 16, "блок ut_hw_drivers_cmd_0x41d не влезает в отведённые ему 16 байт")
  .text.phy__power_up_and_wait_ack 0x008cf1b8 : { KEEP(*(.text.phy__power_up_and_wait_ack)) }
  ASSERT(SIZEOF(.text.phy__power_up_and_wait_ack) <= 236, "блок phy__power_up_and_wait_ack не влезает в отведённые ему 236 байт")
  .text.hwd_phy__config_by_mode 0x008cf2a4 : { KEEP(*(.text.hwd_phy__config_by_mode)) }
  ASSERT(SIZEOF(.text.hwd_phy__config_by_mode) <= 480, "блок hwd_phy__config_by_mode не влезает в отведённые ему 480 байт")
  .text.hwd_phy__enable_880b00 0x008cf484 : { KEEP(*(.text.hwd_phy__enable_880b00)) }
  ASSERT(SIZEOF(.text.hwd_phy__enable_880b00) <= 68, "блок hwd_phy__enable_880b00 не влезает в отведённые ему 68 байт")
  .text.hwd_phy__rgf_883000_8cf4c8 0x008cf4c8 : { KEEP(*(.text.hwd_phy__rgf_883000_8cf4c8)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_8cf4c8) <= 52, "блок hwd_phy__rgf_883000_8cf4c8 не влезает в отведённые ему 52 байт")
  .text.hwd_phy__rgf_884000 0x008cf4fc : { KEEP(*(.text.hwd_phy__rgf_884000)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_884000) <= 48, "блок hwd_phy__rgf_884000 не влезает в отведённые ему 48 байт")
  .text.hwd_phy__rgf_883000_8cf52c 0x008cf52c : { KEEP(*(.text.hwd_phy__rgf_883000_8cf52c)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_8cf52c) <= 92, "блок hwd_phy__rgf_883000_8cf52c не влезает в отведённые ему 92 байт")
  .text.hwd_phy__set_mode 0x008cf588 : { KEEP(*(.text.hwd_phy__set_mode)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_mode) <= 220, "блок hwd_phy__set_mode не влезает в отведённые ему 220 байт")
  .text.hwd_phy__program_883a68_block 0x008cf664 : { KEEP(*(.text.hwd_phy__program_883a68_block)) }
  ASSERT(SIZEOF(.text.hwd_phy__program_883a68_block) <= 148, "блок hwd_phy__program_883a68_block не влезает в отведённые ему 148 байт")
  .text.hwd_phy__read_status_pair 0x008cf6f8 : { KEEP(*(.text.hwd_phy__read_status_pair)) }
  ASSERT(SIZEOF(.text.hwd_phy__read_status_pair) <= 84, "блок hwd_phy__read_status_pair не влезает в отведённые ему 84 байт")
  .text.hwd_phy__rgf_883000_8cf74c 0x008cf74c : { KEEP(*(.text.hwd_phy__rgf_883000_8cf74c)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_8cf74c) <= 104, "блок hwd_phy__rgf_883000_8cf74c не влезает в отведённые ему 104 байт")
  .text.hwd_phy__read_sar_sample 0x008cf7b4 : { KEEP(*(.text.hwd_phy__read_sar_sample)) }
  ASSERT(SIZEOF(.text.hwd_phy__read_sar_sample) <= 72, "блок hwd_phy__read_sar_sample не влезает в отведённые ему 72 байт")
  .text.ut_hw_drivers_cmd_0x429 0x008cf7fc : { KEEP(*(.text.ut_hw_drivers_cmd_0x429)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x429) <= 64, "блок ut_hw_drivers_cmd_0x429 не влезает в отведённые ему 64 байт")
  .text.phy__program_channel_regs 0x008cf83c : { KEEP(*(.text.phy__program_channel_regs)) }
  ASSERT(SIZEOF(.text.phy__program_channel_regs) <= 108, "блок phy__program_channel_regs не влезает в отведённые ему 108 байт")
  .text.hwd_phy__rgf_883200 0x008cf8a8 : { KEEP(*(.text.hwd_phy__rgf_883200)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883200) <= 24, "блок hwd_phy__rgf_883200 не влезает в отведённые ему 24 байт")
  .text.get_g_8004f4 0x008cf8c0 : { KEEP(*(.text.get_g_8004f4)) }
  ASSERT(SIZEOF(.text.get_g_8004f4) <= 12, "блок get_g_8004f4 не влезает в отведённые ему 12 байт")
  .text.hwd_phy__get_883800 0x008cf8cc : { KEEP(*(.text.hwd_phy__get_883800)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883800) <= 12, "блок hwd_phy__get_883800 не влезает в отведённые ему 12 байт")
  .text.get_reg883830_s14_w32 0x008cf8d8 : { KEEP(*(.text.get_reg883830_s14_w32)) }
  ASSERT(SIZEOF(.text.get_reg883830_s14_w32) <= 16, "блок get_reg883830_s14_w32 не влезает в отведённые ему 16 байт")
  .text.hwd_phy__snapshot_status 0x008cf8e8 : { KEEP(*(.text.hwd_phy__snapshot_status)) }
  ASSERT(SIZEOF(.text.hwd_phy__snapshot_status) <= 112, "блок hwd_phy__snapshot_status не влезает в отведённые ему 112 байт")
  .text.set_reg_883150 0x008cf958 : { KEEP(*(.text.set_reg_883150)) }
  ASSERT(SIZEOF(.text.set_reg_883150) <= 12, "блок set_reg_883150 не влезает в отведённые ему 12 байт")
  .text.ut_hw_drivers_cmd_0x433 0x008cf964 : { KEEP(*(.text.ut_hw_drivers_cmd_0x433)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x433) <= 12, "блок ut_hw_drivers_cmd_0x433 не влезает в отведённые ему 12 байт")
  .text.hwd_phy__get_883700_8cf970 0x008cf970 : { KEEP(*(.text.hwd_phy__get_883700_8cf970)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883700_8cf970) <= 12, "блок hwd_phy__get_883700_8cf970 не влезает в отведённые ему 12 байт")
  .text.hwd_phy__get_883700_8cf97c 0x008cf97c : { KEEP(*(.text.hwd_phy__get_883700_8cf97c)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883700_8cf97c) <= 12, "блок hwd_phy__get_883700_8cf97c не влезает в отведённые ему 12 байт")
  .text.link_lost_diag__dump_phy 0x008cf988 : { KEEP(*(.text.link_lost_diag__dump_phy)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_phy) <= 104, "блок link_lost_diag__dump_phy не влезает в отведённые ему 104 байт")
  .text.hwd_phy__get_883180 0x008cf9f0 : { KEEP(*(.text.hwd_phy__get_883180)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883180) <= 20, "блок hwd_phy__get_883180 не влезает в отведённые ему 20 байт")
  .text.ut_hw_drivers_cmd_0x416 0x008cfa04 : { KEEP(*(.text.ut_hw_drivers_cmd_0x416)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x416) <= 60, "блок ut_hw_drivers_cmd_0x416 не влезает в отведённые ему 60 байт")
  .text.ut_hw_drivers_cmd_0x417 0x008cfa40 : { KEEP(*(.text.ut_hw_drivers_cmd_0x417)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x417) <= 52, "блок ut_hw_drivers_cmd_0x417 не влезает в отведённые ему 52 байт")
  .text.ut_hw_drivers_cmd_0x41a 0x008cfa74 : { KEEP(*(.text.ut_hw_drivers_cmd_0x41a)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x41a) <= 48, "блок ut_hw_drivers_cmd_0x41a не влезает в отведённые ему 48 байт")
  .text.ut_hw_drivers_cmd_0x419 0x008cfaa4 : { KEEP(*(.text.ut_hw_drivers_cmd_0x419)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x419) <= 52, "блок ut_hw_drivers_cmd_0x419 не влезает в отведённые ему 52 байт")
  .text.ut_hw_drivers_cmd_0x418 0x008cfad8 : { KEEP(*(.text.ut_hw_drivers_cmd_0x418)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x418) <= 104, "блок ut_hw_drivers_cmd_0x418 не влезает в отведённые ему 104 байт")
  .text.link_stats__phy_counters 0x008cfb40 : { KEEP(*(.text.link_stats__phy_counters)) }
  ASSERT(SIZEOF(.text.link_stats__phy_counters) <= 84, "блок link_stats__phy_counters не влезает в отведённые ему 84 байт")
  .text.hwd_phy__rgf_885000_8cfb94 0x008cfb94 : { KEEP(*(.text.hwd_phy__rgf_885000_8cfb94)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_885000_8cfb94) <= 52, "блок hwd_phy__rgf_885000_8cfb94 не влезает в отведённые ему 52 байт")
  .text.phy__wait_sar_done 0x008cfbc8 : { KEEP(*(.text.phy__wait_sar_done)) }
  ASSERT(SIZEOF(.text.phy__wait_sar_done) <= 68, "блок phy__wait_sar_done не влезает в отведённые ему 68 байт")
  .text.hwd_phy__rgf_885000_8cfc0c 0x008cfc0c : { KEEP(*(.text.hwd_phy__rgf_885000_8cfc0c)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_885000_8cfc0c) <= 16, "блок hwd_phy__rgf_885000_8cfc0c не влезает в отведённые ему 16 байт")
  .text.hwd_phy__get_883100 0x008cfc1c : { KEEP(*(.text.hwd_phy__get_883100)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883100) <= 84, "блок hwd_phy__get_883100 не влезает в отведённые ему 84 байт")
  .text.hwd_phy__set_883000 0x008cfc70 : { KEEP(*(.text.hwd_phy__set_883000)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_883000) <= 16, "блок hwd_phy__set_883000 не влезает в отведённые ему 16 байт")
  .text.hwd_phy__set_883900 0x008cfc80 : { KEEP(*(.text.hwd_phy__set_883900)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_883900) <= 28, "блок hwd_phy__set_883900 не влезает в отведённые ему 28 байт")
  .text.set_reg_88395c 0x008cfc9c : { KEEP(*(.text.set_reg_88395c)) }
  ASSERT(SIZEOF(.text.set_reg_88395c) <= 12, "блок set_reg_88395c не влезает в отведённые ему 12 байт")
  .text.ut_hw_drivers_cmd_0x404 0x008cfca8 : { KEEP(*(.text.ut_hw_drivers_cmd_0x404)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x404) <= 52, "блок ut_hw_drivers_cmd_0x404 не влезает в отведённые ему 52 байт")
  .text.hwd_phy__rgf_883000_8cfcdc 0x008cfcdc : { KEEP(*(.text.hwd_phy__rgf_883000_8cfcdc)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_8cfcdc) <= 108, "блок hwd_phy__rgf_883000_8cfcdc не влезает в отведённые ему 108 байт")
  .text.hwd_phy__rgf_883000_8cfd48 0x008cfd48 : { KEEP(*(.text.hwd_phy__rgf_883000_8cfd48)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_8cfd48) <= 64, "блок hwd_phy__rgf_883000_8cfd48 не влезает в отведённые ему 64 байт")
  .text.hwd_phy__rgf_883000_8cfd88 0x008cfd88 : { KEEP(*(.text.hwd_phy__rgf_883000_8cfd88)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_8cfd88) <= 56, "блок hwd_phy__rgf_883000_8cfd88 не влезает в отведённые ему 56 байт")
  .text.hwd_phy__mode_flags_by_index 0x008cfdc0 : { KEEP(*(.text.hwd_phy__mode_flags_by_index)) }
  ASSERT(SIZEOF(.text.hwd_phy__mode_flags_by_index) <= 156, "блок hwd_phy__mode_flags_by_index не влезает в отведённые ему 156 байт")
  .text.ut_hw_drivers_cmd_0x431 0x008cfe5c : { KEEP(*(.text.ut_hw_drivers_cmd_0x431)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x431) <= 124, "блок ut_hw_drivers_cmd_0x431 не влезает в отведённые ему 124 байт")
  .text.hwd_phy__get_883b80 0x008cfed8 : { KEEP(*(.text.hwd_phy__get_883b80)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883b80) <= 28, "блок hwd_phy__get_883b80 не влезает в отведённые ему 28 байт")
  .text.hwd_PHY_STORE_TXRX_SWAP_IQ 0x008cfef4 : { KEEP(*(.text.hwd_PHY_STORE_TXRX_SWAP_IQ)) }
  ASSERT(SIZEOF(.text.hwd_PHY_STORE_TXRX_SWAP_IQ) <= 60, "блок hwd_PHY_STORE_TXRX_SWAP_IQ не влезает в отведённые ему 60 байт")
  .text.ut_hw_drivers_cmd_0x40b 0x008cff30 : { KEEP(*(.text.ut_hw_drivers_cmd_0x40b)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x40b) <= 268, "блок ut_hw_drivers_cmd_0x40b не влезает в отведённые ему 268 байт")
  .text.ut_hw_drivers_cmd_0x40c 0x008d003c : { KEEP(*(.text.ut_hw_drivers_cmd_0x40c)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x40c) <= 48, "блок ut_hw_drivers_cmd_0x40c не влезает в отведённые ему 48 байт")
  .text.hwd_phy__rgf_884100 0x008d006c : { KEEP(*(.text.hwd_phy__rgf_884100)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_884100) <= 108, "блок hwd_phy__rgf_884100 не влезает в отведённые ему 108 байт")
  .text.hwd_phy__get_884100 0x008d00d8 : { KEEP(*(.text.hwd_phy__get_884100)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_884100) <= 24, "блок hwd_phy__get_884100 не влезает в отведённые ему 24 байт")
  .text.ut_hw_drivers_cmd_0x40f 0x008d00f0 : { KEEP(*(.text.ut_hw_drivers_cmd_0x40f)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x40f) <= 120, "блок ut_hw_drivers_cmd_0x40f не влезает в отведённые ему 120 байт")
  .text.ut_hw_drivers_cmd_0x40d 0x008d0168 : { KEEP(*(.text.ut_hw_drivers_cmd_0x40d)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x40d) <= 128, "блок ut_hw_drivers_cmd_0x40d не влезает в отведённые ему 128 байт")
  .text.hwd_phy__write_884000 0x008d01e8 : { KEEP(*(.text.hwd_phy__write_884000)) }
  ASSERT(SIZEOF(.text.hwd_phy__write_884000) <= 196, "блок hwd_phy__write_884000 не влезает в отведённые ему 196 байт")
  .text.hwd_phy__wait_ready_884054 0x008d02ac : { KEEP(*(.text.hwd_phy__wait_ready_884054)) }
  ASSERT(SIZEOF(.text.hwd_phy__wait_ready_884054) <= 108, "блок hwd_phy__wait_ready_884054 не влезает в отведённые ему 108 байт")
  .text.rgf_reg_884000 0x008d0318 : { KEEP(*(.text.rgf_reg_884000)) }
  ASSERT(SIZEOF(.text.rgf_reg_884000) <= 100, "блок rgf_reg_884000 не влезает в отведённые ему 100 байт")
  .text.set_reg_884070 0x008d037c : { KEEP(*(.text.set_reg_884070)) }
  ASSERT(SIZEOF(.text.set_reg_884070) <= 12, "блок set_reg_884070 не влезает в отведённые ему 12 байт")
  .text.set_reg_884064 0x008d0388 : { KEEP(*(.text.set_reg_884064)) }
  ASSERT(SIZEOF(.text.set_reg_884064) <= 12, "блок set_reg_884064 не влезает в отведённые ему 12 байт")
  .text.hwd_rfc__program_clocks 0x008d0394 : { KEEP(*(.text.hwd_rfc__program_clocks)) }
  ASSERT(SIZEOF(.text.hwd_rfc__program_clocks) <= 152, "блок hwd_rfc__program_clocks не влезает в отведённые ему 152 байт")
  .text.rfc__write_core_reg6 0x008d042c : { KEEP(*(.text.rfc__write_core_reg6)) }
  ASSERT(SIZEOF(.text.rfc__write_core_reg6) <= 12, "блок rfc__write_core_reg6 не влезает в отведённые ему 12 байт")
  .text.hwd_rfc__write_xpm_cmd 0x008d0438 : { KEEP(*(.text.hwd_rfc__write_xpm_cmd)) }
  ASSERT(SIZEOF(.text.hwd_rfc__write_xpm_cmd) <= 12, "блок hwd_rfc__write_xpm_cmd не влезает в отведённые ему 12 байт")
  .text.rfc__read_field_484 0x008d0444 : { KEEP(*(.text.rfc__read_field_484)) }
  ASSERT(SIZEOF(.text.rfc__read_field_484) <= 52, "блок rfc__read_field_484 не влезает в отведённые ему 52 байт")
  .text.calib_lo__write_vt_codes 0x008d0478 : { KEEP(*(.text.calib_lo__write_vt_codes)) }
  ASSERT(SIZEOF(.text.calib_lo__write_vt_codes) <= 56, "блок calib_lo__write_vt_codes не влезает в отведённые ему 56 байт")
  .text.tail_hwd_rfc_write_core 0x008d04b0 : { KEEP(*(.text.tail_hwd_rfc_write_core)) }
  ASSERT(SIZEOF(.text.tail_hwd_rfc_write_core) <= 12, "блок tail_hwd_rfc_write_core не влезает в отведённые ему 12 байт")
  .text.hwd_rfc__rgf_889100 0x008d04bc : { KEEP(*(.text.hwd_rfc__rgf_889100)) }
  ASSERT(SIZEOF(.text.hwd_rfc__rgf_889100) <= 64, "блок hwd_rfc__rgf_889100 не влезает в отведённые ему 64 байт")
  .text.hwd_rfc_read_rgf 0x008d04fc : { KEEP(*(.text.hwd_rfc_read_rgf)) }
  ASSERT(SIZEOF(.text.hwd_rfc_read_rgf) <= 132, "блок hwd_rfc_read_rgf не влезает в отведённые ему 132 байт")
  .text.rfc_read_sector_params 0x008d0580 : { KEEP(*(.text.rfc_read_sector_params)) }
  ASSERT(SIZEOF(.text.rfc_read_sector_params) <= 304, "блок rfc_read_sector_params не влезает в отведённые ему 304 байт")
  .text.hwd_rfc__read_xpm_with_delay 0x008d06b0 : { KEEP(*(.text.hwd_rfc__read_xpm_with_delay)) }
  ASSERT(SIZEOF(.text.hwd_rfc__read_xpm_with_delay) <= 84, "блок hwd_rfc__read_xpm_with_delay не влезает в отведённые ему 84 байт")
  .text.ut_hw_drivers_cmd_0x50b 0x008d0704 : { KEEP(*(.text.ut_hw_drivers_cmd_0x50b)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x50b) <= 56, "блок ut_hw_drivers_cmd_0x50b не влезает в отведённые ему 56 байт")
  .text.rf_sector_commit_rx 0x008d073c : { KEEP(*(.text.rf_sector_commit_rx)) }
  ASSERT(SIZEOF(.text.rf_sector_commit_rx) <= 52, "блок rf_sector_commit_rx не влезает в отведённые ему 52 байт")
  .text.ut_hw_drivers_cmd_0x507 0x008d0770 : { KEEP(*(.text.ut_hw_drivers_cmd_0x507)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x507) <= 88, "блок ut_hw_drivers_cmd_0x507 не влезает в отведённые ему 88 байт")
  .text.hwd_rfc__read_sector_reg 0x008d07c8 : { KEEP(*(.text.hwd_rfc__read_sector_reg)) }
  ASSERT(SIZEOF(.text.hwd_rfc__read_sector_reg) <= 56, "блок hwd_rfc__read_sector_reg не влезает в отведённые ему 56 байт")
  .text.hwd_rfc_sector_dist_gain_set 0x008d0800 : { KEEP(*(.text.hwd_rfc_sector_dist_gain_set)) }
  ASSERT(SIZEOF(.text.hwd_rfc_sector_dist_gain_set) <= 188, "блок hwd_rfc_sector_dist_gain_set не влезает в отведённые ему 188 байт")
  .text.hwd_rfc__read_sector_chain 0x008d08bc : { KEEP(*(.text.hwd_rfc__read_sector_chain)) }
  ASSERT(SIZEOF(.text.hwd_rfc__read_sector_chain) <= 164, "блок hwd_rfc__read_sector_chain не влезает в отведённые ему 164 байт")
  .text.hwd_rfc_sector_edge_gain_set 0x008d0960 : { KEEP(*(.text.hwd_rfc_sector_edge_gain_set)) }
  ASSERT(SIZEOF(.text.hwd_rfc_sector_edge_gain_set) <= 388, "блок hwd_rfc_sector_edge_gain_set не влезает в отведённые ему 388 байт")
  .text.ut_hw_drivers_cmd_0x50f 0x008d0ae4 : { KEEP(*(.text.ut_hw_drivers_cmd_0x50f)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x50f) <= 116, "блок ut_hw_drivers_cmd_0x50f не влезает в отведённые ему 116 байт")
  .text.hwd_rfc_sector_edge_phase_set 0x008d0b58 : { KEEP(*(.text.hwd_rfc_sector_edge_phase_set)) }
  ASSERT(SIZEOF(.text.hwd_rfc_sector_edge_phase_set) <= 356, "блок hwd_rfc_sector_edge_phase_set не влезает в отведённые ему 356 байт")
  .text.ut_hw_drivers_cmd_0x513 0x008d0cbc : { KEEP(*(.text.ut_hw_drivers_cmd_0x513)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x513) <= 60, "блок ut_hw_drivers_cmd_0x513 не влезает в отведённые ему 60 байт")
  .text.hwd_rfc_sector_x16_state_set 0x008d0cf8 : { KEEP(*(.text.hwd_rfc_sector_x16_state_set)) }
  ASSERT(SIZEOF(.text.hwd_rfc_sector_x16_state_set) <= 164, "блок hwd_rfc_sector_x16_state_set не влезает в отведённые ему 164 байт")
  .text.rfc__write_chain_field 0x008d0d9c : { KEEP(*(.text.rfc__write_chain_field)) }
  ASSERT(SIZEOF(.text.rfc__write_chain_field) <= 40, "блок rfc__write_chain_field не влезает в отведённые ему 40 байт")
  .text.rfc__write_packed_fields 0x008d0dc4 : { KEEP(*(.text.rfc__write_packed_fields)) }
  ASSERT(SIZEOF(.text.rfc__write_packed_fields) <= 116, "блок rfc__write_packed_fields не влезает в отведённые ему 116 байт")
  .text.set_g_800216 0x008d0e38 : { KEEP(*(.text.set_g_800216)) }
  ASSERT(SIZEOF(.text.set_g_800216) <= 8, "блок set_g_800216 не влезает в отведённые ему 8 байт")
  .text.rfc__write_field_484 0x008d0e40 : { KEEP(*(.text.rfc__write_field_484)) }
  ASSERT(SIZEOF(.text.rfc__write_field_484) <= 52, "блок rfc__write_field_484 не влезает в отведённые ему 52 байт")
  .text.rfc__write_field_1136 0x008d0e74 : { KEEP(*(.text.rfc__write_field_1136)) }
  ASSERT(SIZEOF(.text.rfc__write_field_1136) <= 12, "блок rfc__write_field_1136 не влезает в отведённые ему 12 байт")
  .text.hwd_rfc_tx_power_cfg 0x008d0e80 : { KEEP(*(.text.hwd_rfc_tx_power_cfg)) }
  ASSERT(SIZEOF(.text.hwd_rfc_tx_power_cfg) <= 116, "блок hwd_rfc_tx_power_cfg не влезает в отведённые ему 116 байт")
  .text.rf_sector_commit_tx 0x008d0ef4 : { KEEP(*(.text.rf_sector_commit_tx)) }
  ASSERT(SIZEOF(.text.rf_sector_commit_tx) <= 52, "блок rf_sector_commit_tx не влезает в отведённые ему 52 байт")
  .text.ut_hw_drivers_cmd_0x508 0x008d0f28 : { KEEP(*(.text.ut_hw_drivers_cmd_0x508)) }
  ASSERT(SIZEOF(.text.ut_hw_drivers_cmd_0x508) <= 88, "блок ut_hw_drivers_cmd_0x508 не влезает в отведённые ему 88 байт")
  .text.hwd_rfc_write_core 0x008d0f80 : { KEEP(*(.text.hwd_rfc_write_core)) }
  ASSERT(SIZEOF(.text.hwd_rfc_write_core) <= 444, "блок hwd_rfc_write_core не влезает в отведённые ему 444 байт")
  .text.rfc_field_write 0x008d113c : { KEEP(*(.text.rfc_field_write)) }
  ASSERT(SIZEOF(.text.rfc_field_write) <= 56, "блок rfc_field_write не влезает в отведённые ему 56 байт")
  .text.rf_sector_params_write 0x008d1174 : { KEEP(*(.text.rf_sector_params_write)) }
  ASSERT(SIZEOF(.text.rf_sector_params_write) <= 332, "блок rf_sector_params_write не влезает в отведённые ему 332 байт")
  .text.marlon_r_if__log_data0 0x008d12c0 : { KEEP(*(.text.marlon_r_if__log_data0)) }
  ASSERT(SIZEOF(.text.marlon_r_if__log_data0) <= 64, "блок marlon_r_if__log_data0 не влезает в отведённые ему 64 байт")
  .text.hwd_rfc_xpm_get_data_output 0x008d1300 : { KEEP(*(.text.hwd_rfc_xpm_get_data_output)) }
  ASSERT(SIZEOF(.text.hwd_rfc_xpm_get_data_output) <= 132, "блок hwd_rfc_xpm_get_data_output не влезает в отведённые ему 132 байт")
  .text.xpm__read_data_byte 0x008d1384 : { KEEP(*(.text.xpm__read_data_byte)) }
  ASSERT(SIZEOF(.text.xpm__read_data_byte) <= 32, "блок xpm__read_data_byte не влезает в отведённые ему 32 байт")
  .text.xpm__write_addr 0x008d13a4 : { KEEP(*(.text.xpm__write_addr)) }
  ASSERT(SIZEOF(.text.xpm__write_addr) <= 12, "блок xpm__write_addr не влезает в отведённые ему 12 байт")
  .text.sdp__drive_pin 0x008d13b0 : { KEEP(*(.text.sdp__drive_pin)) }
  ASSERT(SIZEOF(.text.sdp__drive_pin) <= 44, "блок sdp__drive_pin не влезает в отведённые ему 44 байт")
  .text.gpio__dump 0x008d13dc : { KEEP(*(.text.gpio__dump)) }
  ASSERT(SIZEOF(.text.gpio__dump) <= 84, "блок gpio__dump не влезает в отведённые ему 84 байт")
  .text.sdp__init_int_ctrl 0x008d1430 : { KEEP(*(.text.sdp__init_int_ctrl)) }
  ASSERT(SIZEOF(.text.sdp__init_int_ctrl) <= 24, "блок sdp__init_int_ctrl не влезает в отведённые ему 24 байт")
  .text.rgf_reg_880b80 0x008d1448 : { KEEP(*(.text.rgf_reg_880b80)) }
  ASSERT(SIZEOF(.text.rgf_reg_880b80) <= 48, "блок rgf_reg_880b80 не влезает в отведённые ему 48 байт")
  .text.SDP__hwd_sdp_is_defined_mode 0x008d1478 : { KEEP(*(.text.SDP__hwd_sdp_is_defined_mode)) }
  ASSERT(SIZEOF(.text.SDP__hwd_sdp_is_defined_mode) <= 48, "блок SDP__hwd_sdp_is_defined_mode не влезает в отведённые ему 48 байт")
  .text.SDP__hwd_sdp_is_defined_sdp 0x008d14a8 : { KEEP(*(.text.SDP__hwd_sdp_is_defined_sdp)) }
  ASSERT(SIZEOF(.text.SDP__hwd_sdp_is_defined_sdp) <= 48, "блок SDP__hwd_sdp_is_defined_sdp не влезает в отведённые ему 48 байт")
  .text.SDP__hwd_sdp_is_gpio_sdp 0x008d14d8 : { KEEP(*(.text.SDP__hwd_sdp_is_gpio_sdp)) }
  ASSERT(SIZEOF(.text.SDP__hwd_sdp_is_gpio_sdp) <= 56, "блок SDP__hwd_sdp_is_gpio_sdp не влезает в отведённые ему 56 байт")
  .text.SDP__hwd_sdp_is_int_ctrl_sdp 0x008d1510 : { KEEP(*(.text.SDP__hwd_sdp_is_int_ctrl_sdp)) }
  ASSERT(SIZEOF(.text.SDP__hwd_sdp_is_int_ctrl_sdp) <= 60, "блок SDP__hwd_sdp_is_int_ctrl_sdp не влезает в отведённые ему 60 байт")
  .text.rgf_reg_880b00 0x008d154c : { KEEP(*(.text.rgf_reg_880b00)) }
  ASSERT(SIZEOF(.text.rgf_reg_880b00) <= 44, "блок rgf_reg_880b00 не влезает в отведённые ему 44 байт")
  .text.hw_personality__read_strap 0x008d1578 : { KEEP(*(.text.hw_personality__read_strap)) }
  ASSERT(SIZEOF(.text.hw_personality__read_strap) <= 32, "блок hw_personality__read_strap не влезает в отведённые ему 32 байт")
  .text.gpio__reset_mux 0x008d1598 : { KEEP(*(.text.gpio__reset_mux)) }
  ASSERT(SIZEOF(.text.gpio__reset_mux) <= 52, "блок gpio__reset_mux не влезает в отведённые ему 52 байт")
  .text.rgf_reg_889480 0x008d15cc : { KEEP(*(.text.rgf_reg_889480)) }
  ASSERT(SIZEOF(.text.rgf_reg_889480) <= 44, "блок rgf_reg_889480 не влезает в отведённые ему 44 байт")
  .text.rgf_reg_88416c 0x008d15f8 : { KEEP(*(.text.rgf_reg_88416c)) }
  ASSERT(SIZEOF(.text.rgf_reg_88416c) <= 76, "блок rgf_reg_88416c не влезает в отведённые ему 76 байт")
  .text.hwd_dma__read_ring_state 0x008d1644 : { KEEP(*(.text.hwd_dma__read_ring_state)) }
  ASSERT(SIZEOF(.text.hwd_dma__read_ring_state) <= 72, "блок hwd_dma__read_ring_state не влезает в отведённые ему 72 байт")
  .text.rgf_reg_880280_8d168c 0x008d168c : { KEEP(*(.text.rgf_reg_880280_8d168c)) }
  ASSERT(SIZEOF(.text.rgf_reg_880280_8d168c) <= 28, "блок rgf_reg_880280_8d168c не влезает в отведённые ему 28 байт")
  .text.set_reg_880b00_8d16a8 0x008d16a8 : { KEEP(*(.text.set_reg_880b00_8d16a8)) }
  ASSERT(SIZEOF(.text.set_reg_880b00_8d16a8) <= 16, "блок set_reg_880b00_8d16a8 не влезает в отведённые ему 16 байт")
  .text.sdp__program_880b00 0x008d16b8 : { KEEP(*(.text.sdp__program_880b00)) }
  ASSERT(SIZEOF(.text.sdp__program_880b00) <= 20, "блок sdp__program_880b00 не влезает в отведённые ему 20 байт")
  .text.set_reg_880b00_8d16cc 0x008d16cc : { KEEP(*(.text.set_reg_880b00_8d16cc)) }
  ASSERT(SIZEOF(.text.set_reg_880b00_8d16cc) <= 16, "блок set_reg_880b00_8d16cc не влезает в отведённые ему 16 байт")
  .text.get_reg_880b00_8d16dc 0x008d16dc : { KEEP(*(.text.get_reg_880b00_8d16dc)) }
  ASSERT(SIZEOF(.text.get_reg_880b00_8d16dc) <= 20, "блок get_reg_880b00_8d16dc не влезает в отведённые ему 20 байт")
  .text.vring_is_empty 0x008d16f0 : { KEEP(*(.text.vring_is_empty)) }
  ASSERT(SIZEOF(.text.vring_is_empty) <= 68, "блок vring_is_empty не влезает в отведённые ему 68 байт")
  .text.calib_sar_step2 0x008d1734 : { KEEP(*(.text.calib_sar_step2)) }
  ASSERT(SIZEOF(.text.calib_sar_step2) <= 352, "блок calib_sar_step2 не влезает в отведённые ему 352 байт")
  .text.stub_ret_8d1894 0x008d1894 : { KEEP(*(.text.stub_ret_8d1894)) }
  ASSERT(SIZEOF(.text.stub_ret_8d1894) <= 4, "блок stub_ret_8d1894 не влезает в отведённые ему 4 байт")
  .text.hwf__rladder_calibrate 0x008d1898 : { KEEP(*(.text.hwf__rladder_calibrate)) }
  ASSERT(SIZEOF(.text.hwf__rladder_calibrate) <= 52, "блок hwf__rladder_calibrate не влезает в отведённые ему 52 байт")
  .text.phy_ber__enable_dig_loopback 0x008d18cc : { KEEP(*(.text.phy_ber__enable_dig_loopback)) }
  ASSERT(SIZEOF(.text.phy_ber__enable_dig_loopback) <= 64, "блок phy_ber__enable_dig_loopback не влезает в отведённые ему 64 байт")
  .text.hwf__rf_lo_setup 0x008d190c : { KEEP(*(.text.hwf__rf_lo_setup)) }
  ASSERT(SIZEOF(.text.hwf__rf_lo_setup) <= 88, "блок hwf__rf_lo_setup не влезает в отведённые ему 88 байт")
  .text.phy__report_gain_to_ucode 0x008d1964 : { KEEP(*(.text.phy__report_gain_to_ucode)) }
  ASSERT(SIZEOF(.text.phy__report_gain_to_ucode) <= 76, "блок phy__report_gain_to_ucode не влезает в отведённые ему 76 байт")
  .text.hwf_calib_all 0x008d19b0 : { KEEP(*(.text.hwf_calib_all)) }
  ASSERT(SIZEOF(.text.hwf_calib_all) <= 424, "блок hwf_calib_all не влезает в отведённые ему 424 байт")
  .text.hwf_calib_bb_gain_alg 0x008d1b58 : { KEEP(*(.text.hwf_calib_bb_gain_alg)) }
  ASSERT(SIZEOF(.text.hwf_calib_bb_gain_alg) <= 196, "блок hwf_calib_bb_gain_alg не влезает в отведённые ему 196 байт")
  .text.hwf_calib_bb_gain_create_table 0x008d1c1c : { KEEP(*(.text.hwf_calib_bb_gain_create_table)) }
  ASSERT(SIZEOF(.text.hwf_calib_bb_gain_create_table) <= 672, "блок hwf_calib_bb_gain_create_table не влезает в отведённые ему 672 байт")
  .text.hwf_calib__prepare_hw 0x008d1ebc : { KEEP(*(.text.hwf_calib__prepare_hw)) }
  ASSERT(SIZEOF(.text.hwf_calib__prepare_hw) <= 108, "блок hwf_calib__prepare_hw не влезает в отведённые ему 108 байт")
  .text.tail_hwf_calib__release_hw 0x008d1f28 : { KEEP(*(.text.tail_hwf_calib__release_hw)) }
  ASSERT(SIZEOF(.text.tail_hwf_calib__release_hw) <= 4, "блок tail_hwf_calib__release_hw не влезает в отведённые ему 4 байт")
  .text.is_one_of_3 0x008d1f2c : { KEEP(*(.text.is_one_of_3)) }
  ASSERT(SIZEOF(.text.is_one_of_3) <= 28, "блок is_one_of_3 не влезает в отведённые ему 28 байт")
  .text.calib_bb_gain__choose_row 0x008d1f48 : { KEEP(*(.text.calib_bb_gain__choose_row)) }
  ASSERT(SIZEOF(.text.calib_bb_gain__choose_row) <= 112, "блок calib_bb_gain__choose_row не влезает в отведённые ему 112 байт")
  .text.calib_row_step 0x008d1fb8 : { KEEP(*(.text.calib_row_step)) }
  ASSERT(SIZEOF(.text.calib_row_step) <= 172, "блок calib_row_step не влезает в отведённые ему 172 байт")
  .text.hwf_calib_bb_gain_rows 0x008d2064 : { KEEP(*(.text.hwf_calib_bb_gain_rows)) }
  ASSERT(SIZEOF(.text.hwf_calib_bb_gain_rows) <= 1056, "блок hwf_calib_bb_gain_rows не влезает в отведённые ему 1056 байт")
  .text.calib_bb_gain__pick_closest 0x008d2484 : { KEEP(*(.text.calib_bb_gain__pick_closest)) }
  ASSERT(SIZEOF(.text.calib_bb_gain__pick_closest) <= 96, "блок calib_bb_gain__pick_closest не влезает в отведённые ему 96 байт")
  .text.calib_lo_power_substep 0x008d24e4 : { KEEP(*(.text.calib_lo_power_substep)) }
  ASSERT(SIZEOF(.text.calib_lo_power_substep) <= 172, "блок calib_lo_power_substep не влезает в отведённые ему 172 байт")
  .text.calib_vga_coarse 0x008d2590 : { KEEP(*(.text.calib_vga_coarse)) }
  ASSERT(SIZEOF(.text.calib_vga_coarse) <= 436, "блок calib_vga_coarse не влезает в отведённые ему 436 байт")
  .text.frag_8d2744 0x008d2744 : { KEEP(*(.text.frag_8d2744)) }
  ASSERT(SIZEOF(.text.frag_8d2744) <= 60, "блок frag_8d2744 не влезает в отведённые ему 60 байт")
  .text.if_gain__compute_correction 0x008d2780 : { KEEP(*(.text.if_gain__compute_correction)) }
  ASSERT(SIZEOF(.text.if_gain__compute_correction) <= 104, "блок if_gain__compute_correction не влезает в отведённые ему 104 байт")
  .text.if_gain__apply_delta 0x008d27e8 : { KEEP(*(.text.if_gain__apply_delta)) }
  ASSERT(SIZEOF(.text.if_gain__apply_delta) <= 64, "блок if_gain__apply_delta не влезает в отведённые ему 64 байт")
  .text.IF_GAIN__GAIN 0x008d2828 : { KEEP(*(.text.IF_GAIN__GAIN)) }
  ASSERT(SIZEOF(.text.IF_GAIN__GAIN) <= 1360, "блок IF_GAIN__GAIN не влезает в отведённые ему 1360 байт")
  .text.hwf_if_gain_fin_est 0x008d2d78 : { KEEP(*(.text.hwf_if_gain_fin_est)) }
  ASSERT(SIZEOF(.text.hwf_if_gain_fin_est) <= 448, "блок hwf_if_gain_fin_est не влезает в отведённые ему 448 байт")
  .text.calib_lo_power_step 0x008d2f38 : { KEEP(*(.text.calib_lo_power_step)) }
  ASSERT(SIZEOF(.text.calib_lo_power_step) <= 332, "блок calib_lo_power_step не влезает в отведённые ему 332 байт")
  .text.hwf_calib__restore_path 0x008d3084 : { KEEP(*(.text.hwf_calib__restore_path)) }
  ASSERT(SIZEOF(.text.hwf_calib__restore_path) <= 28, "блок hwf_calib__restore_path не влезает в отведённые ему 28 байт")
  .text.hwf_if_gain__apply_agc_table 0x008d30a0 : { KEEP(*(.text.hwf_if_gain__apply_agc_table)) }
  ASSERT(SIZEOF(.text.hwf_if_gain__apply_agc_table) <= 112, "блок hwf_if_gain__apply_agc_table не влезает в отведённые ему 112 байт")
  .text.rfc__select_chain_and_write 0x008d3110 : { KEEP(*(.text.rfc__select_chain_and_write)) }
  ASSERT(SIZEOF(.text.rfc__select_chain_and_write) <= 44, "блок rfc__select_chain_and_write не влезает в отведённые ему 44 байт")
  .text.if_gain__load_gain_table 0x008d313c : { KEEP(*(.text.if_gain__load_gain_table)) }
  ASSERT(SIZEOF(.text.if_gain__load_gain_table) <= 112, "блок if_gain__load_gain_table не влезает в отведённые ему 112 байт")
  .text.hwf_calib_sar_alg 0x008d31ac : { KEEP(*(.text.hwf_calib_sar_alg)) }
  ASSERT(SIZEOF(.text.hwf_calib_sar_alg) <= 124, "блок hwf_calib_sar_alg не влезает в отведённые ему 124 байт")
  .text.power_mngr_on_unassoc_start 0x008d3228 : { KEEP(*(.text.power_mngr_on_unassoc_start)) }
  ASSERT(SIZEOF(.text.power_mngr_on_unassoc_start) <= 84, "блок power_mngr_on_unassoc_start не влезает в отведённые ему 84 байт")
  .text.calib_sar_step 0x008d327c : { KEEP(*(.text.calib_sar_step)) }
  ASSERT(SIZEOF(.text.calib_sar_step) <= 636, "блок calib_sar_step не влезает в отведённые ему 636 байт")
  .text.ut_hw_flows_cmd_0x408 0x008d34f8 : { KEEP(*(.text.ut_hw_flows_cmd_0x408)) }
  ASSERT(SIZEOF(.text.ut_hw_flows_cmd_0x408) <= 164, "блок ut_hw_flows_cmd_0x408 не влезает в отведённые ему 164 байт")
  .text.ut_hw_flows_cmd_0x407 0x008d359c : { KEEP(*(.text.ut_hw_flows_cmd_0x407)) }
  ASSERT(SIZEOF(.text.ut_hw_flows_cmd_0x407) <= 40, "блок ut_hw_flows_cmd_0x407 не влезает в отведённые ему 40 байт")
  .text.ut_hw_flows_cmd_0x404 0x008d35c4 : { KEEP(*(.text.ut_hw_flows_cmd_0x404)) }
  ASSERT(SIZEOF(.text.ut_hw_flows_cmd_0x404) <= 80, "блок ut_hw_flows_cmd_0x404 не влезает в отведённые ему 80 байт")
  .text.calib_mngr_step_a 0x008d3614 : { KEEP(*(.text.calib_mngr_step_a)) }
  ASSERT(SIZEOF(.text.calib_mngr_step_a) <= 160, "блок calib_mngr_step_a не влезает в отведённые ему 160 байт")
  .text.calib_sar__enable_path 0x008d36b4 : { KEEP(*(.text.calib_sar__enable_path)) }
  ASSERT(SIZEOF(.text.calib_sar__enable_path) <= 48, "блок calib_sar__enable_path не влезает в отведённые ему 48 байт")
  .text.ber_test__read_lane_counters 0x008d36e4 : { KEEP(*(.text.ber_test__read_lane_counters)) }
  ASSERT(SIZEOF(.text.ber_test__read_lane_counters) <= 36, "блок ber_test__read_lane_counters не влезает в отведённые ему 36 байт")
  .text.approx_magnitude 0x008d3708 : { KEEP(*(.text.approx_magnitude)) }
  ASSERT(SIZEOF(.text.approx_magnitude) <= 48, "блок approx_magnitude не влезает в отведённые ему 48 байт")
  .text.hwf_calib__release_hw 0x008d3738 : { KEEP(*(.text.hwf_calib__release_hw)) }
  ASSERT(SIZEOF(.text.hwf_calib__release_hw) <= 312, "блок hwf_calib__release_hw не влезает в отведённые ему 312 байт")
  .text.hwf_calib__acquire_hw 0x008d3870 : { KEEP(*(.text.hwf_calib__acquire_hw)) }
  ASSERT(SIZEOF(.text.hwf_calib__acquire_hw) <= 244, "блок hwf_calib__acquire_hw не влезает в отведённые ему 244 байт")
  .text.calib_vga_gain_step 0x008d3964 : { KEEP(*(.text.calib_vga_gain_step)) }
  ASSERT(SIZEOF(.text.calib_vga_gain_step) <= 268, "блок calib_vga_gain_step не влезает в отведённые ему 268 байт")
  .text.hwf_vga_dc__calibrate 0x008d3a70 : { KEEP(*(.text.hwf_vga_dc__calibrate)) }
  ASSERT(SIZEOF(.text.hwf_vga_dc__calibrate) <= 380, "блок hwf_vga_dc__calibrate не влезает в отведённые ему 380 байт")
  .text.hwf_dc_calib_fix_dac1 0x008d3bec : { KEEP(*(.text.hwf_dc_calib_fix_dac1)) }
  ASSERT(SIZEOF(.text.hwf_dc_calib_fix_dac1) <= 288, "блок hwf_dc_calib_fix_dac1 не влезает в отведённые ему 288 байт")
  .text.hwf_calib__setup_loopback 0x008d3d0c : { KEEP(*(.text.hwf_calib__setup_loopback)) }
  ASSERT(SIZEOF(.text.hwf_calib__setup_loopback) <= 104, "блок hwf_calib__setup_loopback не влезает в отведённые ему 104 байт")
  .text.hwf_vga_dc__measure 0x008d3d74 : { KEEP(*(.text.hwf_vga_dc__measure)) }
  ASSERT(SIZEOF(.text.hwf_vga_dc__measure) <= 76, "блок hwf_vga_dc__measure не влезает в отведённые ему 76 байт")
  .text.calib__log_if_nonzero 0x008d3dc0 : { KEEP(*(.text.calib__log_if_nonzero)) }
  ASSERT(SIZEOF(.text.calib__log_if_nonzero) <= 12, "блок calib__log_if_nonzero не влезает в отведённые ему 12 байт")
  .text.calib_battery_phy_step 0x008d3dcc : { KEEP(*(.text.calib_battery_phy_step)) }
  ASSERT(SIZEOF(.text.calib_battery_phy_step) <= 336, "блок calib_battery_phy_step не влезает в отведённые ему 336 байт")
  .text.calib__delta_80161c 0x008d3f1c : { KEEP(*(.text.calib__delta_80161c)) }
  ASSERT(SIZEOF(.text.calib__delta_80161c) <= 36, "блок calib__delta_80161c не влезает в отведённые ему 36 байт")
  .text.calib_lo_power_measure 0x008d3f40 : { KEEP(*(.text.calib_lo_power_measure)) }
  ASSERT(SIZEOF(.text.calib_lo_power_measure) <= 300, "блок calib_lo_power_measure не влезает в отведённые ему 300 байт")
  .text.if_gain__scale_value 0x008d406c : { KEEP(*(.text.if_gain__scale_value)) }
  ASSERT(SIZEOF(.text.if_gain__scale_value) <= 84, "блок if_gain__scale_value не влезает в отведённые ему 84 байт")
  .text.calib_battery__check_limits 0x008d40c0 : { KEEP(*(.text.calib_battery__check_limits)) }
  ASSERT(SIZEOF(.text.calib_battery__check_limits) <= 68, "блок calib_battery__check_limits не влезает в отведённые ему 68 байт")
  .text.key__install_by_type 0x008d4104 : { KEEP(*(.text.key__install_by_type)) }
  ASSERT(SIZEOF(.text.key__install_by_type) <= 32, "блок key__install_by_type не влезает в отведённые ему 32 байт")
  .text.hwf_PHY_DIG_LOOPBACK_BER_TEST 0x008d4124 : { KEEP(*(.text.hwf_PHY_DIG_LOOPBACK_BER_TEST)) }
  ASSERT(SIZEOF(.text.hwf_PHY_DIG_LOOPBACK_BER_TEST) <= 224, "блок hwf_PHY_DIG_LOOPBACK_BER_TEST не влезает в отведённые ему 224 байт")
  .text.hwf_PHY_IF_LOOPBACK_BER_TEST 0x008d4204 : { KEEP(*(.text.hwf_PHY_IF_LOOPBACK_BER_TEST)) }
  ASSERT(SIZEOF(.text.hwf_PHY_IF_LOOPBACK_BER_TEST) <= 300, "блок hwf_PHY_IF_LOOPBACK_BER_TEST не влезает в отведённые ему 300 байт")
  .text.hwf_phy_production_loopback_test 0x008d4330 : { KEEP(*(.text.hwf_phy_production_loopback_test)) }
  ASSERT(SIZEOF(.text.hwf_phy_production_loopback_test) <= 644, "блок hwf_phy_production_loopback_test не влезает в отведённые ему 644 байт")
  .text.hwd_phy__reconfig_with_delay 0x008d45b4 : { KEEP(*(.text.hwd_phy__reconfig_with_delay)) }
  ASSERT(SIZEOF(.text.hwd_phy__reconfig_with_delay) <= 76, "блок hwd_phy__reconfig_with_delay не влезает в отведённые ему 76 байт")
  .text.link_lost_diag__rx_status 0x008d4600 : { KEEP(*(.text.link_lost_diag__rx_status)) }
  ASSERT(SIZEOF(.text.link_lost_diag__rx_status) <= 120, "блок link_lost_diag__rx_status не влезает в отведённые ему 120 байт")
  .text.phy_ber__read_counters 0x008d4678 : { KEEP(*(.text.phy_ber__read_counters)) }
  ASSERT(SIZEOF(.text.phy_ber__read_counters) <= 64, "блок phy_ber__read_counters не влезает в отведённые ему 64 байт")
  .text.tail_SDP__sdp_drive_value 0x008d46b8 : { KEEP(*(.text.tail_SDP__sdp_drive_value)) }
  ASSERT(SIZEOF(.text.tail_SDP__sdp_drive_value) <= 8, "блок tail_SDP__sdp_drive_value не влезает в отведённые ему 8 байт")
  .text.hwf_rf_reset_done 0x008d46c0 : { KEEP(*(.text.hwf_rf_reset_done)) }
  ASSERT(SIZEOF(.text.hwf_rf_reset_done) <= 52, "блок hwf_rf_reset_done не влезает в отведённые ему 52 байт")
  .text.rf__configure_chain 0x008d46f4 : { KEEP(*(.text.rf__configure_chain)) }
  ASSERT(SIZEOF(.text.rf__configure_chain) <= 76, "блок rf__configure_chain не влезает в отведённые ему 76 байт")
  .text.hwf_rf__wait_reset_done 0x008d4740 : { KEEP(*(.text.hwf_rf__wait_reset_done)) }
  ASSERT(SIZEOF(.text.hwf_rf__wait_reset_done) <= 36, "блок hwf_rf__wait_reset_done не влезает в отведённые ему 36 байт")
  .text.hwf_sector_rf_chain_get 0x008d4764 : { KEEP(*(.text.hwf_sector_rf_chain_get)) }
  ASSERT(SIZEOF(.text.hwf_sector_rf_chain_get) <= 140, "блок hwf_sector_rf_chain_get не влезает в отведённые ему 140 байт")
  .text.hwf_sector_rf_chain_set 0x008d47f0 : { KEEP(*(.text.hwf_sector_rf_chain_set)) }
  ASSERT(SIZEOF(.text.hwf_sector_rf_chain_set) <= 504, "блок hwf_sector_rf_chain_set не влезает в отведённые ему 504 байт")
  .text.hwf_sector_rf_chains_array_get 0x008d49e8 : { KEEP(*(.text.hwf_sector_rf_chains_array_get)) }
  ASSERT(SIZEOF(.text.hwf_sector_rf_chains_array_get) <= 192, "блок hwf_sector_rf_chains_array_get не влезает в отведённые ему 192 байт")
  .text.ut_hw_modes_step 0x008d4aa8 : { KEEP(*(.text.ut_hw_modes_step)) }
  ASSERT(SIZEOF(.text.ut_hw_modes_step) <= 148, "блок ut_hw_modes_step не влезает в отведённые ему 148 байт")
  .text.hwm_analog_channel_switch 0x008d4b3c : { KEEP(*(.text.hwm_analog_channel_switch)) }
  ASSERT(SIZEOF(.text.hwm_analog_channel_switch) <= 152, "блок hwm_analog_channel_switch не влезает в отведённые ему 152 байт")
  .text.hwm__set_analog_path 0x008d4bd4 : { KEEP(*(.text.hwm__set_analog_path)) }
  ASSERT(SIZEOF(.text.hwm__set_analog_path) <= 56, "блок hwm__set_analog_path не влезает в отведённые ему 56 байт")
  .text.hwm_calib__set_loopback_mode 0x008d4c0c : { KEEP(*(.text.hwm_calib__set_loopback_mode)) }
  ASSERT(SIZEOF(.text.hwm_calib__set_loopback_mode) <= 36, "блок hwm_calib__set_loopback_mode не влезает в отведённые ему 36 байт")
  .text.hw_modes__set_loopback 0x008d4c30 : { KEEP(*(.text.hw_modes__set_loopback)) }
  ASSERT(SIZEOF(.text.hw_modes__set_loopback) <= 40, "блок hw_modes__set_loopback не влезает в отведённые ему 40 байт")
  .text.hw_modes__pll_engage 0x008d4c58 : { KEEP(*(.text.hw_modes__pll_engage)) }
  ASSERT(SIZEOF(.text.hw_modes__pll_engage) <= 24, "блок hw_modes__pll_engage не влезает в отведённые ему 24 байт")
  .text.hw_modes__enable_pll 0x008d4c70 : { KEEP(*(.text.hw_modes__enable_pll)) }
  ASSERT(SIZEOF(.text.hw_modes__enable_pll) <= 28, "блок hw_modes__enable_pll не влезает в отведённые ему 28 байт")
  .text.hw_modes__pll_bypass 0x008d4c8c : { KEEP(*(.text.hw_modes__pll_bypass)) }
  ASSERT(SIZEOF(.text.hw_modes__pll_bypass) <= 24, "блок hw_modes__pll_bypass не влезает в отведённые ему 24 байт")
  .text.hwm__reset_analog_block 0x008d4ca4 : { KEEP(*(.text.hwm__reset_analog_block)) }
  ASSERT(SIZEOF(.text.hwm__reset_analog_block) <= 28, "блок hwm__reset_analog_block не влезает в отведённые ему 28 байт")
  .text.hwm_power_33kHz_clk_detector 0x008d4cc0 : { KEEP(*(.text.hwm_power_33kHz_clk_detector)) }
  ASSERT(SIZEOF(.text.hwm_power_33kHz_clk_detector) <= 96, "блок hwm_power_33kHz_clk_detector не влезает в отведённые ему 96 байт")
  .text.hwd_pcie__set_low_power 0x008d4d20 : { KEEP(*(.text.hwd_pcie__set_low_power)) }
  ASSERT(SIZEOF(.text.hwd_pcie__set_low_power) <= 60, "блок hwd_pcie__set_low_power не влезает в отведённые ему 60 байт")
  .text.hwm__apply_mode_flags 0x008d4d5c : { KEEP(*(.text.hwm__apply_mode_flags)) }
  ASSERT(SIZEOF(.text.hwm__apply_mode_flags) <= 76, "блок hwm__apply_mode_flags не влезает в отведённые ему 76 байт")
  .text.ut_hw_modes_cmd_0x308 0x008d4da8 : { KEEP(*(.text.ut_hw_modes_cmd_0x308)) }
  ASSERT(SIZEOF(.text.ut_hw_modes_cmd_0x308) <= 104, "блок ut_hw_modes_cmd_0x308 не влезает в отведённые ему 104 байт")
  .text.power_halt_seq 0x008d4e10 : { KEEP(*(.text.power_halt_seq)) }
  ASSERT(SIZEOF(.text.power_halt_seq) <= 516, "блок power_halt_seq не влезает в отведённые ему 516 байт")
  .text.hw_modes__apply_power_mode 0x008d5014 : { KEEP(*(.text.hw_modes__apply_power_mode)) }
  ASSERT(SIZEOF(.text.hw_modes__apply_power_mode) <= 120, "блок hw_modes__apply_power_mode не влезает в отведённые ему 120 байт")
  .text.hwm__apply_channel_config 0x008d508c : { KEEP(*(.text.hwm__apply_channel_config)) }
  ASSERT(SIZEOF(.text.hwm__apply_channel_config) <= 88, "блок hwm__apply_channel_config не влезает в отведённые ему 88 байт")
  .text.hwd_phy__power_up_seq 0x008d50e4 : { KEEP(*(.text.hwd_phy__power_up_seq)) }
  ASSERT(SIZEOF(.text.hwd_phy__power_up_seq) <= 76, "блок hwd_phy__power_up_seq не влезает в отведённые ему 76 байт")
  .text.rgf_reg_88a200 0x008d5130 : { KEEP(*(.text.rgf_reg_88a200)) }
  ASSERT(SIZEOF(.text.rgf_reg_88a200) <= 52, "блок rgf_reg_88a200 не влезает в отведённые ему 52 байт")
  .text.ut_hw_modes_cmd_0x304 0x008d5164 : { KEEP(*(.text.ut_hw_modes_cmd_0x304)) }
  ASSERT(SIZEOF(.text.ut_hw_modes_cmd_0x304) <= 56, "блок ut_hw_modes_cmd_0x304 не влезает в отведённые ему 56 байт")
  .text.hw_modes__program_rf_clocks 0x008d519c : { KEEP(*(.text.hw_modes__program_rf_clocks)) }
  ASSERT(SIZEOF(.text.hw_modes__program_rf_clocks) <= 52, "блок hw_modes__program_rf_clocks не влезает в отведённые ему 52 байт")
  .text.ut_hw_modes_cmd_0x30c 0x008d51d0 : { KEEP(*(.text.ut_hw_modes_cmd_0x30c)) }
  ASSERT(SIZEOF(.text.ut_hw_modes_cmd_0x30c) <= 20, "блок ut_hw_modes_cmd_0x30c не влезает в отведённые ему 20 байт")
  .text.ut_hw_modes_cmd_0x303 0x008d51e4 : { KEEP(*(.text.ut_hw_modes_cmd_0x303)) }
  ASSERT(SIZEOF(.text.ut_hw_modes_cmd_0x303) <= 56, "блок ut_hw_modes_cmd_0x303 не влезает в отведённые ему 56 байт")
  .text.ut_hw_modes_cmd_0x30b 0x008d521c : { KEEP(*(.text.ut_hw_modes_cmd_0x30b)) }
  ASSERT(SIZEOF(.text.ut_hw_modes_cmd_0x30b) <= 40, "блок ut_hw_modes_cmd_0x30b не влезает в отведённые ему 40 байт")
  .text.vring__disable_and_ack 0x008d5244 : { KEEP(*(.text.vring__disable_and_ack)) }
  ASSERT(SIZEOF(.text.vring__disable_and_ack) <= 48, "блок vring__disable_and_ack не влезает в отведённые ему 48 байт")
  .text.calib_vga_coarse_limit 0x008d5274 : { KEEP(*(.text.calib_vga_coarse_limit)) }
  ASSERT(SIZEOF(.text.calib_vga_coarse_limit) <= 200, "блок calib_vga_coarse_limit не влезает в отведённые ему 200 байт")
  .text.fw_mailbox__has_space 0x008d533c : { KEEP(*(.text.fw_mailbox__has_space)) }
  ASSERT(SIZEOF(.text.fw_mailbox__has_space) <= 56, "блок fw_mailbox__has_space не влезает в отведённые ему 56 байт")
  .text.info_flow__run 0x008d5374 : { KEEP(*(.text.info_flow__run)) }
  ASSERT(SIZEOF(.text.info_flow__run) <= 100, "блок info_flow__run не влезает в отведённые ему 100 байт")
  .text.pcp_start__cancel_timer 0x008d53d8 : { KEEP(*(.text.pcp_start__cancel_timer)) }
  ASSERT(SIZEOF(.text.pcp_start__cancel_timer) <= 40, "блок pcp_start__cancel_timer не влезает в отведённые ему 40 байт")
  .text.pcp_stop__cancel_timer 0x008d5400 : { KEEP(*(.text.pcp_stop__cancel_timer)) }
  ASSERT(SIZEOF(.text.pcp_stop__cancel_timer) <= 40, "блок pcp_stop__cancel_timer не влезает в отведённые ему 40 байт")
  .text.stream_mgr__info_req 0x008d5428 : { KEEP(*(.text.stream_mgr__info_req)) }
  ASSERT(SIZEOF(.text.stream_mgr__info_req) <= 196, "блок stream_mgr__info_req не влезает в отведённые ему 196 байт")
  .text.stream_mgr__send_info_response 0x008d54ec : { KEEP(*(.text.stream_mgr__send_info_response)) }
  ASSERT(SIZEOF(.text.stream_mgr__send_info_response) <= 116, "блок stream_mgr__send_info_response не влезает в отведённые ему 116 байт")
  .text.pbss_sta_list_update 0x008d5560 : { KEEP(*(.text.pbss_sta_list_update)) }
  ASSERT(SIZEOF(.text.pbss_sta_list_update) <= 572, "блок pbss_sta_list_update не влезает в отведённые ему 572 байт")
  .text.calib_mngr__init_schemes 0x008d579c : { KEEP(*(.text.calib_mngr__init_schemes)) }
  ASSERT(SIZEOF(.text.calib_mngr__init_schemes) <= 112, "блок calib_mngr__init_schemes не влезает в отведённые ему 112 байт")
  .text.POWER_MNGR__init 0x008d580c : { KEEP(*(.text.POWER_MNGR__init)) }
  ASSERT(SIZEOF(.text.POWER_MNGR__init) <= 140, "блок POWER_MNGR__init не влезает в отведённые ему 140 байт")
  .text.ring__init_desc 0x008d5898 : { KEEP(*(.text.ring__init_desc)) }
  ASSERT(SIZEOF(.text.ring__init_desc) <= 48, "блок ring__init_desc не влезает в отведённые ему 48 байт")
  .text.lm_main_sm__init 0x008d58c8 : { KEEP(*(.text.lm_main_sm__init)) }
  ASSERT(SIZEOF(.text.lm_main_sm__init) <= 92, "блок lm_main_sm__init не влезает в отведённые ему 92 байт")
  .text.pcp_psc_sm__init 0x008d5924 : { KEEP(*(.text.pcp_psc_sm__init)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__init) <= 72, "блок pcp_psc_sm__init не влезает в отведённые ему 72 байт")
  .text.ps_mode_sm__init 0x008d596c : { KEEP(*(.text.ps_mode_sm__init)) }
  ASSERT(SIZEOF(.text.ps_mode_sm__init) <= 76, "блок ps_mode_sm__init не влезает в отведённые ему 76 байт")
  .text.radio_manager_main_sm__init 0x008d59b8 : { KEEP(*(.text.radio_manager_main_sm__init)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__init) <= 84, "блок radio_manager_main_sm__init не влезает в отведённые ему 84 байт")
  .text.sta_psc_sm__init 0x008d5a0c : { KEEP(*(.text.sta_psc_sm__init)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__init) <= 76, "блок sta_psc_sm__init не влезает в отведённые ему 76 байт")
  .text.l2mgr__init_oob_pool 0x008d5a58 : { KEEP(*(.text.l2mgr__init_oob_pool)) }
  ASSERT(SIZEOF(.text.l2mgr__init_oob_pool) <= 52, "блок l2mgr__init_oob_pool не влезает в отведённые ему 52 байт")
  .text.sniffer__init_pool 0x008d5a8c : { KEEP(*(.text.sniffer__init_pool)) }
  ASSERT(SIZEOF(.text.sniffer__init_pool) <= 32, "блок sniffer__init_pool не влезает в отведённые ему 32 байт")
  .text.l2mgr__init_oob_detector 0x008d5aac : { KEEP(*(.text.l2mgr__init_oob_detector)) }
  ASSERT(SIZEOF(.text.l2mgr__init_oob_detector) <= 40, "блок l2mgr__init_oob_detector не влезает в отведённые ему 40 байт")
  .text.ps_assoc_sm__init 0x008d5ad4 : { KEEP(*(.text.ps_assoc_sm__init)) }
  ASSERT(SIZEOF(.text.ps_assoc_sm__init) <= 72, "блок ps_assoc_sm__init не влезает в отведённые ему 72 байт")
  .text.conn_msm__init 0x008d5b1c : { KEEP(*(.text.conn_msm__init)) }
  ASSERT(SIZEOF(.text.conn_msm__init) <= 76, "блок conn_msm__init не влезает в отведённые ему 76 байт")
  .text.ps_assoc_mgr__vt04 0x008d5b68 : { KEEP(*(.text.ps_assoc_mgr__vt04)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt04) <= 24, "блок ps_assoc_mgr__vt04 не влезает в отведённые ему 24 байт")
  .text.power_mngr__load_defaults 0x008d5b80 : { KEEP(*(.text.power_mngr__load_defaults)) }
  ASSERT(SIZEOF(.text.power_mngr__load_defaults) <= 68, "блок power_mngr__load_defaults не влезает в отведённые ему 68 байт")
  .text.power__store_and_program_880200 0x008d5bc4 : { KEEP(*(.text.power__store_and_program_880200)) }
  ASSERT(SIZEOF(.text.power__store_and_program_880200) <= 8, "блок power__store_and_program_880200 не влезает в отведённые ему 8 байт")
  .text.link_stats_sm__init 0x008d5bcc : { KEEP(*(.text.link_stats_sm__init)) }
  ASSERT(SIZEOF(.text.link_stats_sm__init) <= 64, "блок link_stats_sm__init не влезает в отведённые ему 64 байт")
  .text.radio_mgr__init_pool_and_sm 0x008d5c0c : { KEEP(*(.text.radio_mgr__init_pool_and_sm)) }
  ASSERT(SIZEOF(.text.radio_mgr__init_pool_and_sm) <= 64, "блок radio_mgr__init_pool_and_sm не влезает в отведённые ему 64 байт")
  .text.ba_td_subsm__init 0x008d5c4c : { KEEP(*(.text.ba_td_subsm__init)) }
  ASSERT(SIZEOF(.text.ba_td_subsm__init) <= 48, "блок ba_td_subsm__init не влезает в отведённые ему 48 байт")
  .text.ps_nonassoc_sm__init 0x008d5c7c : { KEEP(*(.text.ps_nonassoc_sm__init)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_sm__init) <= 72, "блок ps_nonassoc_sm__init не влезает в отведённые ему 72 байт")
  .text.calib_engine__init 0x008d5cc4 : { KEEP(*(.text.calib_engine__init)) }
  ASSERT(SIZEOF(.text.calib_engine__init) <= 104, "блок calib_engine__init не влезает в отведённые ему 104 байт")
  .text.ps_nonassoc_mgr__vt04 0x008d5d2c : { KEEP(*(.text.ps_nonassoc_mgr__vt04)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt04) <= 28, "блок ps_nonassoc_mgr__vt04 не влезает в отведённые ему 28 байт")
  .text.rm_chan_sw_sm__init 0x008d5d48 : { KEEP(*(.text.rm_chan_sw_sm__init)) }
  ASSERT(SIZEOF(.text.rm_chan_sw_sm__init) <= 60, "блок rm_chan_sw_sm__init не влезает в отведённые ему 60 байт")
  .text.boot__install_diag_magic 0x008d5d84 : { KEEP(*(.text.boot__install_diag_magic)) }
  ASSERT(SIZEOF(.text.boot__install_diag_magic) <= 56, "блок boot__install_diag_magic не влезает в отведённые ему 56 байт")
  .text.rx_pool__configure_ring 0x008d5dbc : { KEEP(*(.text.rx_pool__configure_ring)) }
  ASSERT(SIZEOF(.text.rx_pool__configure_ring) <= 48, "блок rx_pool__configure_ring не влезает в отведённые ему 48 байт")
  .text.dma_mgr__setup_queue_pair 0x008d5dec : { KEEP(*(.text.dma_mgr__setup_queue_pair)) }
  ASSERT(SIZEOF(.text.dma_mgr__setup_queue_pair) <= 120, "блок dma_mgr__setup_queue_pair не влезает в отведённые ему 120 байт")
  .text.mid__program_mac_addr 0x008d5e64 : { KEEP(*(.text.mid__program_mac_addr)) }
  ASSERT(SIZEOF(.text.mid__program_mac_addr) <= 28, "блок mid__program_mac_addr не влезает в отведённые ему 28 байт")
  .text.detector__init_common 0x008d5e80 : { KEEP(*(.text.detector__init_common)) }
  ASSERT(SIZEOF(.text.detector__init_common) <= 60, "блок detector__init_common не влезает в отведённые ему 60 байт")
  .text.obj__store3 0x008d5ebc : { KEEP(*(.text.obj__store3)) }
  ASSERT(SIZEOF(.text.obj__store3) <= 8, "блок obj__store3 не влезает в отведённые ему 8 байт")
  .text.brd_if_multi_array__init 0x008d5ec4 : { KEEP(*(.text.brd_if_multi_array__init)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__init) <= 164, "блок brd_if_multi_array__init не влезает в отведённые ему 164 байт")
  .text.FWQ_TX_AVAILABILITY__init 0x008d5f68 : { KEEP(*(.text.FWQ_TX_AVAILABILITY__init)) }
  ASSERT(SIZEOF(.text.FWQ_TX_AVAILABILITY__init) <= 36, "блок FWQ_TX_AVAILABILITY__init не влезает в отведённые ему 36 байт")
  .text.bad_beacons_detector__init 0x008d5f8c : { KEEP(*(.text.bad_beacons_detector__init)) }
  ASSERT(SIZEOF(.text.bad_beacons_detector__init) <= 80, "блок bad_beacons_detector__init не влезает в отведённые ему 80 байт")
  .text.calib_lo_power__vt04 0x008d5fdc : { KEEP(*(.text.calib_lo_power__vt04)) }
  ASSERT(SIZEOF(.text.calib_lo_power__vt04) <= 76, "блок calib_lo_power__vt04 не влезает в отведённые ему 76 байт")
  .text.pcie_device_power_if__init 0x008d6028 : { KEEP(*(.text.pcie_device_power_if__init)) }
  ASSERT(SIZEOF(.text.pcie_device_power_if__init) <= 40, "блок pcie_device_power_if__init не влезает в отведённые ему 40 байт")
  .text.pcie_device_power_sm__init 0x008d6050 : { KEEP(*(.text.pcie_device_power_sm__init)) }
  ASSERT(SIZEOF(.text.pcie_device_power_sm__init) <= 56, "блок pcie_device_power_sm__init не влезает в отведённые ему 56 байт")
  .text.u_schd__init_queue 0x008d6088 : { KEEP(*(.text.u_schd__init_queue)) }
  ASSERT(SIZEOF(.text.u_schd__init_queue) <= 28, "блок u_schd__init_queue не влезает в отведённые ему 28 байт")
  .text.ka_necessity_detector__init 0x008d60a4 : { KEEP(*(.text.ka_necessity_detector__init)) }
  ASSERT(SIZEOF(.text.ka_necessity_detector__init) <= 96, "блок ka_necessity_detector__init не влезает в отведённые ему 96 байт")
  .text.vring_cfg__init 0x008d6104 : { KEEP(*(.text.vring_cfg__init)) }
  ASSERT(SIZEOF(.text.vring_cfg__init) <= 40, "блок vring_cfg__init не влезает в отведённые ему 40 байт")
  .text.radio_mgr__init_list 0x008d612c : { KEEP(*(.text.radio_mgr__init_list)) }
  ASSERT(SIZEOF(.text.radio_mgr__init_list) <= 20, "блок radio_mgr__init_list не влезает в отведённые ему 20 байт")
  .text.tx_ppdu_ageing_timeout_detector__init 0x008d6140 : { KEEP(*(.text.tx_ppdu_ageing_timeout_detector__init)) }
  ASSERT(SIZEOF(.text.tx_ppdu_ageing_timeout_detector__init) <= 100, "блок tx_ppdu_ageing_timeout_detector__init не влезает в отведённые ему 100 байт")
  .text.mid_pool__init 0x008d61a4 : { KEEP(*(.text.mid_pool__init)) }
  ASSERT(SIZEOF(.text.mid_pool__init) <= 76, "блок mid_pool__init не влезает в отведённые ему 76 байт")
  .text.ba_sm__init 0x008d61f0 : { KEEP(*(.text.ba_sm__init)) }
  ASSERT(SIZEOF(.text.ba_sm__init) <= 84, "блок ba_sm__init не влезает в отведённые ему 84 байт")
  .text.connection__reset_fields 0x008d6244 : { KEEP(*(.text.connection__reset_fields)) }
  ASSERT(SIZEOF(.text.connection__reset_fields) <= 40, "блок connection__reset_fields не влезает в отведённые ему 40 байт")
  .text.rx_pool__init 0x008d626c : { KEEP(*(.text.rx_pool__init)) }
  ASSERT(SIZEOF(.text.rx_pool__init) <= 84, "блок rx_pool__init не влезает в отведённые ему 84 байт")
  .text.fwq_tx__init 0x008d62c0 : { KEEP(*(.text.fwq_tx__init)) }
  ASSERT(SIZEOF(.text.fwq_tx__init) <= 108, "блок fwq_tx__init не влезает в отведённые ему 108 байт")
  .text.psc_if__init 0x008d632c : { KEEP(*(.text.psc_if__init)) }
  ASSERT(SIZEOF(.text.psc_if__init) <= 84, "блок psc_if__init не влезает в отведённые ему 84 байт")
  .text.stub_ret_8d6380 0x008d6380 : { KEEP(*(.text.stub_ret_8d6380)) }
  ASSERT(SIZEOF(.text.stub_ret_8d6380) <= 4, "блок stub_ret_8d6380 не влезает в отведённые ему 4 байт")
  .text.rx_pool__set_fields 0x008d6384 : { KEEP(*(.text.rx_pool__set_fields)) }
  ASSERT(SIZEOF(.text.rx_pool__set_fields) <= 12, "блок rx_pool__set_fields не влезает в отведённые ему 12 байт")
  .text.rx_macq__setup 0x008d6390 : { KEEP(*(.text.rx_macq__setup)) }
  ASSERT(SIZEOF(.text.rx_macq__setup) <= 108, "блок rx_macq__setup не влезает в отведённые ему 108 байт")
  .text.tx_macq__setup 0x008d63fc : { KEEP(*(.text.tx_macq__setup)) }
  ASSERT(SIZEOF(.text.tx_macq__setup) <= 124, "блок tx_macq__setup не влезает в отведённые ему 124 байт")
  .text.basic_sm__setup 0x008d6478 : { KEEP(*(.text.basic_sm__setup)) }
  ASSERT(SIZEOF(.text.basic_sm__setup) <= 40, "блок basic_sm__setup не влезает в отведённые ему 40 байт")
  .text.detectors_init_sweep 0x008d64a0 : { KEEP(*(.text.detectors_init_sweep)) }
  ASSERT(SIZEOF(.text.detectors_init_sweep) <= 156, "блок detectors_init_sweep не влезает в отведённые ему 156 байт")
  .text.mid__init_find_sm 0x008d653c : { KEEP(*(.text.mid__init_find_sm)) }
  ASSERT(SIZEOF(.text.mid__init_find_sm) <= 44, "блок mid__init_find_sm не влезает в отведённые ему 44 байт")
  .text.mid__init 0x008d6568 : { KEEP(*(.text.mid__init)) }
  ASSERT(SIZEOF(.text.mid__init) <= 208, "блок mid__init не влезает в отведённые ему 208 байт")
  .text.vring__init_bcast_ctx 0x008d6638 : { KEEP(*(.text.vring__init_bcast_ctx)) }
  ASSERT(SIZEOF(.text.vring__init_bcast_ctx) <= 60, "блок vring__init_bcast_ctx не влезает в отведённые ему 60 байт")
  .text.init_bcast_queue 0x008d6674 : { KEEP(*(.text.init_bcast_queue)) }
  ASSERT(SIZEOF(.text.init_bcast_queue) <= 100, "блок init_bcast_queue не влезает в отведённые ему 100 байт")
  .text.marlon_r_if_class__init_board_file_interface 0x008d66d8 : { KEEP(*(.text.marlon_r_if_class__init_board_file_interface)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__init_board_file_interface) <= 76, "блок marlon_r_if_class__init_board_file_interface не влезает в отведённые ему 76 байт")
  .text.l2mgr__set_edca_defaults 0x008d6724 : { KEEP(*(.text.l2mgr__set_edca_defaults)) }
  ASSERT(SIZEOF(.text.l2mgr__set_edca_defaults) <= 48, "блок l2mgr__set_edca_defaults не влезает в отведённые ему 48 байт")
  .text.rx_macq__init 0x008d6754 : { KEEP(*(.text.rx_macq__init)) }
  ASSERT(SIZEOF(.text.rx_macq__init) <= 120, "блок rx_macq__init не влезает в отведённые ему 120 байт")
  .text.tx_macq_api_step 0x008d67cc : { KEEP(*(.text.tx_macq_api_step)) }
  ASSERT(SIZEOF(.text.tx_macq_api_step) <= 168, "блок tx_macq_api_step не влезает в отведённые ему 168 байт")
  .text.rx_macq__setup_default 0x008d6874 : { KEEP(*(.text.rx_macq__setup_default)) }
  ASSERT(SIZEOF(.text.rx_macq__setup_default) <= 52, "блок rx_macq__setup_default не влезает в отведённые ему 52 байт")
  .text.tx_macq__config_bcast_ring 0x008d68a8 : { KEEP(*(.text.tx_macq__config_bcast_ring)) }
  ASSERT(SIZEOF(.text.tx_macq__config_bcast_ring) <= 48, "блок tx_macq__config_bcast_ring не влезает в отведённые ему 48 байт")
  .text.tx_queue_mgr__create_queue 0x008d68d8 : { KEEP(*(.text.tx_queue_mgr__create_queue)) }
  ASSERT(SIZEOF(.text.tx_queue_mgr__create_queue) <= 228, "блок tx_queue_mgr__create_queue не влезает в отведённые ему 228 байт")
  .text.marlon_r_if_class__init_board_file_inteface 0x008d69bc : { KEEP(*(.text.marlon_r_if_class__init_board_file_inteface)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__init_board_file_inteface) <= 76, "блок marlon_r_if_class__init_board_file_inteface не влезает в отведённые ему 76 байт")
  .text.vring__cache_stats 0x008d6a08 : { KEEP(*(.text.vring__cache_stats)) }
  ASSERT(SIZEOF(.text.vring__cache_stats) <= 20, "блок vring__cache_stats не влезает в отведённые ему 20 байт")
  .text.basic_sm__inject_event 0x008d6a1c : { KEEP(*(.text.basic_sm__inject_event)) }
  ASSERT(SIZEOF(.text.basic_sm__inject_event) <= 160, "блок basic_sm__inject_event не влезает в отведённые ему 160 байт")
  .text.sm__clear_2c_and_inject 0x008d6abc : { KEEP(*(.text.sm__clear_2c_and_inject)) }
  ASSERT(SIZEOF(.text.sm__clear_2c_and_inject) <= 12, "блок sm__clear_2c_and_inject не влезает в отведённые ему 12 байт")
  .text.sm__clear_4c_and_inject 0x008d6ac8 : { KEEP(*(.text.sm__clear_4c_and_inject)) }
  ASSERT(SIZEOF(.text.sm__clear_4c_and_inject) <= 16, "блок sm__clear_4c_and_inject не влезает в отведённые ему 16 байт")
  .text.frag_8d6ad8 0x008d6ad8 : { KEEP(*(.text.frag_8d6ad8)) }
  ASSERT(SIZEOF(.text.frag_8d6ad8) <= 4, "блок frag_8d6ad8 не влезает в отведённые ему 4 байт")
  .text.sm__clear_and_inject 0x008d6adc : { KEEP(*(.text.sm__clear_and_inject)) }
  ASSERT(SIZEOF(.text.sm__clear_and_inject) <= 16, "блок sm__clear_and_inject не влезает в отведённые ему 16 байт")
  .text.maintain_sm__clear_40_and_inject 0x008d6aec : { KEEP(*(.text.maintain_sm__clear_40_and_inject)) }
  ASSERT(SIZEOF(.text.maintain_sm__clear_40_and_inject) <= 16, "блок maintain_sm__clear_40_and_inject не влезает в отведённые ему 16 байт")
  .text.ul_stream__ba_sm_evt 0x008d6afc : { KEEP(*(.text.ul_stream__ba_sm_evt)) }
  ASSERT(SIZEOF(.text.ul_stream__ba_sm_evt) <= 124, "блок ul_stream__ba_sm_evt не влезает в отведённые ему 124 байт")
  .text.conn_sm__inject_event 0x008d6b78 : { KEEP(*(.text.conn_sm__inject_event)) }
  ASSERT(SIZEOF(.text.conn_sm__inject_event) <= 8, "блок conn_sm__inject_event не влезает в отведённые ему 8 байт")
  .text.psc_if__start_psc 0x008d6b80 : { KEEP(*(.text.psc_if__start_psc)) }
  ASSERT(SIZEOF(.text.psc_if__start_psc) <= 112, "блок psc_if__start_psc не влезает в отведённые ему 112 байт")
  .text.ps_connection__psc_req_rx 0x008d6bf0 : { KEEP(*(.text.ps_connection__psc_req_rx)) }
  ASSERT(SIZEOF(.text.ps_connection__psc_req_rx) <= 128, "блок ps_connection__psc_req_rx не влезает в отведённые ему 128 байт")
  .text.sta_psc_sm__psc_resp_rx 0x008d6c70 : { KEEP(*(.text.sta_psc_sm__psc_resp_rx)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__psc_resp_rx) <= 392, "блок sta_psc_sm__psc_resp_rx не влезает в отведённые ему 392 байт")
  .text.operational_if__mbox_init 0x008d6df8 : { KEEP(*(.text.operational_if__mbox_init)) }
  ASSERT(SIZEOF(.text.operational_if__mbox_init) <= 136, "блок operational_if__mbox_init не влезает в отведённые ему 136 байт")
  .text.operational_if__mbox_ptr 0x008d6e80 : { KEEP(*(.text.operational_if__mbox_ptr)) }
  ASSERT(SIZEOF(.text.operational_if__mbox_ptr) <= 40, "блок operational_if__mbox_ptr не влезает в отведённые ему 40 байт")
  .text.mbox__debug_init_flow 0x008d6ea8 : { KEEP(*(.text.mbox__debug_init_flow)) }
  ASSERT(SIZEOF(.text.mbox__debug_init_flow) <= 116, "блок mbox__debug_init_flow не влезает в отведённые ему 116 байт")
  .text.field_bit2 0x008d6f1c : { KEEP(*(.text.field_bit2)) }
  ASSERT(SIZEOF(.text.field_bit2) <= 8, "блок field_bit2 не влезает в отведённые ему 8 байт")
  .text.isr_timer0 0x008d6f24 : { KEEP(*(.text.isr_timer0)) }
  ASSERT(SIZEOF(.text.isr_timer0) <= 40, "блок isr_timer0 не влезает в отведённые ему 40 байт")
  .text.isr_timer1 0x008d6f4c : { KEEP(*(.text.isr_timer1)) }
  ASSERT(SIZEOF(.text.isr_timer1) <= 172, "блок isr_timer1 не влезает в отведённые ему 172 байт")
  .text.stream_mgr__pring_by_index 0x008d6ff8 : { KEEP(*(.text.stream_mgr__pring_by_index)) }
  ASSERT(SIZEOF(.text.stream_mgr__pring_by_index) <= 56, "блок stream_mgr__pring_by_index не влезает в отведённые ему 56 байт")
  .text.get_g_80469c 0x008d7030 : { KEEP(*(.text.get_g_80469c)) }
  ASSERT(SIZEOF(.text.get_g_80469c) <= 20, "блок get_g_80469c не влезает в отведённые ему 20 байт")
  .text.frag_8d7044 0x008d7044 : { KEEP(*(.text.frag_8d7044)) }
  ASSERT(SIZEOF(.text.frag_8d7044) <= 52, "блок frag_8d7044 не влезает в отведённые ему 52 байт")
  .text.fw_mailbox__is_empty 0x008d7078 : { KEEP(*(.text.fw_mailbox__is_empty)) }
  ASSERT(SIZEOF(.text.fw_mailbox__is_empty) <= 12, "блок fw_mailbox__is_empty не влезает в отведённые ему 12 байт")
  .text.tx_macq__is_empty 0x008d7084 : { KEEP(*(.text.tx_macq__is_empty)) }
  ASSERT(SIZEOF(.text.tx_macq__is_empty) <= 108, "блок tx_macq__is_empty не влезает в отведённые ему 108 байт")
  .text.ies_block__is_empty 0x008d70f0 : { KEEP(*(.text.ies_block__is_empty)) }
  ASSERT(SIZEOF(.text.ies_block__is_empty) <= 12, "блок ies_block__is_empty не влезает в отведённые ему 12 байт")
  .text.bad_beacons_detector__is_bad 0x008d70fc : { KEEP(*(.text.bad_beacons_detector__is_bad)) }
  ASSERT(SIZEOF(.text.bad_beacons_detector__is_bad) <= 80, "блок bad_beacons_detector__is_bad не влезает в отведённые ему 80 байт")
  .text.ka_detector__get_state 0x008d714c : { KEEP(*(.text.ka_detector__get_state)) }
  ASSERT(SIZEOF(.text.ka_detector__get_state) <= 84, "блок ka_detector__get_state не влезает в отведённые ему 84 байт")
  .text.ageing_detector__get_state 0x008d71a0 : { KEEP(*(.text.ageing_detector__get_state)) }
  ASSERT(SIZEOF(.text.ageing_detector__get_state) <= 84, "блок ageing_detector__get_state не влезает в отведённые ему 84 байт")
  .text.detector__deadline_is_unset 0x008d71f4 : { KEEP(*(.text.detector__deadline_is_unset)) }
  ASSERT(SIZEOF(.text.detector__deadline_is_unset) <= 28, "блок detector__deadline_is_unset не влезает в отведённые ему 28 байт")
  .text.get_reg_880a3c_8d7210 0x008d7210 : { KEEP(*(.text.get_reg_880a3c_8d7210)) }
  ASSERT(SIZEOF(.text.get_reg_880a3c_8d7210) <= 16, "блок get_reg_880a3c_8d7210 не влезает в отведённые ему 16 байт")
  .text.ring__is_full 0x008d7220 : { KEEP(*(.text.ring__is_full)) }
  ASSERT(SIZEOF(.text.ring__is_full) <= 24, "блок ring__is_full не влезает в отведённые ему 24 байт")
  .text.oob_mode__read_bit 0x008d7238 : { KEEP(*(.text.oob_mode__read_bit)) }
  ASSERT(SIZEOF(.text.oob_mode__read_bit) <= 12, "блок oob_mode__read_bit не влезает в отведённые ему 12 байт")
  .text.boot__read_strap_bit 0x008d7244 : { KEEP(*(.text.boot__read_strap_bit)) }
  ASSERT(SIZEOF(.text.boot__read_strap_bit) <= 24, "блок boot__read_strap_bit не влезает в отведённые ему 24 байт")
  .text.conn_mgr__find_in_ranking_list 0x008d725c : { KEEP(*(.text.conn_mgr__find_in_ranking_list)) }
  ASSERT(SIZEOF(.text.conn_mgr__find_in_ranking_list) <= 60, "блок conn_mgr__find_in_ranking_list не влезает в отведённые ему 60 байт")
  .text.detector__slot_is_free 0x008d7298 : { KEEP(*(.text.detector__slot_is_free)) }
  ASSERT(SIZEOF(.text.detector__slot_is_free) <= 24, "блок detector__slot_is_free не влезает в отведённые ему 24 байт")
  .text.ka_detector__is_active 0x008d72b0 : { KEEP(*(.text.ka_detector__is_active)) }
  ASSERT(SIZEOF(.text.ka_detector__is_active) <= 28, "блок ka_detector__is_active не влезает в отведённые ему 28 байт")
  .text.ageing_detector__is_active 0x008d72cc : { KEEP(*(.text.ageing_detector__is_active)) }
  ASSERT(SIZEOF(.text.ageing_detector__is_active) <= 28, "блок ageing_detector__is_active не влезает в отведённые ему 28 байт")
  .text.ese__alloc_matches_id 0x008d72e8 : { KEEP(*(.text.ese__alloc_matches_id)) }
  ASSERT(SIZEOF(.text.ese__alloc_matches_id) <= 44, "блок ese__alloc_matches_id не влезает в отведённые ему 44 байт")
  .text.rm__channel_matches 0x008d7314 : { KEEP(*(.text.rm__channel_matches)) }
  ASSERT(SIZEOF(.text.rm__channel_matches) <= 40, "блок rm__channel_matches не влезает в отведённые ему 40 байт")
  .text.ese__find_alloc_by_id 0x008d733c : { KEEP(*(.text.ese__find_alloc_by_id)) }
  ASSERT(SIZEOF(.text.ese__find_alloc_by_id) <= 40, "блок ese__find_alloc_by_id не влезает в отведённые ему 40 байт")
  .text.regd__jp_or_unset 0x008d7364 : { KEEP(*(.text.regd__jp_or_unset)) }
  ASSERT(SIZEOF(.text.regd__jp_or_unset) <= 28, "блок regd__jp_or_unset не влезает в отведённые ему 28 байт")
  .text.regd__allow_if_not_jp 0x008d7380 : { KEEP(*(.text.regd__allow_if_not_jp)) }
  ASSERT(SIZEOF(.text.regd__allow_if_not_jp) <= 28, "блок regd__allow_if_not_jp не влезает в отведённые ему 28 байт")
  .text.mbox_ring__advance 0x008d739c : { KEEP(*(.text.mbox_ring__advance)) }
  ASSERT(SIZEOF(.text.mbox_ring__advance) <= 28, "блок mbox_ring__advance не влезает в отведённые ему 28 байт")
  .text.get_g_800243 0x008d73b8 : { KEEP(*(.text.get_g_800243)) }
  ASSERT(SIZEOF(.text.get_g_800243) <= 12, "блок get_g_800243 не влезает в отведённые ему 12 байт")
  .text.mid__state_is_2_or_3 0x008d73c4 : { KEEP(*(.text.mid__state_is_2_or_3)) }
  ASSERT(SIZEOF(.text.mid__state_is_2_or_3) <= 32, "блок mid__state_is_2_or_3 не влезает в отведённые ему 32 байт")
  .text.ps_cfg__find_profile 0x008d73e4 : { KEEP(*(.text.ps_cfg__find_profile)) }
  ASSERT(SIZEOF(.text.ps_cfg__find_profile) <= 48, "блок ps_cfg__find_profile не влезает в отведённые ему 48 байт")
  .text.state_is_2_8d7414 0x008d7414 : { KEEP(*(.text.state_is_2_8d7414)) }
  ASSERT(SIZEOF(.text.state_is_2_8d7414) <= 8, "блок state_is_2_8d7414 не влезает в отведённые ему 8 байт")
  .text.frag_8d741c 0x008d741c : { KEEP(*(.text.frag_8d741c)) }
  ASSERT(SIZEOF(.text.frag_8d741c) <= 4, "блок frag_8d741c не влезает в отведённые ему 4 байт")
  .text.ps_assoc_mgr__vt14 0x008d7420 : { KEEP(*(.text.ps_assoc_mgr__vt14)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt14) <= 8, "блок ps_assoc_mgr__vt14 не влезает в отведённые ему 8 байт")
  .text.state_is_1_8d7428 0x008d7428 : { KEEP(*(.text.state_is_1_8d7428)) }
  ASSERT(SIZEOF(.text.state_is_1_8d7428) <= 8, "блок state_is_1_8d7428 не влезает в отведённые ему 8 байт")
  .text.frag_8d7430 0x008d7430 : { KEEP(*(.text.frag_8d7430)) }
  ASSERT(SIZEOF(.text.frag_8d7430) <= 4, "блок frag_8d7430 не влезает в отведённые ему 4 байт")
  .text.ps_nonassoc_mgr__vt14 0x008d7434 : { KEEP(*(.text.ps_nonassoc_mgr__vt14)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt14) <= 8, "блок ps_nonassoc_mgr__vt14 не влезает в отведённые ему 8 байт")
  .text.state_is_3_8d743c 0x008d743c : { KEEP(*(.text.state_is_3_8d743c)) }
  ASSERT(SIZEOF(.text.state_is_3_8d743c) <= 8, "блок state_is_3_8d743c не влезает в отведённые ему 8 байт")
  .text.frag_8d7444 0x008d7444 : { KEEP(*(.text.frag_8d7444)) }
  ASSERT(SIZEOF(.text.frag_8d7444) <= 4, "блок frag_8d7444 не влезает в отведённые ему 4 байт")
  .text.ps_assoc_mgr__vt18 0x008d7448 : { KEEP(*(.text.ps_assoc_mgr__vt18)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt18) <= 8, "блок ps_assoc_mgr__vt18 не влезает в отведённые ему 8 байт")
  .text.state_is_2_8d7450 0x008d7450 : { KEEP(*(.text.state_is_2_8d7450)) }
  ASSERT(SIZEOF(.text.state_is_2_8d7450) <= 8, "блок state_is_2_8d7450 не влезает в отведённые ему 8 байт")
  .text.frag_8d7458 0x008d7458 : { KEEP(*(.text.frag_8d7458)) }
  ASSERT(SIZEOF(.text.frag_8d7458) <= 4, "блок frag_8d7458 не влезает в отведённые ему 4 байт")
  .text.ps_nonassoc_mgr__vt18 0x008d745c : { KEEP(*(.text.ps_nonassoc_mgr__vt18)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt18) <= 8, "блок ps_nonassoc_mgr__vt18 не влезает в отведённые ему 8 байт")
  .text.get_g_801488_8d7464 0x008d7464 : { KEEP(*(.text.get_g_801488_8d7464)) }
  ASSERT(SIZEOF(.text.get_g_801488_8d7464) <= 28, "блок get_g_801488_8d7464 не влезает в отведённые ему 28 байт")
  .text.get_g_801488_8d7480 0x008d7480 : { KEEP(*(.text.get_g_801488_8d7480)) }
  ASSERT(SIZEOF(.text.get_g_801488_8d7480) <= 28, "блок get_g_801488_8d7480 не влезает в отведённые ему 28 байт")
  .text.regd__allow_if_not_jp_b 0x008d749c : { KEEP(*(.text.regd__allow_if_not_jp_b)) }
  ASSERT(SIZEOF(.text.regd__allow_if_not_jp_b) <= 28, "блок regd__allow_if_not_jp_b не влезает в отведённые ему 28 байт")
  .text.get_reg_880a7c_8d74b8 0x008d74b8 : { KEEP(*(.text.get_reg_880a7c_8d74b8)) }
  ASSERT(SIZEOF(.text.get_reg_880a7c_8d74b8) <= 16, "блок get_reg_880a7c_8d74b8 не влезает в отведённые ему 16 байт")
  .text.get_reg_880a7c_8d74c8 0x008d74c8 : { KEEP(*(.text.get_reg_880a7c_8d74c8)) }
  ASSERT(SIZEOF(.text.get_reg_880a7c_8d74c8) <= 16, "блок get_reg_880a7c_8d74c8 не влезает в отведённые ему 16 байт")
  .text.host_if__hw_ready_for_wmi 0x008d74d8 : { KEEP(*(.text.host_if__hw_ready_for_wmi)) }
  ASSERT(SIZEOF(.text.host_if__hw_ready_for_wmi) <= 32, "блок host_if__hw_ready_for_wmi не влезает в отведённые ему 32 байт")
  .text.get_reg_880a7c 0x008d74f8 : { KEEP(*(.text.get_reg_880a7c)) }
  ASSERT(SIZEOF(.text.get_reg_880a7c) <= 20, "блок get_reg_880a7c не влезает в отведённые ему 20 байт")
  .text.rf__is_present 0x008d750c : { KEEP(*(.text.rf__is_present)) }
  ASSERT(SIZEOF(.text.rf__is_present) <= 32, "блок rf__is_present не влезает в отведённые ему 32 байт")
  .text.get_reg_8802bc 0x008d752c : { KEEP(*(.text.get_reg_8802bc)) }
  ASSERT(SIZEOF(.text.get_reg_8802bc) <= 20, "блок get_reg_8802bc не влезает в отведённые ему 20 байт")
  .text.get_reg_880a3c_8d7540 0x008d7540 : { KEEP(*(.text.get_reg_880a3c_8d7540)) }
  ASSERT(SIZEOF(.text.get_reg_880a3c_8d7540) <= 16, "блок get_reg_880a3c_8d7540 не влезает в отведённые ему 16 байт")
  .text.regd__is_country_us 0x008d7550 : { KEEP(*(.text.regd__is_country_us)) }
  ASSERT(SIZEOF(.text.regd__is_country_us) <= 28, "блок regd__is_country_us не влезает в отведённые ему 28 байт")
  .text.u_schd__tick 0x008d756c : { KEEP(*(.text.u_schd__tick)) }
  ASSERT(SIZEOF(.text.u_schd__tick) <= 56, "блок u_schd__tick не влезает в отведённые ему 56 байт")
  .text.frag_8d75a4 0x008d75a4 : { KEEP(*(.text.frag_8d75a4)) }
  ASSERT(SIZEOF(.text.frag_8d75a4) <= 4, "блок frag_8d75a4 не влезает в отведённые ему 4 байт")
  .text.conn_msm__on_ntf_key_installed 0x008d75a8 : { KEEP(*(.text.conn_msm__on_ntf_key_installed)) }
  ASSERT(SIZEOF(.text.conn_msm__on_ntf_key_installed) <= 52, "блок conn_msm__on_ntf_key_installed не влезает в отведённые ему 52 байт")
  .text.rm_main_sm__kick_channel_switch_sm 0x008d75dc : { KEEP(*(.text.rm_main_sm__kick_channel_switch_sm)) }
  ASSERT(SIZEOF(.text.rm_main_sm__kick_channel_switch_sm) <= 80, "блок rm_main_sm__kick_channel_switch_sm не влезает в отведённые ему 80 байт")
  .text.tail_lmac_if_send_cmd_0x1b_8d762c 0x008d762c : { KEEP(*(.text.tail_lmac_if_send_cmd_0x1b_8d762c)) }
  ASSERT(SIZEOF(.text.tail_lmac_if_send_cmd_0x1b_8d762c) <= 12, "блок tail_lmac_if_send_cmd_0x1b_8d762c не влезает в отведённые ему 12 байт")
  .text.link_stats_sm__on_latency_timer 0x008d7638 : { KEEP(*(.text.link_stats_sm__on_latency_timer)) }
  ASSERT(SIZEOF(.text.link_stats_sm__on_latency_timer) <= 32, "блок link_stats_sm__on_latency_timer не влезает в отведённые ему 32 байт")
  .text.user_led__check_index 0x008d7658 : { KEEP(*(.text.user_led__check_index)) }
  ASSERT(SIZEOF(.text.user_led__check_index) <= 32, "блок user_led__check_index не влезает в отведённые ему 32 байт")
  .text.rgf_reg_880280_8d7678 0x008d7678 : { KEEP(*(.text.rgf_reg_880280_8d7678)) }
  ASSERT(SIZEOF(.text.rgf_reg_880280_8d7678) <= 24, "блок rgf_reg_880280_8d7678 не влезает в отведённые ему 24 байт")
  .text.stub_ret_8d7690 0x008d7690 : { KEEP(*(.text.stub_ret_8d7690)) }
  ASSERT(SIZEOF(.text.stub_ret_8d7690) <= 4, "блок stub_ret_8d7690 не влезает в отведённые ему 4 байт")
  .text.user_led__set_pattern 0x008d7694 : { KEEP(*(.text.user_led__set_pattern)) }
  ASSERT(SIZEOF(.text.user_led__set_pattern) <= 100, "блок user_led__set_pattern не влезает в отведённые ему 100 байт")
  .text.get_reg_88027c 0x008d76f8 : { KEEP(*(.text.get_reg_88027c)) }
  ASSERT(SIZEOF(.text.get_reg_88027c) <= 12, "блок get_reg_88027c не влезает в отведённые ему 12 байт")
  .text.stub_ret_8d7704 0x008d7704 : { KEEP(*(.text.stub_ret_8d7704)) }
  ASSERT(SIZEOF(.text.stub_ret_8d7704) <= 4, "блок stub_ret_8d7704 не влезает в отведённые ему 4 байт")
  .text.set_reg_880b50_x2 0x008d7708 : { KEEP(*(.text.set_reg_880b50_x2)) }
  ASSERT(SIZEOF(.text.set_reg_880b50_x2) <= 16, "блок set_reg_880b50_x2 не влезает в отведённые ему 16 байт")
  .text.set_reg_880b60_8d7718 0x008d7718 : { KEEP(*(.text.set_reg_880b60_8d7718)) }
  ASSERT(SIZEOF(.text.set_reg_880b60_8d7718) <= 12, "блок set_reg_880b60_8d7718 не влезает в отведённые ему 12 байт")
  .text.led_scheme__init 0x008d7724 : { KEEP(*(.text.led_scheme__init)) }
  ASSERT(SIZEOF(.text.led_scheme__init) <= 56, "блок led_scheme__init не влезает в отведённые ему 56 байт")
  .text.led_scheme__apply 0x008d775c : { KEEP(*(.text.led_scheme__apply)) }
  ASSERT(SIZEOF(.text.led_scheme__apply) <= 116, "блок led_scheme__apply не влезает в отведённые ему 116 байт")
  .text.led__clear_scheme 0x008d77d0 : { KEEP(*(.text.led__clear_scheme)) }
  ASSERT(SIZEOF(.text.led__clear_scheme) <= 20, "блок led__clear_scheme не влезает в отведённые ему 20 байт")
  .text.led__update_by_link_rate 0x008d77e4 : { KEEP(*(.text.led__update_by_link_rate)) }
  ASSERT(SIZEOF(.text.led__update_by_link_rate) <= 24, "блок led__update_by_link_rate не влезает в отведённые ему 24 байт")
  .text.set_reg_880200 0x008d77fc : { KEEP(*(.text.set_reg_880200)) }
  ASSERT(SIZEOF(.text.set_reg_880200) <= 16, "блок set_reg_880200 не влезает в отведённые ему 16 байт")
  .text.tail_user_lfsr__configure 0x008d780c : { KEEP(*(.text.tail_user_lfsr__configure)) }
  ASSERT(SIZEOF(.text.tail_user_lfsr__configure) <= 8, "блок tail_user_lfsr__configure не влезает в отведённые ему 8 байт")
  .text.mid__acquire_link 0x008d7814 : { KEEP(*(.text.mid__acquire_link)) }
  ASSERT(SIZEOF(.text.mid__acquire_link) <= 36, "блок mid__acquire_link не влезает в отведённые ему 36 байт")
  .text.mid__link_acquisition_action 0x008d7838 : { KEEP(*(.text.mid__link_acquisition_action)) }
  ASSERT(SIZEOF(.text.mid__link_acquisition_action) <= 312, "блок mid__link_acquisition_action не влезает в отведённые ему 312 байт")
  .text.mid_list__remove_entry 0x008d7970 : { KEEP(*(.text.mid_list__remove_entry)) }
  ASSERT(SIZEOF(.text.mid_list__remove_entry) <= 92, "блок mid_list__remove_entry не влезает в отведённые ему 92 байт")
  .text.conn_mgr__link_down_evt 0x008d79cc : { KEEP(*(.text.conn_mgr__link_down_evt)) }
  ASSERT(SIZEOF(.text.conn_mgr__link_down_evt) <= 36, "блок conn_mgr__link_down_evt не влезает в отведённые ему 36 байт")
  .text.link_lost_ntf__disconnect 0x008d79f0 : { KEEP(*(.text.link_lost_ntf__disconnect)) }
  ASSERT(SIZEOF(.text.link_lost_ntf__disconnect) <= 48, "блок link_lost_ntf__disconnect не влезает в отведённые ему 48 байт")
  .text.sw_tx_mgmt__acquire_link 0x008d7a20 : { KEEP(*(.text.sw_tx_mgmt__acquire_link)) }
  ASSERT(SIZEOF(.text.sw_tx_mgmt__acquire_link) <= 156, "блок sw_tx_mgmt__acquire_link не влезает в отведённые ему 156 байт")
  .text.epi_8d7abc 0x008d7abc : { KEEP(*(.text.epi_8d7abc)) }
  ASSERT(SIZEOF(.text.epi_8d7abc) <= 4, "блок epi_8d7abc не влезает в отведённые ему 4 байт")
  .text.lm_main_sm__on_link_stat_update 0x008d7ac0 : { KEEP(*(.text.lm_main_sm__on_link_stat_update)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_link_stat_update) <= 32, "блок lm_main_sm__on_link_stat_update не влезает в отведённые ему 32 байт")
  .text.SW_TX_MGMT_API__link_up_evt 0x008d7ae0 : { KEEP(*(.text.SW_TX_MGMT_API__link_up_evt)) }
  ASSERT(SIZEOF(.text.SW_TX_MGMT_API__link_up_evt) <= 244, "блок SW_TX_MGMT_API__link_up_evt не влезает в отведённые ему 244 байт")
  .text.tail_l2mgr__notify_link_up 0x008d7bd4 : { KEEP(*(.text.tail_l2mgr__notify_link_up)) }
  ASSERT(SIZEOF(.text.tail_l2mgr__notify_link_up) <= 8, "блок tail_l2mgr__notify_link_up не влезает в отведённые ему 8 байт")
  .text.conn_mgr__link_up_evt 0x008d7bdc : { KEEP(*(.text.conn_mgr__link_up_evt)) }
  ASSERT(SIZEOF(.text.conn_mgr__link_up_evt) <= 56, "блок conn_mgr__link_up_evt не влезает в отведённые ему 56 байт")
  .text.lm_main_sm__on_self_linkup_done 0x008d7c14 : { KEEP(*(.text.lm_main_sm__on_self_linkup_done)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_self_linkup_done) <= 28, "блок lm_main_sm__on_self_linkup_done не влезает в отведённые ему 28 байт")
  .text.lm_main_sm__linkup_failed 0x008d7c30 : { KEEP(*(.text.lm_main_sm__linkup_failed)) }
  ASSERT(SIZEOF(.text.lm_main_sm__linkup_failed) <= 112, "блок lm_main_sm__linkup_failed не влезает в отведённые ему 112 байт")
  .text.conn_main_sm__linkup_ntf 0x008d7ca0 : { KEEP(*(.text.conn_main_sm__linkup_ntf)) }
  ASSERT(SIZEOF(.text.conn_main_sm__linkup_ntf) <= 108, "блок conn_main_sm__linkup_ntf не влезает в отведённые ему 108 байт")
  .text.lm__notify_linkup 0x008d7d0c : { KEEP(*(.text.lm__notify_linkup)) }
  ASSERT(SIZEOF(.text.lm__notify_linkup) <= 16, "блок lm__notify_linkup не влезает в отведённые ему 16 байт")
  .text.lm_if__on_linkup_ready 0x008d7d1c : { KEEP(*(.text.lm_if__on_linkup_ready)) }
  ASSERT(SIZEOF(.text.lm_if__on_linkup_ready) <= 92, "блок lm_if__on_linkup_ready не влезает в отведённые ему 92 байт")
  .text.lm_main_sm__on_linkup_req__lm_state_idle 0x008d7d78 : { KEEP(*(.text.lm_main_sm__on_linkup_req__lm_state_idle)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_linkup_req__lm_state_idle) <= 88, "блок lm_main_sm__on_linkup_req__lm_state_idle не влезает в отведённые ему 88 байт")
  .text.lm_main_sm__on_linkup_req__lm_state_configured 0x008d7dd0 : { KEEP(*(.text.lm_main_sm__on_linkup_req__lm_state_configured)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_linkup_req__lm_state_configured) <= 20, "блок lm_main_sm__on_linkup_req__lm_state_configured не влезает в отведённые ему 20 байт")
  .text.find_mngr__listen_start 0x008d7de4 : { KEEP(*(.text.find_mngr__listen_start)) }
  ASSERT(SIZEOF(.text.find_mngr__listen_start) <= 108, "блок find_mngr__listen_start не влезает в отведённые ему 108 байт")
  .text.find_mng__listen 0x008d7e50 : { KEEP(*(.text.find_mng__listen)) }
  ASSERT(SIZEOF(.text.find_mng__listen) <= 72, "блок find_mng__listen не влезает в отведённые ему 72 байт")
  .text.find_sm__report_listen_started 0x008d7e98 : { KEEP(*(.text.find_sm__report_listen_started)) }
  ASSERT(SIZEOF(.text.find_sm__report_listen_started) <= 20, "блок find_sm__report_listen_started не влезает в отведённые ему 20 байт")
  .text.find_mngr__listen_end 0x008d7eac : { KEEP(*(.text.find_mngr__listen_end)) }
  ASSERT(SIZEOF(.text.find_mngr__listen_end) <= 60, "блок find_mngr__listen_end не влезает в отведённые ему 60 байт")
  .text.conn_msm__on_ntf_lm_started__wait_for_lm_start 0x008d7ee8 : { KEEP(*(.text.conn_msm__on_ntf_lm_started__wait_for_lm_start)) }
  ASSERT(SIZEOF(.text.conn_msm__on_ntf_lm_started__wait_for_lm_start) <= 20, "блок conn_msm__on_ntf_lm_started__wait_for_lm_start не влезает в отведённые ему 20 байт")
  .text.lmac_if__send_abft_resp_ctrl 0x008d7efc : { KEEP(*(.text.lmac_if__send_abft_resp_ctrl)) }
  ASSERT(SIZEOF(.text.lmac_if__send_abft_resp_ctrl) <= 68, "блок lmac_if__send_abft_resp_ctrl не влезает в отведённые ему 68 байт")
  .text.l2mgr__program_assoc_vring 0x008d7f40 : { KEEP(*(.text.l2mgr__program_assoc_vring)) }
  ASSERT(SIZEOF(.text.l2mgr__program_assoc_vring) <= 64, "блок l2mgr__program_assoc_vring не влезает в отведённые ему 64 байт")
  .text.lmac_if__wait_ucode_ack_4 0x008d7f80 : { KEEP(*(.text.lmac_if__wait_ucode_ack_4)) }
  ASSERT(SIZEOF(.text.lmac_if__wait_ucode_ack_4) <= 132, "блок lmac_if__wait_ucode_ack_4 не влезает в отведённые ему 132 байт")
  .text.lmac_if__wait_ucode_ack_2 0x008d8004 : { KEEP(*(.text.lmac_if__wait_ucode_ack_2)) }
  ASSERT(SIZEOF(.text.lmac_if__wait_ucode_ack_2) <= 116, "блок lmac_if__wait_ucode_ack_2 не влезает в отведённые ему 116 байт")
  .text.lmac_if__awake_peers_evt 0x008d8078 : { KEEP(*(.text.lmac_if__awake_peers_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__awake_peers_evt) <= 60, "блок lmac_if__awake_peers_evt не влезает в отведённые ему 60 байт")
  .text.lmac_if__build_bcon_cfg 0x008d80b4 : { KEEP(*(.text.lmac_if__build_bcon_cfg)) }
  ASSERT(SIZEOF(.text.lmac_if__build_bcon_cfg) <= 40, "блок lmac_if__build_bcon_cfg не влезает в отведённые ему 40 байт")
  .text.lmac_if__send_bcon_mgt 0x008d80dc : { KEEP(*(.text.lmac_if__send_bcon_mgt)) }
  ASSERT(SIZEOF(.text.lmac_if__send_bcon_mgt) <= 120, "блок lmac_if__send_bcon_mgt не влезает в отведённые ему 120 байт")
  .text.lmac_if__mark_stop_beacon 0x008d8154 : { KEEP(*(.text.lmac_if__mark_stop_beacon)) }
  ASSERT(SIZEOF(.text.lmac_if__mark_stop_beacon) <= 8, "блок lmac_if__mark_stop_beacon не влезает в отведённые ему 8 байт")
  .text.lmac_if__stop_beacon 0x008d815c : { KEEP(*(.text.lmac_if__stop_beacon)) }
  ASSERT(SIZEOF(.text.lmac_if__stop_beacon) <= 44, "блок lmac_if__stop_beacon не влезает в отведённые ему 44 байт")
  .text.lmac_if__abft_notify_evt 0x008d8188 : { KEEP(*(.text.lmac_if__abft_notify_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__abft_notify_evt) <= 144, "блок lmac_if__abft_notify_evt не влезает в отведённые ему 144 байт")
  .text.lmac_if__bf_done_evt 0x008d8218 : { KEEP(*(.text.lmac_if__bf_done_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__bf_done_evt) <= 348, "блок lmac_if__bf_done_evt не влезает в отведённые ему 348 байт")
  .text.lmac_if__bf_done_and_new_link 0x008d8374 : { KEEP(*(.text.lmac_if__bf_done_and_new_link)) }
  ASSERT(SIZEOF(.text.lmac_if__bf_done_and_new_link) <= 28, "блок lmac_if__bf_done_and_new_link не влезает в отведённые ему 28 байт")
  .text.lmac_if_send_cmd_0x14 0x008d8390 : { KEEP(*(.text.lmac_if_send_cmd_0x14)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x14) <= 92, "блок lmac_if_send_cmd_0x14 не влезает в отведённые ему 92 байт")
  .text.lmac_if_send_cmd_0x0c 0x008d83ec : { KEEP(*(.text.lmac_if_send_cmd_0x0c)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x0c) <= 172, "блок lmac_if_send_cmd_0x0c не влезает в отведённые ему 172 байт")
  .text.tail_lmac_if_send_cmd_0x04 0x008d8498 : { KEEP(*(.text.tail_lmac_if_send_cmd_0x04)) }
  ASSERT(SIZEOF(.text.tail_lmac_if_send_cmd_0x04) <= 4, "блок tail_lmac_if_send_cmd_0x04 не влезает в отведённые ему 4 байт")
  .text.tail_lmac_if_send_cmd_0x0c 0x008d849c : { KEEP(*(.text.tail_lmac_if_send_cmd_0x0c)) }
  ASSERT(SIZEOF(.text.tail_lmac_if_send_cmd_0x0c) <= 12, "блок tail_lmac_if_send_cmd_0x0c не влезает в отведённые ему 12 байт")
  .text.lmac_if_discovery_mode_cfg_handler 0x008d84a8 : { KEEP(*(.text.lmac_if_discovery_mode_cfg_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_discovery_mode_cfg_handler) <= 72, "блок lmac_if_discovery_mode_cfg_handler не влезает в отведённые ему 72 байт")
  .text.lmac_if_echo_evt_handler 0x008d84f0 : { KEEP(*(.text.lmac_if_echo_evt_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_echo_evt_handler) <= 52, "блок lmac_if_echo_evt_handler не влезает в отведённые ему 52 байт")
  .text.lmac_if_flush_q_done_handler 0x008d8524 : { KEEP(*(.text.lmac_if_flush_q_done_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_flush_q_done_handler) <= 8, "блок lmac_if_flush_q_done_handler не влезает в отведённые ему 8 байт")
  .text.lmac_if_send_cmd_0x30 0x008d852c : { KEEP(*(.text.lmac_if_send_cmd_0x30)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x30) <= 36, "блок lmac_if_send_cmd_0x30 не влезает в отведённые ему 36 байт")
  .text.lmac_if__send_init_cfg_cmd 0x008d8550 : { KEEP(*(.text.lmac_if__send_init_cfg_cmd)) }
  ASSERT(SIZEOF(.text.lmac_if__send_init_cfg_cmd) <= 124, "блок lmac_if__send_init_cfg_cmd не влезает в отведённые ему 124 байт")
  .text.lmac_mbox__is_full 0x008d85cc : { KEEP(*(.text.lmac_mbox__is_full)) }
  ASSERT(SIZEOF(.text.lmac_mbox__is_full) <= 24, "блок lmac_mbox__is_full не влезает в отведённые ему 24 байт")
  .text.lmac_if_keep_alive_trigger_handler 0x008d85e4 : { KEEP(*(.text.lmac_if_keep_alive_trigger_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_keep_alive_trigger_handler) <= 60, "блок lmac_if_keep_alive_trigger_handler не влезает в отведённые ему 60 байт")
  .text.lmac_if_link_lost_handler 0x008d8620 : { KEEP(*(.text.lmac_if_link_lost_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_link_lost_handler) <= 60, "блок lmac_if_link_lost_handler не влезает в отведённые ему 60 байт")
  .text.lmac_if__mac_monitor_report 0x008d865c : { KEEP(*(.text.lmac_if__mac_monitor_report)) }
  ASSERT(SIZEOF(.text.lmac_if__mac_monitor_report) <= 348, "блок lmac_if__mac_monitor_report не влезает в отведённые ему 348 байт")
  .text.lmac_if_send_cmd_0x21 0x008d87b8 : { KEEP(*(.text.lmac_if_send_cmd_0x21)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x21) <= 72, "блок lmac_if_send_cmd_0x21 не влезает в отведённые ему 72 байт")
  .text.lmac_if_send_cmd_0x19 0x008d8800 : { KEEP(*(.text.lmac_if_send_cmd_0x19)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x19) <= 36, "блок lmac_if_send_cmd_0x19 не влезает в отведённые ему 36 байт")
  .text.lmac_if__send_phy_ina_det_cfg 0x008d8824 : { KEEP(*(.text.lmac_if__send_phy_ina_det_cfg)) }
  ASSERT(SIZEOF(.text.lmac_if__send_phy_ina_det_cfg) <= 64, "блок lmac_if__send_phy_ina_det_cfg не влезает в отведённые ему 64 байт")
  .text.lmac_if_send_cmd_0x08 0x008d8864 : { KEEP(*(.text.lmac_if_send_cmd_0x08)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x08) <= 84, "блок lmac_if_send_cmd_0x08 не влезает в отведённые ему 84 байт")
  .text.lmac_if_send_cmd_0x13 0x008d88b8 : { KEEP(*(.text.lmac_if_send_cmd_0x13)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x13) <= 48, "блок lmac_if_send_cmd_0x13 не влезает в отведённые ему 48 байт")
  .text.lmac_if__rs_done_evt 0x008d88e8 : { KEEP(*(.text.lmac_if__rs_done_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__rs_done_evt) <= 156, "блок lmac_if__rs_done_evt не влезает в отведённые ему 156 байт")
  .text.LMAC_IF__rs_started 0x008d8984 : { KEEP(*(.text.LMAC_IF__rs_started)) }
  ASSERT(SIZEOF(.text.LMAC_IF__rs_started) <= 64, "блок LMAC_IF__rs_started не влезает в отведённые ему 64 байт")
  .text.lmac_if__mark_rx_off 0x008d89c4 : { KEEP(*(.text.lmac_if__mark_rx_off)) }
  ASSERT(SIZEOF(.text.lmac_if__mark_rx_off) <= 8, "блок lmac_if__mark_rx_off не влезает в отведённые ему 8 байт")
  .text.lmac_if_send_cmd_0x03 0x008d89cc : { KEEP(*(.text.lmac_if_send_cmd_0x03)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x03) <= 36, "блок lmac_if_send_cmd_0x03 не влезает в отведённые ему 36 байт")
  .text.lmac_if__build_cmd_0x01 0x008d89f0 : { KEEP(*(.text.lmac_if__build_cmd_0x01)) }
  ASSERT(SIZEOF(.text.lmac_if__build_cmd_0x01) <= 36, "блок lmac_if__build_cmd_0x01 не влезает в отведённые ему 36 байт")
  .text.lmac_if_send_cmd_0x01 0x008d8a14 : { KEEP(*(.text.lmac_if_send_cmd_0x01)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x01) <= 72, "блок lmac_if_send_cmd_0x01 не влезает в отведённые ему 72 байт")
  .text.lmac_if_send_cmd_0x0f 0x008d8a5c : { KEEP(*(.text.lmac_if_send_cmd_0x0f)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x0f) <= 32, "блок lmac_if_send_cmd_0x0f не влезает в отведённые ему 32 байт")
  .text.lmac_if__send_selective_neighbor_cfg 0x008d8a7c : { KEEP(*(.text.lmac_if__send_selective_neighbor_cfg)) }
  ASSERT(SIZEOF(.text.lmac_if__send_selective_neighbor_cfg) <= 196, "блок lmac_if__send_selective_neighbor_cfg не влезает в отведённые ему 196 байт")
  .text.lmac_if_send_cmd_0x11 0x008d8b40 : { KEEP(*(.text.lmac_if_send_cmd_0x11)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x11) <= 92, "блок lmac_if_send_cmd_0x11 не влезает в отведённые ему 92 байт")
  .text.lmac_if__send_lmac_personality 0x008d8b9c : { KEEP(*(.text.lmac_if__send_lmac_personality)) }
  ASSERT(SIZEOF(.text.lmac_if__send_lmac_personality) <= 32, "блок lmac_if__send_lmac_personality не влезает в отведённые ему 32 байт")
  .text.lmac_if_ps_shallow_sleep_ntf_handler 0x008d8bbc : { KEEP(*(.text.lmac_if_ps_shallow_sleep_ntf_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_ps_shallow_sleep_ntf_handler) <= 20, "блок lmac_if_ps_shallow_sleep_ntf_handler не влезает в отведённые ему 20 байт")
  .text.lmac_if_send_cmd_0x16 0x008d8bd0 : { KEEP(*(.text.lmac_if_send_cmd_0x16)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x16) <= 36, "блок lmac_if_send_cmd_0x16 не влезает в отведённые ему 36 байт")
  .text.lmac_if__key_evt 0x008d8bf4 : { KEEP(*(.text.lmac_if__key_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__key_evt) <= 140, "блок lmac_if__key_evt не влезает в отведённые ему 140 байт")
  .text.lmac_if_send_cmd_0x27 0x008d8c80 : { KEEP(*(.text.lmac_if_send_cmd_0x27)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x27) <= 32, "блок lmac_if_send_cmd_0x27 не влезает в отведённые ему 32 байт")
  .text.lmac_if_ps_traffic_deferral_cfg_handler 0x008d8ca0 : { KEEP(*(.text.lmac_if_ps_traffic_deferral_cfg_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_ps_traffic_deferral_cfg_handler) <= 12, "блок lmac_if_ps_traffic_deferral_cfg_handler не влезает в отведённые ему 12 байт")
  .text.lmac_if_ps_wake_pcie_handler 0x008d8cac : { KEEP(*(.text.lmac_if_ps_wake_pcie_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_ps_wake_pcie_handler) <= 4, "блок lmac_if_ps_wake_pcie_handler не влезает в отведённые ему 4 байт")
  .text.lmac_if_trigger_bf 0x008d8cb0 : { KEEP(*(.text.lmac_if_trigger_bf)) }
  ASSERT(SIZEOF(.text.lmac_if_trigger_bf) <= 72, "блок lmac_if_trigger_bf не влезает в отведённые ему 72 байт")
  .text.lmac_if__fill_cmd_hdr 0x008d8cf8 : { KEEP(*(.text.lmac_if__fill_cmd_hdr)) }
  ASSERT(SIZEOF(.text.lmac_if__fill_cmd_hdr) <= 56, "блок lmac_if__fill_cmd_hdr не влезает в отведённые ему 56 байт")
  .text.lmac_if__build_cmd_0x04 0x008d8d30 : { KEEP(*(.text.lmac_if__build_cmd_0x04)) }
  ASSERT(SIZEOF(.text.lmac_if__build_cmd_0x04) <= 116, "блок lmac_if__build_cmd_0x04 не влезает в отведённые ему 116 байт")
  .text.lmac_if_send_cmd_0x04 0x008d8da4 : { KEEP(*(.text.lmac_if_send_cmd_0x04)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x04) <= 60, "блок lmac_if_send_cmd_0x04 не влезает в отведённые ему 60 байт")
  .text.lmac_if_update_aw_ie_handler 0x008d8de0 : { KEEP(*(.text.lmac_if_update_aw_ie_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_update_aw_ie_handler) <= 76, "блок lmac_if_update_aw_ie_handler не влезает в отведённые ему 76 байт")
  .text.lmac_if_send_cmd_0x05 0x008d8e2c : { KEEP(*(.text.lmac_if_send_cmd_0x05)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x05) <= 60, "блок lmac_if_send_cmd_0x05 не влезает в отведённые ему 60 байт")
  .text.lmac_if_send_cmd_0x22 0x008d8e68 : { KEEP(*(.text.lmac_if_send_cmd_0x22)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x22) <= 48, "блок lmac_if_send_cmd_0x22 не влезает в отведённые ему 48 байт")
  .text.lmac_if_queue_deleted_handler 0x008d8e98 : { KEEP(*(.text.lmac_if_queue_deleted_handler)) }
  ASSERT(SIZEOF(.text.lmac_if_queue_deleted_handler) <= 8, "блок lmac_if_queue_deleted_handler не влезает в отведённые ему 8 байт")
  .text.conn__inject_evt3 0x008d8ea0 : { KEEP(*(.text.conn__inject_evt3)) }
  ASSERT(SIZEOF(.text.conn__inject_evt3) <= 12, "блок conn__inject_evt3 не влезает в отведённые ему 12 байт")
  .text.calib_lo_leakage_substep 0x008d8eac : { KEEP(*(.text.calib_lo_leakage_substep)) }
  ASSERT(SIZEOF(.text.calib_lo_leakage_substep) <= 144, "блок calib_lo_leakage_substep не влезает в отведённые ему 144 байт")
  .text.set_g_8000fc 0x008d8f3c : { KEEP(*(.text.set_g_8000fc)) }
  ASSERT(SIZEOF(.text.set_g_8000fc) <= 8, "блок set_g_8000fc не влезает в отведённые ему 8 байт")
  .text.get_g_8000fc 0x008d8f44 : { KEEP(*(.text.get_g_8000fc)) }
  ASSERT(SIZEOF(.text.get_g_8000fc) <= 12, "блок get_g_8000fc не влезает в отведённые ему 12 байт")
  .text.approx_magnitude_b 0x008d8f50 : { KEEP(*(.text.approx_magnitude_b)) }
  ASSERT(SIZEOF(.text.approx_magnitude_b) <= 48, "блок approx_magnitude_b не влезает в отведённые ему 48 байт")
  .text.marlon_r_if_class__load_brd_parameters_section 0x008d8f80 : { KEEP(*(.text.marlon_r_if_class__load_brd_parameters_section)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__load_brd_parameters_section) <= 296, "блок marlon_r_if_class__load_brd_parameters_section не влезает в отведённые ему 296 байт")
  .text.marlon_r_if_class__load_brd_rf_cfg_section 0x008d90a8 : { KEEP(*(.text.marlon_r_if_class__load_brd_rf_cfg_section)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__load_brd_rf_cfg_section) <= 300, "блок marlon_r_if_class__load_brd_rf_cfg_section не влезает в отведённые ему 300 байт")
  .text.rm_main_sm__lock_primary 0x008d91d4 : { KEEP(*(.text.rm_main_sm__lock_primary)) }
  ASSERT(SIZEOF(.text.rm_main_sm__lock_primary) <= 72, "блок rm_main_sm__lock_primary не влезает в отведённые ему 72 байт")
  .text.radio_manager__lock_primary 0x008d921c : { KEEP(*(.text.radio_manager__lock_primary)) }
  ASSERT(SIZEOF(.text.radio_manager__lock_primary) <= 108, "блок radio_manager__lock_primary не влезает в отведённые ему 108 байт")
  .text.RADIO_MGR__lock_primary 0x008d9288 : { KEEP(*(.text.RADIO_MGR__lock_primary)) }
  ASSERT(SIZEOF(.text.RADIO_MGR__lock_primary) <= 44, "блок RADIO_MGR__lock_primary не влезает в отведённые ему 44 байт")
  .text.frag_8d92b4 0x008d92b4 : { KEEP(*(.text.frag_8d92b4)) }
  ASSERT(SIZEOF(.text.frag_8d92b4) <= 4, "блок frag_8d92b4 не влезает в отведённые ему 4 байт")
  .text.calib_engine__on_lock_radio 0x008d92b8 : { KEEP(*(.text.calib_engine__on_lock_radio)) }
  ASSERT(SIZEOF(.text.calib_engine__on_lock_radio) <= 92, "блок calib_engine__on_lock_radio не влезает в отведённые ему 92 байт")
  .text.radio_manager__lock_secondary 0x008d9314 : { KEEP(*(.text.radio_manager__lock_secondary)) }
  ASSERT(SIZEOF(.text.radio_manager__lock_secondary) <= 120, "блок radio_manager__lock_secondary не влезает в отведённые ему 120 байт")
  .text.RADIO_MGR__lock_secondary 0x008d938c : { KEEP(*(.text.RADIO_MGR__lock_secondary)) }
  ASSERT(SIZEOF(.text.RADIO_MGR__lock_secondary) <= 64, "блок RADIO_MGR__lock_secondary не влезает в отведённые ему 64 байт")
  .text.frag_8d93cc 0x008d93cc : { KEEP(*(.text.frag_8d93cc)) }
  ASSERT(SIZEOF(.text.frag_8d93cc) <= 60, "блок frag_8d93cc не влезает в отведённые ему 60 байт")
  .text.fwq_tx__long_retry_handler 0x008d9408 : { KEEP(*(.text.fwq_tx__long_retry_handler)) }
  ASSERT(SIZEOF(.text.fwq_tx__long_retry_handler) <= 100, "блок fwq_tx__long_retry_handler не влезает в отведённые ему 100 байт")
  .text.rs__need_long_term 0x008d946c : { KEEP(*(.text.rs__need_long_term)) }
  ASSERT(SIZEOF(.text.rs__need_long_term) <= 64, "блок rs__need_long_term не влезает в отведённые ему 64 байт")
  .text.frag_8d94ac 0x008d94ac : { KEEP(*(.text.frag_8d94ac)) }
  ASSERT(SIZEOF(.text.frag_8d94ac) <= 4, "блок frag_8d94ac не влезает в отведённые ему 4 байт")
  .text.wmi_handler_beamforming_mgmt 0x008d94b0 : { KEEP(*(.text.wmi_handler_beamforming_mgmt)) }
  ASSERT(SIZEOF(.text.wmi_handler_beamforming_mgmt) <= 140, "блок wmi_handler_beamforming_mgmt не влезает в отведённые ему 140 байт")
  .text.host_if__bf_ctrl_hal 0x008d953c : { KEEP(*(.text.host_if__bf_ctrl_hal)) }
  ASSERT(SIZEOF(.text.host_if__bf_ctrl_hal) <= 60, "блок host_if__bf_ctrl_hal не влезает в отведённые ему 60 байт")
  .text.wmi_handler_fw_ver 0x008d9578 : { KEEP(*(.text.wmi_handler_fw_ver)) }
  ASSERT(SIZEOF(.text.wmi_handler_fw_ver) <= 260, "блок wmi_handler_fw_ver не влезает в отведённые ему 260 байт")
  .text.host_if__timestamp_sync 0x008d967c : { KEEP(*(.text.host_if__timestamp_sync)) }
  ASSERT(SIZEOF(.text.host_if__timestamp_sync) <= 156, "блок host_if__timestamp_sync не влезает в отведённые ему 156 байт")
  .text.wmi_handler_rs_cfg 0x008d9718 : { KEEP(*(.text.wmi_handler_rs_cfg)) }
  ASSERT(SIZEOF(.text.wmi_handler_rs_cfg) <= 144, "блок wmi_handler_rs_cfg не влезает в отведённые ему 144 байт")
  .text.rs_cfg__validate 0x008d97a8 : { KEEP(*(.text.rs_cfg__validate)) }
  ASSERT(SIZEOF(.text.rs_cfg__validate) <= 188, "блок rs_cfg__validate не влезает в отведённые ему 188 байт")
  .text.host_if__set_sectors_hal 0x008d9864 : { KEEP(*(.text.host_if__set_sectors_hal)) }
  ASSERT(SIZEOF(.text.host_if__set_sectors_hal) <= 148, "блок host_if__set_sectors_hal не влезает в отведённые ему 148 байт")
  .text.link_stats__collect 0x008d98f8 : { KEEP(*(.text.link_stats__collect)) }
  ASSERT(SIZEOF(.text.link_stats__collect) <= 232, "блок link_stats__collect не влезает в отведённые ему 232 байт")
  .text.cnt_handler__clear_all 0x008d99e0 : { KEEP(*(.text.cnt_handler__clear_all)) }
  ASSERT(SIZEOF(.text.cnt_handler__clear_all) <= 232, "блок cnt_handler__clear_all не влезает в отведённые ему 232 байт")
  .text.get_p8003b4_48 0x008d9ac8 : { KEEP(*(.text.get_p8003b4_48)) }
  ASSERT(SIZEOF(.text.get_p8003b4_48) <= 8, "блок get_p8003b4_48 не влезает в отведённые ему 8 байт")
  .text.get_p8003b4_50 0x008d9ad0 : { KEEP(*(.text.get_p8003b4_50)) }
  ASSERT(SIZEOF(.text.get_p8003b4_50) <= 8, "блок get_p8003b4_50 не влезает в отведённые ему 8 байт")
  .text.sm_pring__free_slots 0x008d9ad8 : { KEEP(*(.text.sm_pring__free_slots)) }
  ASSERT(SIZEOF(.text.sm_pring__free_slots) <= 20, "блок sm_pring__free_slots не влезает в отведённые ему 20 байт")
  .text.get_p8003b0_10 0x008d9aec : { KEEP(*(.text.get_p8003b0_10)) }
  ASSERT(SIZEOF(.text.get_p8003b0_10) <= 8, "блок get_p8003b0_10 не влезает в отведённые ему 8 байт")
  .text.get_p8003b0_48 0x008d9af4 : { KEEP(*(.text.get_p8003b0_48)) }
  ASSERT(SIZEOF(.text.get_p8003b0_48) <= 8, "блок get_p8003b0_48 не влезает в отведённые ему 8 байт")
  .text.sm_pring__used_slots 0x008d9afc : { KEEP(*(.text.sm_pring__used_slots)) }
  ASSERT(SIZEOF(.text.sm_pring__used_slots) <= 12, "блок sm_pring__used_slots не влезает в отведённые ему 12 байт")
  .text.get_g_8003b0 0x008d9b08 : { KEEP(*(.text.get_g_8003b0)) }
  ASSERT(SIZEOF(.text.get_g_8003b0) <= 12, "блок get_g_8003b0 не влезает в отведённые ему 12 байт")
  .text.get_g_8003b4 0x008d9b14 : { KEEP(*(.text.get_g_8003b4)) }
  ASSERT(SIZEOF(.text.get_g_8003b4) <= 8, "блок get_g_8003b4 не влезает в отведённые ему 8 байт")
  .text.get_p8003b0_04 0x008d9b1c : { KEEP(*(.text.get_p8003b0_04)) }
  ASSERT(SIZEOF(.text.get_p8003b0_04) <= 8, "блок get_p8003b0_04 не влезает в отведённые ему 8 байт")
  .text.get_p8003b0_08 0x008d9b24 : { KEEP(*(.text.get_p8003b0_08)) }
  ASSERT(SIZEOF(.text.get_p8003b0_08) <= 8, "блок get_p8003b0_08 не влезает в отведённые ему 8 байт")
  .text.get_reg_887014 0x008d9b2c : { KEEP(*(.text.get_reg_887014)) }
  ASSERT(SIZEOF(.text.get_reg_887014) <= 12, "блок get_reg_887014 не влезает в отведённые ему 12 байт")
  .text.get_reg_887030 0x008d9b38 : { KEEP(*(.text.get_reg_887030)) }
  ASSERT(SIZEOF(.text.get_reg_887030) <= 12, "блок get_reg_887030 не влезает в отведённые ему 12 байт")
  .text.mac_bringup__phy_init 0x008d9b44 : { KEEP(*(.text.mac_bringup__phy_init)) }
  ASSERT(SIZEOF(.text.mac_bringup__phy_init) <= 20, "блок mac_bringup__phy_init не влезает в отведённые ему 20 байт")
  .text.vring_schd__flush_response 0x008d9b58 : { KEEP(*(.text.vring_schd__flush_response)) }
  ASSERT(SIZEOF(.text.vring_schd__flush_response) <= 80, "блок vring_schd__flush_response не влезает в отведённые ему 80 байт")
  .text.mailbox_debug_dump 0x008d9ba8 : { KEEP(*(.text.mailbox_debug_dump)) }
  ASSERT(SIZEOF(.text.mailbox_debug_dump) <= 100, "блок mailbox_debug_dump не влезает в отведённые ему 100 байт")
  .text.radio_mgr__free_handle 0x008d9c0c : { KEEP(*(.text.radio_mgr__free_handle)) }
  ASSERT(SIZEOF(.text.radio_mgr__free_handle) <= 12, "блок radio_mgr__free_handle не влезает в отведённые ему 12 байт")
  .text.lm_if__on_aid_assigned 0x008d9c18 : { KEEP(*(.text.lm_if__on_aid_assigned)) }
  ASSERT(SIZEOF(.text.lm_if__on_aid_assigned) <= 72, "блок lm_if__on_aid_assigned не влезает в отведённые ему 72 байт")
  .text.lm_main_sm__on_maintain_started 0x008d9c60 : { KEEP(*(.text.lm_main_sm__on_maintain_started)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_maintain_started) <= 72, "блок lm_main_sm__on_maintain_started не влезает в отведённые ему 72 байт")
  .text.mbox__notify_sm 0x008d9ca8 : { KEEP(*(.text.mbox__notify_sm)) }
  ASSERT(SIZEOF(.text.mbox__notify_sm) <= 20, "блок mbox__notify_sm не влезает в отведённые ему 20 байт")
  .text.tail_mbox__notify_sm 0x008d9cbc : { KEEP(*(.text.tail_mbox__notify_sm)) }
  ASSERT(SIZEOF(.text.tail_mbox__notify_sm) <= 8, "блок tail_mbox__notify_sm не влезает в отведённые ему 8 байт")
  .text.map_tx_sectors 0x008d9cc4 : { KEEP(*(.text.map_tx_sectors)) }
  ASSERT(SIZEOF(.text.map_tx_sectors) <= 216, "блок map_tx_sectors не влезает в отведённые ему 216 байт")
  .text.rm_main_sm__mark_as_pending_removal 0x008d9d9c : { KEEP(*(.text.rm_main_sm__mark_as_pending_removal)) }
  ASSERT(SIZEOF(.text.rm_main_sm__mark_as_pending_removal) <= 80, "блок rm_main_sm__mark_as_pending_removal не влезает в отведённые ему 80 байт")
  .text.sta_psc_sm__max_retry_handler 0x008d9dec : { KEEP(*(.text.sta_psc_sm__max_retry_handler)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__max_retry_handler) <= 32, "блок sta_psc_sm__max_retry_handler не влезает в отведённые ему 32 байт")
  .text.link_stats__mcs_to_rate_mbps 0x008d9e0c : { KEEP(*(.text.link_stats__mcs_to_rate_mbps)) }
  ASSERT(SIZEOF(.text.link_stats__mcs_to_rate_mbps) <= 120, "блок link_stats__mcs_to_rate_mbps не влезает в отведённые ему 120 байт")
  .text.temp_sense__get_cached 0x008d9e84 : { KEEP(*(.text.temp_sense__get_cached)) }
  ASSERT(SIZEOF(.text.temp_sense__get_cached) <= 76, "блок temp_sense__get_cached не влезает в отведённые ему 76 байт")
  .text.measure_rssi_using_histogram 0x008d9ed0 : { KEEP(*(.text.measure_rssi_using_histogram)) }
  ASSERT(SIZEOF(.text.measure_rssi_using_histogram) <= 296, "блок measure_rssi_using_histogram не влезает в отведённые ему 296 байт")
  .text.str__eq_n 0x008d9ff8 : { KEEP(*(.text.str__eq_n)) }
  ASSERT(SIZEOF(.text.str__eq_n) <= 28, "блок str__eq_n не влезает в отведённые ему 28 байт")
  .text.memcmp_fw 0x008da014 : { KEEP(*(.text.memcmp_fw)) }
  ASSERT(SIZEOF(.text.memcmp_fw) <= 56, "блок memcmp_fw не влезает в отведённые ему 56 байт")
  .text.memset_fw 0x008da04c : { KEEP(*(.text.memset_fw)) }
  ASSERT(SIZEOF(.text.memset_fw) <= 76, "блок memset_fw не влезает в отведённые ему 76 байт")
  .text.ies_block__merge 0x008da098 : { KEEP(*(.text.ies_block__merge)) }
  ASSERT(SIZEOF(.text.ies_block__merge) <= 344, "блок ies_block__merge не влезает в отведённые ему 344 байт")
  .text.rx_mgmt_prs__parse_dmg_bcon_fixed 0x008da1f0 : { KEEP(*(.text.rx_mgmt_prs__parse_dmg_bcon_fixed)) }
  ASSERT(SIZEOF(.text.rx_mgmt_prs__parse_dmg_bcon_fixed) <= 148, "блок rx_mgmt_prs__parse_dmg_bcon_fixed не влезает в отведённые ему 148 байт")
  .text.rx_mgmt_prs__parse 0x008da284 : { KEEP(*(.text.rx_mgmt_prs__parse)) }
  ASSERT(SIZEOF(.text.rx_mgmt_prs__parse) <= 452, "блок rx_mgmt_prs__parse не влезает в отведённые ему 452 байт")
  .text.bit_reverse32 0x008da448 : { KEEP(*(.text.bit_reverse32)) }
  ASSERT(SIZEOF(.text.bit_reverse32) <= 24, "блок bit_reverse32 не влезает в отведённые ему 24 байт")
  .text.conn_msm__inject_ntf_assoc_done 0x008da460 : { KEEP(*(.text.conn_msm__inject_ntf_assoc_done)) }
  ASSERT(SIZEOF(.text.conn_msm__inject_ntf_assoc_done) <= 32, "блок conn_msm__inject_ntf_assoc_done не влезает в отведённые ему 32 байт")
  .text.mlme__inject_evt4 0x008da480 : { KEEP(*(.text.mlme__inject_evt4)) }
  ASSERT(SIZEOF(.text.mlme__inject_evt4) <= 16, "блок mlme__inject_evt4 не влезает в отведённые ему 16 байт")
  .text.mlme_notify 0x008da490 : { KEEP(*(.text.mlme_notify)) }
  ASSERT(SIZEOF(.text.mlme_notify) <= 188, "блок mlme_notify не влезает в отведённые ему 188 байт")
  .text.host_if__wmi_cmd_dispatch 0x008da54c : { KEEP(*(.text.host_if__wmi_cmd_dispatch)) }
  ASSERT(SIZEOF(.text.host_if__wmi_cmd_dispatch) <= 2356, "блок host_if__wmi_cmd_dispatch не влезает в отведённые ему 2356 байт")
  .text.lmac_if__ucode_event_dispatch 0x008dae80 : { KEEP(*(.text.lmac_if__ucode_event_dispatch)) }
  ASSERT(SIZEOF(.text.lmac_if__ucode_event_dispatch) <= 732, "блок lmac_if__ucode_event_dispatch не влезает в отведённые ему 732 байт")
  .text.epi_8db15c 0x008db15c : { KEEP(*(.text.epi_8db15c)) }
  ASSERT(SIZEOF(.text.epi_8db15c) <= 4, "блок epi_8db15c не влезает в отведённые ему 4 байт")
  .text.ie_iter__next 0x008db160 : { KEEP(*(.text.ie_iter__next)) }
  ASSERT(SIZEOF(.text.ie_iter__next) <= 40, "блок ie_iter__next не влезает в отведённые ему 40 байт")
  .text.iter__next 0x008db188 : { KEEP(*(.text.iter__next)) }
  ASSERT(SIZEOF(.text.iter__next) <= 12, "блок iter__next не влезает в отведённые ему 12 байт")
  .text.bitmap__alloc_bit 0x008db194 : { KEEP(*(.text.bitmap__alloc_bit)) }
  ASSERT(SIZEOF(.text.bitmap__alloc_bit) <= 48, "блок bitmap__alloc_bit не влезает в отведённые ему 48 байт")
  .text.ie__next_element 0x008db1c4 : { KEEP(*(.text.ie__next_element)) }
  ASSERT(SIZEOF(.text.ie__next_element) <= 40, "блок ie__next_element не влезает в отведённые ему 40 байт")
  .text.ring__is_full_8db1ec 0x008db1ec : { KEEP(*(.text.ring__is_full_8db1ec)) }
  ASSERT(SIZEOF(.text.ring__is_full_8db1ec) <= 16, "блок ring__is_full_8db1ec не влезает в отведённые ему 16 байт")
  .text.notify_conn_flush_done 0x008db1fc : { KEEP(*(.text.notify_conn_flush_done)) }
  ASSERT(SIZEOF(.text.notify_conn_flush_done) <= 68, "блок notify_conn_flush_done не влезает в отведённые ему 68 байт")
  .text.fwq_tx__on_queue_empty 0x008db240 : { KEEP(*(.text.fwq_tx__on_queue_empty)) }
  ASSERT(SIZEOF(.text.fwq_tx__on_queue_empty) <= 16, "блок fwq_tx__on_queue_empty не влезает в отведённые ему 16 байт")
  .text.sm__null_handler 0x008db250 : { KEEP(*(.text.sm__null_handler)) }
  ASSERT(SIZEOF(.text.sm__null_handler) <= 16, "блок sm__null_handler не влезает в отведённые ему 16 байт")
  .text.stub_ret_8db260 0x008db260 : { KEEP(*(.text.stub_ret_8db260)) }
  ASSERT(SIZEOF(.text.stub_ret_8db260) <= 4, "блок stub_ret_8db260 не влезает в отведённые ему 4 байт")
  .text.stub_ret_8db264 0x008db264 : { KEEP(*(.text.stub_ret_8db264)) }
  ASSERT(SIZEOF(.text.stub_ret_8db264) <= 4, "блок stub_ret_8db264 не влезает в отведённые ему 4 байт")
  .text.tsf_is_before 0x008db268 : { KEEP(*(.text.tsf_is_before)) }
  ASSERT(SIZEOF(.text.tsf_is_before) <= 16, "блок tsf_is_before не влезает в отведённые ему 16 байт")
  .text.set_reg_881b00 0x008db278 : { KEEP(*(.text.set_reg_881b00)) }
  ASSERT(SIZEOF(.text.set_reg_881b00) <= 24, "блок set_reg_881b00 не влезает в отведённые ему 24 байт")
  .text.dma_offload__pack_decap_cfg 0x008db290 : { KEEP(*(.text.dma_offload__pack_decap_cfg)) }
  ASSERT(SIZEOF(.text.dma_offload__pack_decap_cfg) <= 48, "блок dma_offload__pack_decap_cfg не влезает в отведённые ему 48 байт")
  .text.dma_offload__set_rx_decap 0x008db2c0 : { KEEP(*(.text.dma_offload__set_rx_decap)) }
  ASSERT(SIZEOF(.text.dma_offload__set_rx_decap) <= 88, "блок dma_offload__set_rx_decap не влезает в отведённые ему 88 байт")
  .text.set_reg_881b30 0x008db318 : { KEEP(*(.text.set_reg_881b30)) }
  ASSERT(SIZEOF(.text.set_reg_881b30) <= 12, "блок set_reg_881b30 не влезает в отведённые ему 12 байт")
  .text.rgf_reg_881b00_8db324 0x008db324 : { KEEP(*(.text.rgf_reg_881b00_8db324)) }
  ASSERT(SIZEOF(.text.rgf_reg_881b00_8db324) <= 16, "блок rgf_reg_881b00_8db324 не влезает в отведённые ему 16 байт")
  .text.rgf_reg_881b00_8db334 0x008db334 : { KEEP(*(.text.rgf_reg_881b00_8db334)) }
  ASSERT(SIZEOF(.text.rgf_reg_881b00_8db334) <= 12, "блок rgf_reg_881b00_8db334 не влезает в отведённые ему 12 байт")
  .text.frag_8db340 0x008db340 : { KEEP(*(.text.frag_8db340)) }
  ASSERT(SIZEOF(.text.frag_8db340) <= 4, "блок frag_8db340 не влезает в отведённые ему 4 байт")
  .text.rf_sector__read_on_radio_locked 0x008db344 : { KEEP(*(.text.rf_sector__read_on_radio_locked)) }
  ASSERT(SIZEOF(.text.rf_sector__read_on_radio_locked) <= 28, "блок rf_sector__read_on_radio_locked не влезает в отведённые ему 28 байт")
  .text.frag_8db360 0x008db360 : { KEEP(*(.text.frag_8db360)) }
  ASSERT(SIZEOF(.text.frag_8db360) <= 4, "блок frag_8db360 не влезает в отведённые ему 4 байт")
  .text.rf_sector__apply_on_radio_locked 0x008db364 : { KEEP(*(.text.rf_sector__apply_on_radio_locked)) }
  ASSERT(SIZEOF(.text.rf_sector__apply_on_radio_locked) <= 32, "блок rf_sector__apply_on_radio_locked не влезает в отведённые ему 32 байт")
  .text.lm_main_sm__on_bf_results__lm_state_configured 0x008db384 : { KEEP(*(.text.lm_main_sm__on_bf_results__lm_state_configured)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_bf_results__lm_state_configured) <= 16, "блок lm_main_sm__on_bf_results__lm_state_configured не влезает в отведённые ему 16 байт")
  .text.SW_TX_MGMT_API__packet_release 0x008db394 : { KEEP(*(.text.SW_TX_MGMT_API__packet_release)) }
  ASSERT(SIZEOF(.text.SW_TX_MGMT_API__packet_release) <= 56, "блок SW_TX_MGMT_API__packet_release не влезает в отведённые ему 56 байт")
  .text.parse_ese 0x008db3cc : { KEEP(*(.text.parse_ese)) }
  ASSERT(SIZEOF(.text.parse_ese) <= 484, "блок parse_ese не влезает в отведённые ему 484 байт")
  .text.epi_8db5b0 0x008db5b0 : { KEEP(*(.text.epi_8db5b0)) }
  ASSERT(SIZEOF(.text.epi_8db5b0) <= 4, "блок epi_8db5b0 не влезает в отведённые ему 4 байт")
  .text.dti__parse_ese_at692 0x008db5b4 : { KEEP(*(.text.dti__parse_ese_at692)) }
  ASSERT(SIZEOF(.text.dti__parse_ese_at692) <= 8, "блок dti__parse_ese_at692 не влезает в отведённые ему 8 байт")
  .text.mac_parser__pack_rule_halfword 0x008db5bc : { KEEP(*(.text.mac_parser__pack_rule_halfword)) }
  ASSERT(SIZEOF(.text.mac_parser__pack_rule_halfword) <= 96, "блок mac_parser__pack_rule_halfword не влезает в отведённые ему 96 байт")
  .text.mac_parser__write_rule_slot 0x008db61c : { KEEP(*(.text.mac_parser__write_rule_slot)) }
  ASSERT(SIZEOF(.text.mac_parser__write_rule_slot) <= 124, "блок mac_parser__write_rule_slot не влезает в отведённые ему 124 байт")
  .text.mac_parser__init 0x008db698 : { KEEP(*(.text.mac_parser__init)) }
  ASSERT(SIZEOF(.text.mac_parser__init) <= 52, "блок mac_parser__init не влезает в отведённые ему 52 байт")
  .text.parse_wilocity_vs__find_tlv 0x008db6cc : { KEEP(*(.text.parse_wilocity_vs__find_tlv)) }
  ASSERT(SIZEOF(.text.parse_wilocity_vs__find_tlv) <= 60, "блок parse_wilocity_vs__find_tlv не влезает в отведённые ему 60 байт")
  .text.parse_wilocity_vs_get_netowork_mode 0x008db708 : { KEEP(*(.text.parse_wilocity_vs_get_netowork_mode)) }
  ASSERT(SIZEOF(.text.parse_wilocity_vs_get_netowork_mode) <= 64, "блок parse_wilocity_vs_get_netowork_mode не влезает в отведённые ему 64 байт")
  .text.mlme__parse_wilocity_vs 0x008db748 : { KEEP(*(.text.mlme__parse_wilocity_vs)) }
  ASSERT(SIZEOF(.text.mlme__parse_wilocity_vs) <= 40, "блок mlme__parse_wilocity_vs не влезает в отведённые ему 40 байт")
  .text.parse_wilocity_vs_get_test_mode 0x008db770 : { KEEP(*(.text.parse_wilocity_vs_get_test_mode)) }
  ASSERT(SIZEOF(.text.parse_wilocity_vs_get_test_mode) <= 76, "блок parse_wilocity_vs_get_test_mode не влезает в отведённые ему 76 байт")
  .text.parse_wilocity_vs_get_version 0x008db7bc : { KEEP(*(.text.parse_wilocity_vs_get_version)) }
  ASSERT(SIZEOF(.text.parse_wilocity_vs_get_version) <= 36, "блок parse_wilocity_vs_get_version не влезает в отведённые ему 36 байт")
  .text.parse_wilocity_vs__get_flag3 0x008db7e0 : { KEEP(*(.text.parse_wilocity_vs__get_flag3)) }
  ASSERT(SIZEOF(.text.parse_wilocity_vs__get_flag3) <= 28, "блок parse_wilocity_vs__get_flag3 не влезает в отведённые ему 28 байт")
  .text.rx_queue__setup_ring 0x008db7fc : { KEEP(*(.text.rx_queue__setup_ring)) }
  ASSERT(SIZEOF(.text.rx_queue__setup_ring) <= 92, "блок rx_queue__setup_ring не влезает в отведённые ему 92 байт")
  .text.mac_parser__build_mac_rule 0x008db858 : { KEEP(*(.text.mac_parser__build_mac_rule)) }
  ASSERT(SIZEOF(.text.mac_parser__build_mac_rule) <= 64, "блок mac_parser__build_mac_rule не влезает в отведённые ему 64 байт")
  .text.mac_parser__set_ba_rule 0x008db898 : { KEEP(*(.text.mac_parser__set_ba_rule)) }
  ASSERT(SIZEOF(.text.mac_parser__set_ba_rule) <= 80, "блок mac_parser__set_ba_rule не влезает в отведённые ему 80 байт")
  .text.hwd_mac_parser__build_desc 0x008db8e8 : { KEEP(*(.text.hwd_mac_parser__build_desc)) }
  ASSERT(SIZEOF(.text.hwd_mac_parser__build_desc) <= 252, "блок hwd_mac_parser__build_desc не влезает в отведённые ему 252 байт")
  .text.mac_parser__build_wildcard_rule 0x008db9e4 : { KEEP(*(.text.mac_parser__build_wildcard_rule)) }
  ASSERT(SIZEOF(.text.mac_parser__build_wildcard_rule) <= 52, "блок mac_parser__build_wildcard_rule не влезает в отведённые ему 52 байт")
  .text.mac_parser__clear_rule 0x008dba18 : { KEEP(*(.text.mac_parser__clear_rule)) }
  ASSERT(SIZEOF(.text.mac_parser__clear_rule) <= 76, "блок mac_parser__clear_rule не влезает в отведённые ему 76 байт")
  .text.mac_parser__rule_a 0x008dba64 : { KEEP(*(.text.mac_parser__rule_a)) }
  ASSERT(SIZEOF(.text.mac_parser__rule_a) <= 44, "блок mac_parser__rule_a не влезает в отведённые ему 44 байт")
  .text.mac_parser__set_886000_8dba90 0x008dba90 : { KEEP(*(.text.mac_parser__set_886000_8dba90)) }
  ASSERT(SIZEOF(.text.mac_parser__set_886000_8dba90) <= 28, "блок mac_parser__set_886000_8dba90 не влезает в отведённые ему 28 байт")
  .text.mac_parser__set_886000_8dbaac 0x008dbaac : { KEEP(*(.text.mac_parser__set_886000_8dbaac)) }
  ASSERT(SIZEOF(.text.mac_parser__set_886000_8dbaac) <= 28, "блок mac_parser__set_886000_8dbaac не влезает в отведённые ему 28 байт")
  .text.mac_parser__set_886200 0x008dbac8 : { KEEP(*(.text.mac_parser__set_886200)) }
  ASSERT(SIZEOF(.text.mac_parser__set_886200) <= 28, "блок mac_parser__set_886200 не влезает в отведённые ему 28 байт")
  .text.mac_parser__set_886260 0x008dbae4 : { KEEP(*(.text.mac_parser__set_886260)) }
  ASSERT(SIZEOF(.text.mac_parser__set_886260) <= 12, "блок mac_parser__set_886260 не влезает в отведённые ему 12 байт")
  .text.set_reg_886288 0x008dbaf0 : { KEEP(*(.text.set_reg_886288)) }
  ASSERT(SIZEOF(.text.set_reg_886288) <= 16, "блок set_reg_886288 не влезает в отведённые ему 16 байт")
  .text.mac_parser__write_rule 0x008dbb00 : { KEEP(*(.text.mac_parser__write_rule)) }
  ASSERT(SIZEOF(.text.mac_parser__write_rule) <= 92, "блок mac_parser__write_rule не влезает в отведённые ему 92 байт")
  .text.stream_mgr__install_ba_rule 0x008dbb5c : { KEEP(*(.text.stream_mgr__install_ba_rule)) }
  ASSERT(SIZEOF(.text.stream_mgr__install_ba_rule) <= 36, "блок stream_mgr__install_ba_rule не влезает в отведённые ему 36 байт")
  .text.mac_parser__install_default_rules 0x008dbb80 : { KEEP(*(.text.mac_parser__install_default_rules)) }
  ASSERT(SIZEOF(.text.mac_parser__install_default_rules) <= 188, "блок mac_parser__install_default_rules не влезает в отведённые ему 188 байт")
  .text.hwd_mac_parser__set_rx_filter 0x008dbc3c : { KEEP(*(.text.hwd_mac_parser__set_rx_filter)) }
  ASSERT(SIZEOF(.text.hwd_mac_parser__set_rx_filter) <= 216, "блок hwd_mac_parser__set_rx_filter не влезает в отведённые ему 216 байт")
  .text.mac_parser__rule_b 0x008dbd14 : { KEEP(*(.text.mac_parser__rule_b)) }
  ASSERT(SIZEOF(.text.mac_parser__rule_b) <= 48, "блок mac_parser__rule_b не влезает в отведённые ему 48 байт")
  .text.mac_parser_step_b 0x008dbd44 : { KEEP(*(.text.mac_parser_step_b)) }
  ASSERT(SIZEOF(.text.mac_parser_step_b) <= 208, "блок mac_parser_step_b не влезает в отведённые ему 208 байт")
  .text.mac_parser_step_a 0x008dbe14 : { KEEP(*(.text.mac_parser_step_a)) }
  ASSERT(SIZEOF(.text.mac_parser_step_a) <= 212, "блок mac_parser_step_a не влезает в отведённые ему 212 байт")
  .text.lm_if__deliver_bf_results 0x008dbee8 : { KEEP(*(.text.lm_if__deliver_bf_results)) }
  ASSERT(SIZEOF(.text.lm_if__deliver_bf_results) <= 44, "блок lm_if__deliver_bf_results не влезает в отведённые ему 44 байт")
  .text.rs__inject_evt2 0x008dbf14 : { KEEP(*(.text.rs__inject_evt2)) }
  ASSERT(SIZEOF(.text.rs__inject_evt2) <= 12, "блок rs__inject_evt2 не влезает в отведённые ему 12 байт")
  .text.frag_8dbf20 0x008dbf20 : { KEEP(*(.text.frag_8dbf20)) }
  ASSERT(SIZEOF(.text.frag_8dbf20) <= 4, "блок frag_8dbf20 не влезает в отведённые ему 4 байт")
  .text.lm_main_sm__on_pause 0x008dbf24 : { KEEP(*(.text.lm_main_sm__on_pause)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_pause) <= 12, "блок lm_main_sm__on_pause не влезает в отведённые ему 12 байт")
  .text.frag_8dbf30 0x008dbf30 : { KEEP(*(.text.frag_8dbf30)) }
  ASSERT(SIZEOF(.text.frag_8dbf30) <= 4, "блок frag_8dbf30 не влезает в отведённые ему 4 байт")
  .text.link_stats_sm__on_pause 0x008dbf34 : { KEEP(*(.text.link_stats_sm__on_pause)) }
  ASSERT(SIZEOF(.text.link_stats_sm__on_pause) <= 48, "блок link_stats_sm__on_pause не влезает в отведённые ему 48 байт")
  .text.frag_8dbf64 0x008dbf64 : { KEEP(*(.text.frag_8dbf64)) }
  ASSERT(SIZEOF(.text.frag_8dbf64) <= 4, "блок frag_8dbf64 не влезает в отведённые ему 4 байт")
  .text.conn__arm_detectors 0x008dbf68 : { KEEP(*(.text.conn__arm_detectors)) }
  ASSERT(SIZEOF(.text.conn__arm_detectors) <= 40, "блок conn__arm_detectors не влезает в отведённые ему 40 байт")
  .text.conn_mgr__foreach_active_link 0x008dbf90 : { KEEP(*(.text.conn_mgr__foreach_active_link)) }
  ASSERT(SIZEOF(.text.conn_mgr__foreach_active_link) <= 68, "блок conn_mgr__foreach_active_link не влезает в отведённые ему 68 байт")
  .text.ka_detector__arm 0x008dbfd4 : { KEEP(*(.text.ka_detector__arm)) }
  ASSERT(SIZEOF(.text.ka_detector__arm) <= 28, "блок ka_detector__arm не влезает в отведённые ему 28 байт")
  .text.ageing_detector__arm 0x008dbff0 : { KEEP(*(.text.ageing_detector__arm)) }
  ASSERT(SIZEOF(.text.ageing_detector__arm) <= 24, "блок ageing_detector__arm не влезает в отведённые ему 24 байт")
  .text.lm_if__inject_evt9 0x008dc008 : { KEEP(*(.text.lm_if__inject_evt9)) }
  ASSERT(SIZEOF(.text.lm_if__inject_evt9) <= 52, "блок lm_if__inject_evt9 не влезает в отведённые ему 52 байт")
  .text.mid__add_connection 0x008dc03c : { KEEP(*(.text.mid__add_connection)) }
  ASSERT(SIZEOF(.text.mid__add_connection) <= 100, "блок mid__add_connection не влезает в отведённые ему 100 байт")
  .text.pbss__add_sta 0x008dc0a0 : { KEEP(*(.text.pbss__add_sta)) }
  ASSERT(SIZEOF(.text.pbss__add_sta) <= 84, "блок pbss__add_sta не влезает в отведённые ему 84 байт")
  .text.pbss__del_sta 0x008dc0f4 : { KEEP(*(.text.pbss__del_sta)) }
  ASSERT(SIZEOF(.text.pbss__del_sta) <= 156, "блок pbss__del_sta не влезает в отведённые ему 156 байт")
  .text.stats_timer_exp 0x008dc190 : { KEEP(*(.text.stats_timer_exp)) }
  ASSERT(SIZEOF(.text.stats_timer_exp) <= 212, "блок stats_timer_exp не влезает в отведённые ему 212 байт")
  .text.pcie__pm_host_config 0x008dc264 : { KEEP(*(.text.pcie__pm_host_config)) }
  ASSERT(SIZEOF(.text.pcie__pm_host_config) <= 320, "блок pcie__pm_host_config не влезает в отведённые ему 320 байт")
  .text.pcie_device_power_if__pcie_power_pcie_interrupt 0x008dc3a4 : { KEEP(*(.text.pcie_device_power_if__pcie_power_pcie_interrupt)) }
  ASSERT(SIZEOF(.text.pcie_device_power_if__pcie_power_pcie_interrupt) <= 128, "блок pcie_device_power_if__pcie_power_pcie_interrupt не влезает в отведённые ему 128 байт")
  .text.set_g_800241 0x008dc424 : { KEEP(*(.text.set_g_800241)) }
  ASSERT(SIZEOF(.text.set_g_800241) <= 12, "блок set_g_800241 не влезает в отведённые ему 12 байт")
  .text.l2mgr__send_traffic_deferral_evt 0x008dc430 : { KEEP(*(.text.l2mgr__send_traffic_deferral_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_traffic_deferral_evt) <= 100, "блок l2mgr__send_traffic_deferral_evt не влезает в отведённые ему 100 байт")
  .text.l2mgr__send_traffic_resume_evt 0x008dc494 : { KEEP(*(.text.l2mgr__send_traffic_resume_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_traffic_resume_evt) <= 88, "блок l2mgr__send_traffic_resume_evt не влезает в отведённые ему 88 байт")
  .text.pcie_device_power_if__pcie_power_wake_signal 0x008dc4ec : { KEEP(*(.text.pcie_device_power_if__pcie_power_wake_signal)) }
  ASSERT(SIZEOF(.text.pcie_device_power_if__pcie_power_wake_signal) <= 56, "блок pcie_device_power_if__pcie_power_wake_signal не влезает в отведённые ему 56 байт")
  .text.pcie_device_power_sm__pcie_traffic_resume_req 0x008dc524 : { KEEP(*(.text.pcie_device_power_sm__pcie_traffic_resume_req)) }
  ASSERT(SIZEOF(.text.pcie_device_power_sm__pcie_traffic_resume_req) <= 32, "блок pcie_device_power_sm__pcie_traffic_resume_req не влезает в отведённые ему 32 байт")
  .text.l2_mgr__pcp_start_flow 0x008dc544 : { KEEP(*(.text.l2_mgr__pcp_start_flow)) }
  ASSERT(SIZEOF(.text.l2_mgr__pcp_start_flow) <= 284, "блок l2_mgr__pcp_start_flow не влезает в отведённые ему 284 байт")
  .text.pcp_stop__flow 0x008dc660 : { KEEP(*(.text.pcp_stop__flow)) }
  ASSERT(SIZEOF(.text.pcp_stop__flow) <= 144, "блок pcp_stop__flow не влезает в отведённые ему 144 байт")
  .text.frag_8dc6f0 0x008dc6f0 : { KEEP(*(.text.frag_8dc6f0)) }
  ASSERT(SIZEOF(.text.frag_8dc6f0) <= 4, "блок frag_8dc6f0 не влезает в отведённые ему 4 байт")
  .text.perform_first_measurement_operations 0x008dc6f4 : { KEEP(*(.text.perform_first_measurement_operations)) }
  ASSERT(SIZEOF(.text.perform_first_measurement_operations) <= 104, "блок perform_first_measurement_operations не влезает в отведённые ему 104 байт")
  .text.info_flow__start_periodic 0x008dc75c : { KEEP(*(.text.info_flow__start_periodic)) }
  ASSERT(SIZEOF(.text.info_flow__start_periodic) <= 116, "блок info_flow__start_periodic не влезает в отведённые ему 116 байт")
  .text.l2mgr__send_notify_req_done 0x008dc7d0 : { KEEP(*(.text.l2mgr__send_notify_req_done)) }
  ASSERT(SIZEOF(.text.l2mgr__send_notify_req_done) <= 84, "блок l2mgr__send_notify_req_done не влезает в отведённые ему 84 байт")
  .text.host_if__arm_ts_sync_timer 0x008dc824 : { KEEP(*(.text.host_if__arm_ts_sync_timer)) }
  ASSERT(SIZEOF(.text.host_if__arm_ts_sync_timer) <= 8, "блок host_if__arm_ts_sync_timer не влезает в отведённые ему 8 байт")
  .text.rx_mgmt_prs__alloc_ei 0x008dc82c : { KEEP(*(.text.rx_mgmt_prs__alloc_ei)) }
  ASSERT(SIZEOF(.text.rx_mgmt_prs__alloc_ei) <= 188, "блок rx_mgmt_prs__alloc_ei не влезает в отведённые ему 188 байт")
  .text.tail_llist__is_empty 0x008dc8e8 : { KEEP(*(.text.tail_llist__is_empty)) }
  ASSERT(SIZEOF(.text.tail_llist__is_empty) <= 4, "блок tail_llist__is_empty не влезает в отведённые ему 4 байт")
  .text.u_schd__enqueue_ready 0x008dc8ec : { KEEP(*(.text.u_schd__enqueue_ready)) }
  ASSERT(SIZEOF(.text.u_schd__enqueue_ready) <= 64, "блок u_schd__enqueue_ready не влезает в отведённые ему 64 байт")
  .text.u_schd__schedule 0x008dc92c : { KEEP(*(.text.u_schd__schedule)) }
  ASSERT(SIZEOF(.text.u_schd__schedule) <= 112, "блок u_schd__schedule не влезает в отведённые ему 112 байт")
  .text.u_schd__insert 0x008dc99c : { KEEP(*(.text.u_schd__insert)) }
  ASSERT(SIZEOF(.text.u_schd__insert) <= 124, "блок u_schd__insert не влезает в отведённые ему 124 байт")
  .text.tx_api__post_tx_payload 0x008dca18 : { KEEP(*(.text.tx_api__post_tx_payload)) }
  ASSERT(SIZEOF(.text.tx_api__post_tx_payload) <= 104, "блок tx_api__post_tx_payload не влезает в отведённые ему 104 байт")
  .text.ring__fill_from_pool 0x008dca80 : { KEEP(*(.text.ring__fill_from_pool)) }
  ASSERT(SIZEOF(.text.ring__fill_from_pool) <= 44, "блок ring__fill_from_pool не влезает в отведённые ему 44 байт")
  .text.tail_8dcaac 0x008dcaac : { KEEP(*(.text.tail_8dcaac)) }
  ASSERT(SIZEOF(.text.tail_8dcaac) <= 4, "блок tail_8dcaac не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_start_ba_setup__not_ba_agr_state 0x008dcab0 : { KEEP(*(.text.ba_sm__on_start_ba_setup__not_ba_agr_state)) }
  ASSERT(SIZEOF(.text.ba_sm__on_start_ba_setup__not_ba_agr_state) <= 40, "блок ba_sm__on_start_ba_setup__not_ba_agr_state не влезает в отведённые ему 40 байт")
  .text.ba_sm__prepare_ba_td 0x008dcad8 : { KEEP(*(.text.ba_sm__prepare_ba_td)) }
  ASSERT(SIZEOF(.text.ba_sm__prepare_ba_td) <= 84, "блок ba_sm__prepare_ba_td не влезает в отведённые ему 84 байт")
  .text.frag_8dcb2c 0x008dcb2c : { KEEP(*(.text.frag_8dcb2c)) }
  ASSERT(SIZEOF(.text.frag_8dcb2c) <= 8, "блок frag_8dcb2c не влезает в отведённые ему 8 байт")
  .text.frag_8dcb34 0x008dcb34 : { KEEP(*(.text.frag_8dcb34)) }
  ASSERT(SIZEOF(.text.frag_8dcb34) <= 8, "блок frag_8dcb34 не влезает в отведённые ему 8 байт")
  .text.rm_main_sm__primary_handle_free 0x008dcb3c : { KEEP(*(.text.rm_main_sm__primary_handle_free)) }
  ASSERT(SIZEOF(.text.rm_main_sm__primary_handle_free) <= 96, "блок rm_main_sm__primary_handle_free не влезает в отведённые ему 96 байт")
  .text.radio_manager_main_sm__on_ch_switch_done 0x008dcb9c : { KEEP(*(.text.radio_manager_main_sm__on_ch_switch_done)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_ch_switch_done) <= 28, "блок radio_manager_main_sm__on_ch_switch_done не влезает в отведённые ему 28 байт")
  .text.pring__on_all_wb_done 0x008dcbb8 : { KEEP(*(.text.pring__on_all_wb_done)) }
  ASSERT(SIZEOF(.text.pring__on_all_wb_done) <= 16, "блок pring__on_all_wb_done не влезает в отведённые ему 16 байт")
  .text.pring__on_eop 0x008dcbc8 : { KEEP(*(.text.pring__on_eop)) }
  ASSERT(SIZEOF(.text.pring__on_eop) <= 16, "блок pring__on_eop не влезает в отведённые ему 16 байт")
  .text.pring__on_inactivity 0x008dcbd8 : { KEEP(*(.text.pring__on_inactivity)) }
  ASSERT(SIZEOF(.text.pring__on_inactivity) <= 92, "блок pring__on_inactivity не влезает в отведённые ему 92 байт")
  .text.vring_schdlr__assert_line 0x008dcc34 : { KEEP(*(.text.vring_schdlr__assert_line)) }
  ASSERT(SIZEOF(.text.vring_schdlr__assert_line) <= 24, "блок vring_schdlr__assert_line не влезает в отведённые ему 24 байт")
  .text.frag_8dcc4c 0x008dcc4c : { KEEP(*(.text.frag_8dcc4c)) }
  ASSERT(SIZEOF(.text.frag_8dcc4c) <= 20, "блок frag_8dcc4c не влезает в отведённые ему 20 байт")
  .text.brd_if_multi_array__brd_header_u 0x008dcc60 : { KEEP(*(.text.brd_if_multi_array__brd_header_u)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__brd_header_u) <= 56, "блок brd_if_multi_array__brd_header_u не влезает в отведённые ему 56 байт")
  .text.brd_if_multi_array__physical_section_header_u__print2log 0x008dcc98 : { KEEP(*(.text.brd_if_multi_array__physical_section_header_u__print2log)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__physical_section_header_u__print2log) <= 96, "блок brd_if_multi_array__physical_section_header_u__print2log не влезает в отведённые ему 96 байт")
  .text.brd_if__block_info__print2log 0x008dccf8 : { KEEP(*(.text.brd_if__block_info__print2log)) }
  ASSERT(SIZEOF(.text.brd_if__block_info__print2log) <= 60, "блок brd_if__block_info__print2log не влезает в отведённые ему 60 байт")
  .text.brd_if__section_info__print2log 0x008dcd34 : { KEEP(*(.text.brd_if__section_info__print2log)) }
  ASSERT(SIZEOF(.text.brd_if__section_info__print2log) <= 52, "блок brd_if__section_info__print2log не влезает в отведённые ему 52 байт")
  .text.allocation_type 0x008dcd68 : { KEEP(*(.text.allocation_type)) }
  ASSERT(SIZEOF(.text.allocation_type) <= 112, "блок allocation_type не влезает в отведённые ему 112 байт")
  .text.awake_peers__log 0x008dcdd8 : { KEEP(*(.text.awake_peers__log)) }
  ASSERT(SIZEOF(.text.awake_peers__log) <= 108, "блок awake_peers__log не влезает в отведённые ему 108 байт")
  .text.app_ie__print_ies 0x008dce44 : { KEEP(*(.text.app_ie__print_ies)) }
  ASSERT(SIZEOF(.text.app_ie__print_ies) <= 96, "блок app_ie__print_ies не влезает в отведённые ему 96 байт")
  .text.conn_mgr__print_link_maintain_cfg 0x008dcea4 : { KEEP(*(.text.conn_mgr__print_link_maintain_cfg)) }
  ASSERT(SIZEOF(.text.conn_mgr__print_link_maintain_cfg) <= 84, "блок conn_mgr__print_link_maintain_cfg не влезает в отведённые ему 84 байт")
  .text.ka_detector__log_state 0x008dcef8 : { KEEP(*(.text.ka_detector__log_state)) }
  ASSERT(SIZEOF(.text.ka_detector__log_state) <= 132, "блок ka_detector__log_state не влезает в отведённые ему 132 байт")
  .text.ageing_detector__log_state 0x008dcf7c : { KEEP(*(.text.ageing_detector__log_state)) }
  ASSERT(SIZEOF(.text.ageing_detector__log_state) <= 132, "блок ageing_detector__log_state не влезает в отведённые ему 132 байт")
  .text.list_80182c__insert_sorted 0x008dd000 : { KEEP(*(.text.list_80182c__insert_sorted)) }
  ASSERT(SIZEOF(.text.list_80182c__insert_sorted) <= 64, "блок list_80182c__insert_sorted не влезает в отведённые ему 64 байт")
  .text.discovery__inject_probe_evt 0x008dd040 : { KEEP(*(.text.discovery__inject_probe_evt)) }
  ASSERT(SIZEOF(.text.discovery__inject_probe_evt) <= 20, "блок discovery__inject_probe_evt не влезает в отведённые ему 20 байт")
  .text.lm_main_sm__on_bf_results__lm_state_wait_link 0x008dd054 : { KEEP(*(.text.lm_main_sm__on_bf_results__lm_state_wait_link)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_bf_results__lm_state_wait_link) <= 48, "блок lm_main_sm__on_bf_results__lm_state_wait_link не влезает в отведённые ему 48 байт")
  .text.process_expected_bf_results 0x008dd084 : { KEEP(*(.text.process_expected_bf_results)) }
  ASSERT(SIZEOF(.text.process_expected_bf_results) <= 32, "блок process_expected_bf_results не влезает в отведённые ему 32 байт")
  .text.radio_mgr__inject_evt3 0x008dd0a4 : { KEEP(*(.text.radio_mgr__inject_evt3)) }
  ASSERT(SIZEOF(.text.radio_mgr__inject_evt3) <= 16, "блок radio_mgr__inject_evt3 не влезает в отведённые ему 16 байт")
  .text.vring_schd__prohibit_cids 0x008dd0b4 : { KEEP(*(.text.vring_schd__prohibit_cids)) }
  ASSERT(SIZEOF(.text.vring_schd__prohibit_cids) <= 112, "блок vring_schd__prohibit_cids не влезает в отведённые ему 112 байт")
  .text.rx_macq__bind_all_queues 0x008dd124 : { KEEP(*(.text.rx_macq__bind_all_queues)) }
  ASSERT(SIZEOF(.text.rx_macq__bind_all_queues) <= 84, "блок rx_macq__bind_all_queues не влезает в отведённые ему 84 байт")
  .text.PS_ASSOC_SM__ps_cancel_schd_reenter 0x008dd178 : { KEEP(*(.text.PS_ASSOC_SM__ps_cancel_schd_reenter)) }
  ASSERT(SIZEOF(.text.PS_ASSOC_SM__ps_cancel_schd_reenter) <= 40, "блок PS_ASSOC_SM__ps_cancel_schd_reenter не влезает в отведённые ему 40 байт")
  .text.ps_nonassoc_sm__cancel_timer 0x008dd1a0 : { KEEP(*(.text.ps_nonassoc_sm__cancel_timer)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_sm__cancel_timer) <= 40, "блок ps_nonassoc_sm__cancel_timer не влезает в отведённые ему 40 байт")
  .text.tail_basic_sm__inject_event_8dd1c8 0x008dd1c8 : { KEEP(*(.text.tail_basic_sm__inject_event_8dd1c8)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8dd1c8) <= 16, "блок tail_basic_sm__inject_event_8dd1c8 не влезает в отведённые ему 16 байт")
  .text.ps_assoc_mgr__vt10 0x008dd1d8 : { KEEP(*(.text.ps_assoc_mgr__vt10)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt10) <= 8, "блок ps_assoc_mgr__vt10 не влезает в отведённые ему 8 байт")
  .text.tail_basic_sm__inject_event_8dd1e0 0x008dd1e0 : { KEEP(*(.text.tail_basic_sm__inject_event_8dd1e0)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8dd1e0) <= 12, "блок tail_basic_sm__inject_event_8dd1e0 не влезает в отведённые ему 12 байт")
  .text.ps_nonassoc_mgr__vt10 0x008dd1ec : { KEEP(*(.text.ps_nonassoc_mgr__vt10)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt10) <= 8, "блок ps_nonassoc_mgr__vt10 не влезает в отведённые ему 8 байт")
  .text.ps_conn__inject_evt5 0x008dd1f4 : { KEEP(*(.text.ps_conn__inject_evt5)) }
  ASSERT(SIZEOF(.text.ps_conn__inject_evt5) <= 16, "блок ps_conn__inject_evt5 не влезает в отведённые ему 16 байт")
  .text.tail_basic_sm__inject_event_8dd204 0x008dd204 : { KEEP(*(.text.tail_basic_sm__inject_event_8dd204)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8dd204) <= 12, "блок tail_basic_sm__inject_event_8dd204 не влезает в отведённые ему 12 байт")
  .text.ps_assoc_mgr__vt0c 0x008dd210 : { KEEP(*(.text.ps_assoc_mgr__vt0c)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt0c) <= 8, "блок ps_assoc_mgr__vt0c не влезает в отведённые ему 8 байт")
  .text.tail_basic_sm__inject_event_8dd218 0x008dd218 : { KEEP(*(.text.tail_basic_sm__inject_event_8dd218)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8dd218) <= 12, "блок tail_basic_sm__inject_event_8dd218 не влезает в отведённые ему 12 байт")
  .text.ps_nonassoc_mgr__vt0c 0x008dd224 : { KEEP(*(.text.ps_nonassoc_mgr__vt0c)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt0c) <= 8, "блок ps_nonassoc_mgr__vt0c не влезает в отведённые ему 8 байт")
  .text.ps_conn__inject_evt_if_assoc 0x008dd22c : { KEEP(*(.text.ps_conn__inject_evt_if_assoc)) }
  ASSERT(SIZEOF(.text.ps_conn__inject_evt_if_assoc) <= 60, "блок ps_conn__inject_evt_if_assoc не влезает в отведённые ему 60 байт")
  .text.ps_assoc_mgr__set_awake_tsf 0x008dd268 : { KEEP(*(.text.ps_assoc_mgr__set_awake_tsf)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__set_awake_tsf) <= 132, "блок ps_assoc_mgr__set_awake_tsf не влезает в отведённые ему 132 байт")
  .text.ps_nonassoc_mgr__ps_evt_handler 0x008dd2ec : { KEEP(*(.text.ps_nonassoc_mgr__ps_evt_handler)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__ps_evt_handler) <= 20, "блок ps_nonassoc_mgr__ps_evt_handler не влезает в отведённые ему 20 байт")
  .text.ps_conn_mgr__dispatch 0x008dd300 : { KEEP(*(.text.ps_conn_mgr__dispatch)) }
  ASSERT(SIZEOF(.text.ps_conn_mgr__dispatch) <= 44, "блок ps_conn_mgr__dispatch не влезает в отведённые ему 44 байт")
  .text.ps_assoc_sm__on_reenter_done 0x008dd32c : { KEEP(*(.text.ps_assoc_sm__on_reenter_done)) }
  ASSERT(SIZEOF(.text.ps_assoc_sm__on_reenter_done) <= 56, "блок ps_assoc_sm__on_reenter_done не влезает в отведённые ему 56 байт")
  .text.PS_NONASSOC_SM__ps_reenter_done 0x008dd364 : { KEEP(*(.text.PS_NONASSOC_SM__ps_reenter_done)) }
  ASSERT(SIZEOF(.text.PS_NONASSOC_SM__ps_reenter_done) <= 48, "блок PS_NONASSOC_SM__ps_reenter_done не влезает в отведённые ему 48 байт")
  .text.stub_ret_8dd394 0x008dd394 : { KEEP(*(.text.stub_ret_8dd394)) }
  ASSERT(SIZEOF(.text.stub_ret_8dd394) <= 4, "блок stub_ret_8dd394 не влезает в отведённые ему 4 байт")
  .text.ps_assoc_sm__on_ps_deep_sleep_exit 0x008dd398 : { KEEP(*(.text.ps_assoc_sm__on_ps_deep_sleep_exit)) }
  ASSERT(SIZEOF(.text.ps_assoc_sm__on_ps_deep_sleep_exit) <= 32, "блок ps_assoc_sm__on_ps_deep_sleep_exit не влезает в отведённые ему 32 байт")
  .text.stub_ret_8dd3b8 0x008dd3b8 : { KEEP(*(.text.stub_ret_8dd3b8)) }
  ASSERT(SIZEOF(.text.stub_ret_8dd3b8) <= 4, "блок stub_ret_8dd3b8 не влезает в отведённые ему 4 байт")
  .text.ps_nonassoc_sm__on_ps_sleep_exit 0x008dd3bc : { KEEP(*(.text.ps_nonassoc_sm__on_ps_sleep_exit)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_sm__on_ps_sleep_exit) <= 32, "блок ps_nonassoc_sm__on_ps_sleep_exit не влезает в отведённые ему 32 байт")
  .text.PS_ASSOC_SM__ps_schd_reenter_extend 0x008dd3dc : { KEEP(*(.text.PS_ASSOC_SM__ps_schd_reenter_extend)) }
  ASSERT(SIZEOF(.text.PS_ASSOC_SM__ps_schd_reenter_extend) <= 68, "блок PS_ASSOC_SM__ps_schd_reenter_extend не влезает в отведённые ему 68 байт")
  .text.ps_nonassoc_sm__rearm_timer 0x008dd420 : { KEEP(*(.text.ps_nonassoc_sm__rearm_timer)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_sm__rearm_timer) <= 52, "блок ps_nonassoc_sm__rearm_timer не влезает в отведённые ему 52 байт")
  .text.get_g_800118_8dd454 0x008dd454 : { KEEP(*(.text.get_g_800118_8dd454)) }
  ASSERT(SIZEOF(.text.get_g_800118_8dd454) <= 12, "блок get_g_800118_8dd454 не влезает в отведённые ему 12 байт")
  .text.psc__inject_evt_if_state3 0x008dd460 : { KEEP(*(.text.psc__inject_evt_if_state3)) }
  ASSERT(SIZEOF(.text.psc__inject_evt_if_state3) <= 28, "блок psc__inject_evt_if_state3 не влезает в отведённые ему 28 байт")
  .text.stub_ret_8dd47c 0x008dd47c : { KEEP(*(.text.stub_ret_8dd47c)) }
  ASSERT(SIZEOF(.text.stub_ret_8dd47c) <= 4, "блок stub_ret_8dd47c не влезает в отведённые ему 4 байт")
  .text.ps_assoc_mgr__vt20 0x008dd480 : { KEEP(*(.text.ps_assoc_mgr__vt20)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt20) <= 8, "блок ps_assoc_mgr__vt20 не влезает в отведённые ему 8 байт")
  .text.psc__inject_evt_if_state2 0x008dd488 : { KEEP(*(.text.psc__inject_evt_if_state2)) }
  ASSERT(SIZEOF(.text.psc__inject_evt_if_state2) <= 28, "блок psc__inject_evt_if_state2 не влезает в отведённые ему 28 байт")
  .text.stub_ret_8dd4a4 0x008dd4a4 : { KEEP(*(.text.stub_ret_8dd4a4)) }
  ASSERT(SIZEOF(.text.stub_ret_8dd4a4) <= 4, "блок stub_ret_8dd4a4 не влезает в отведённые ему 4 байт")
  .text.ps_nonassoc_mgr__vt20 0x008dd4a8 : { KEEP(*(.text.ps_nonassoc_mgr__vt20)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt20) <= 8, "блок ps_nonassoc_mgr__vt20 не влезает в отведённые ему 8 байт")
  .text.tail_u_schd__add 0x008dd4b0 : { KEEP(*(.text.tail_u_schd__add)) }
  ASSERT(SIZEOF(.text.tail_u_schd__add) <= 16, "блок tail_u_schd__add не влезает в отведённые ему 16 байт")
  .text.tail_u_schd__add_8dd4c0 0x008dd4c0 : { KEEP(*(.text.tail_u_schd__add_8dd4c0)) }
  ASSERT(SIZEOF(.text.tail_u_schd__add_8dd4c0) <= 16, "блок tail_u_schd__add_8dd4c0 не влезает в отведённые ему 16 байт")
  .text.get_g_800118_8dd4d0 0x008dd4d0 : { KEEP(*(.text.get_g_800118_8dd4d0)) }
  ASSERT(SIZEOF(.text.get_g_800118_8dd4d0) <= 8, "блок get_g_800118_8dd4d0 не влезает в отведённые ему 8 байт")
  .text.tail_basic_sm__inject_event_8dd4d8 0x008dd4d8 : { KEEP(*(.text.tail_basic_sm__inject_event_8dd4d8)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8dd4d8) <= 12, "блок tail_basic_sm__inject_event_8dd4d8 не влезает в отведённые ему 12 байт")
  .text.ps_assoc_mgr__vt1c 0x008dd4e4 : { KEEP(*(.text.ps_assoc_mgr__vt1c)) }
  ASSERT(SIZEOF(.text.ps_assoc_mgr__vt1c) <= 8, "блок ps_assoc_mgr__vt1c не влезает в отведённые ему 8 байт")
  .text.tail_basic_sm__inject_event_8dd4ec 0x008dd4ec : { KEEP(*(.text.tail_basic_sm__inject_event_8dd4ec)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8dd4ec) <= 12, "блок tail_basic_sm__inject_event_8dd4ec не влезает в отведённые ему 12 байт")
  .text.ps_nonassoc_mgr__vt1c 0x008dd4f8 : { KEEP(*(.text.ps_nonassoc_mgr__vt1c)) }
  ASSERT(SIZEOF(.text.ps_nonassoc_mgr__vt1c) <= 8, "блок ps_nonassoc_mgr__vt1c не влезает в отведённые ему 8 байт")
  .text.power_mngr__recalc_aw 0x008dd500 : { KEEP(*(.text.power_mngr__recalc_aw)) }
  ASSERT(SIZEOF(.text.power_mngr__recalc_aw) <= 84, "блок power_mngr__recalc_aw не влезает в отведённые ему 84 байт")
  .text.PS_CONNECTION__psc_complete 0x008dd554 : { KEEP(*(.text.PS_CONNECTION__psc_complete)) }
  ASSERT(SIZEOF(.text.PS_CONNECTION__psc_complete) <= 564, "блок PS_CONNECTION__psc_complete не влезает в отведённые ему 564 байт")
  .text.pcp_psc_sm__psc_done 0x008dd788 : { KEEP(*(.text.pcp_psc_sm__psc_done)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__psc_done) <= 64, "блок pcp_psc_sm__psc_done не влезает в отведённые ему 64 байт")
  .text.sta_psc_sm__psc_done_sm 0x008dd7c8 : { KEEP(*(.text.sta_psc_sm__psc_done_sm)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__psc_done_sm) <= 72, "блок sta_psc_sm__psc_done_sm не влезает в отведённые ему 72 байт")
  .text.ps_connection__psc_req_ignore 0x008dd810 : { KEEP(*(.text.ps_connection__psc_req_ignore)) }
  ASSERT(SIZEOF(.text.ps_connection__psc_req_ignore) <= 32, "блок ps_connection__psc_req_ignore не влезает в отведённые ему 32 байт")
  .text.psc__req_ignore_by_index 0x008dd830 : { KEEP(*(.text.psc__req_ignore_by_index)) }
  ASSERT(SIZEOF(.text.psc__req_ignore_by_index) <= 16, "блок psc__req_ignore_by_index не влезает в отведённые ему 16 байт")
  .text.sta_psc_sm__psc_req_tx_complete 0x008dd840 : { KEEP(*(.text.sta_psc_sm__psc_req_tx_complete)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__psc_req_tx_complete) <= 100, "блок sta_psc_sm__psc_req_tx_complete не влезает в отведённые ему 100 байт")
  .text.PS_CONNECTION_MGR__psc_req_tx_wb_cb 0x008dd8a4 : { KEEP(*(.text.PS_CONNECTION_MGR__psc_req_tx_wb_cb)) }
  ASSERT(SIZEOF(.text.PS_CONNECTION_MGR__psc_req_tx_wb_cb) <= 180, "блок PS_CONNECTION_MGR__psc_req_tx_wb_cb не влезает в отведённые ему 180 байт")
  .text.psc_if__timer_2c_expired 0x008dd958 : { KEEP(*(.text.psc_if__timer_2c_expired)) }
  ASSERT(SIZEOF(.text.psc_if__timer_2c_expired) <= 68, "блок psc_if__timer_2c_expired не влезает в отведённые ему 68 байт")
  .text.psc_if__timer_30_expired 0x008dd99c : { KEEP(*(.text.psc_if__timer_30_expired)) }
  ASSERT(SIZEOF(.text.psc_if__timer_30_expired) <= 68, "блок psc_if__timer_30_expired не влезает в отведённые ему 68 байт")
  .text.PS_CONNECTION_MGR__psc_resp_tx_wb_cb 0x008dd9e0 : { KEEP(*(.text.PS_CONNECTION_MGR__psc_resp_tx_wb_cb)) }
  ASSERT(SIZEOF(.text.PS_CONNECTION_MGR__psc_resp_tx_wb_cb) <= 144, "блок PS_CONNECTION_MGR__psc_resp_tx_wb_cb не влезает в отведённые ему 144 байт")
  .text.psc_if__timer_2c_cancel 0x008dda70 : { KEEP(*(.text.psc_if__timer_2c_cancel)) }
  ASSERT(SIZEOF(.text.psc_if__timer_2c_cancel) <= 56, "блок psc_if__timer_2c_cancel не влезает в отведённые ему 56 байт")
  .text.ps_connection__psc_rsp_ignore 0x008ddaa8 : { KEEP(*(.text.ps_connection__psc_rsp_ignore)) }
  ASSERT(SIZEOF(.text.ps_connection__psc_rsp_ignore) <= 32, "блок ps_connection__psc_rsp_ignore не влезает в отведённые ему 32 байт")
  .text.psc__rsp_ignore_by_index 0x008ddac8 : { KEEP(*(.text.psc__rsp_ignore_by_index)) }
  ASSERT(SIZEOF(.text.psc__rsp_ignore_by_index) <= 16, "блок psc__rsp_ignore_by_index не влезает в отведённые ему 16 байт")
  .text.pcp_psc_sm__psc_start_flow 0x008ddad8 : { KEEP(*(.text.pcp_psc_sm__psc_start_flow)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__psc_start_flow) <= 52, "блок pcp_psc_sm__psc_start_flow не влезает в отведённые ему 52 байт")
  .text.sta_psc_sm__psc_start_flow 0x008ddb0c : { KEEP(*(.text.sta_psc_sm__psc_start_flow)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__psc_start_flow) <= 72, "блок sta_psc_sm__psc_start_flow не влезает в отведённые ему 72 байт")
  .text.mac_kick_ring 0x008ddb54 : { KEEP(*(.text.mac_kick_ring)) }
  ASSERT(SIZEOF(.text.mac_kick_ring) <= 20, "блок mac_kick_ring не влезает в отведённые ему 20 байт")
  .text.tx_dma_if__push_desc 0x008ddb68 : { KEEP(*(.text.tx_dma_if__push_desc)) }
  ASSERT(SIZEOF(.text.tx_dma_if__push_desc) <= 192, "блок tx_dma_if__push_desc не влезает в отведённые ему 192 байт")
  .text.radio_mgr__enqueue_request 0x008ddc28 : { KEEP(*(.text.radio_mgr__enqueue_request)) }
  ASSERT(SIZEOF(.text.radio_mgr__enqueue_request) <= 20, "блок radio_mgr__enqueue_request не влезает в отведённые ему 20 байт")
  .text.WBE_DRIVER__ACTIVATING 0x008ddc3c : { KEEP(*(.text.WBE_DRIVER__ACTIVATING)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__ACTIVATING) <= 64, "блок WBE_DRIVER__ACTIVATING не влезает в отведённые ему 64 байт")
  .text.TEMPERATURE_SERVICE__radio_locked_cb 0x008ddc7c : { KEEP(*(.text.TEMPERATURE_SERVICE__radio_locked_cb)) }
  ASSERT(SIZEOF(.text.TEMPERATURE_SERVICE__radio_locked_cb) <= 188, "блок TEMPERATURE_SERVICE__radio_locked_cb не влезает в отведённые ему 188 байт")
  .text.tail_basic_sm__inject_event_8ddd38 0x008ddd38 : { KEEP(*(.text.tail_basic_sm__inject_event_8ddd38)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8ddd38) <= 12, "блок tail_basic_sm__inject_event_8ddd38 не влезает в отведённые ему 12 байт")
  .text.rcp__on_delba 0x008ddd44 : { KEEP(*(.text.rcp__on_delba)) }
  ASSERT(SIZEOF(.text.rcp__on_delba) <= 48, "блок rcp__on_delba не влезает в отведённые ему 48 байт")
  .text.tail_hwd_rfc_read_rgf 0x008ddd74 : { KEEP(*(.text.tail_hwd_rfc_read_rgf)) }
  ASSERT(SIZEOF(.text.tail_hwd_rfc_read_rgf) <= 8, "блок tail_hwd_rfc_read_rgf не влезает в отведённые ему 8 байт")
  .text.rf_lo__refresh_periodic 0x008ddd7c : { KEEP(*(.text.rf_lo__refresh_periodic)) }
  ASSERT(SIZEOF(.text.rf_lo__refresh_periodic) <= 44, "блок rf_lo__refresh_periodic не влезает в отведённые ему 44 байт")
  .text.temp_measure_step 0x008ddda8 : { KEEP(*(.text.temp_measure_step)) }
  ASSERT(SIZEOF(.text.temp_measure_step) <= 176, "блок temp_measure_step не влезает в отведённые ему 176 байт")
  .text.wmi_handler_otp_read 0x008dde58 : { KEEP(*(.text.wmi_handler_otp_read)) }
  ASSERT(SIZEOF(.text.wmi_handler_otp_read) <= 116, "блок wmi_handler_otp_read не влезает в отведённые ему 116 байт")
  .text.TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters 0x008ddecc : { KEEP(*(.text.TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters)) }
  ASSERT(SIZEOF(.text.TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters) <= 164, "блок TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters не влезает в отведённые ему 164 байт")
  .text.temp_sense__no_rf 0x008ddf70 : { KEEP(*(.text.temp_sense__no_rf)) }
  ASSERT(SIZEOF(.text.temp_sense__no_rf) <= 52, "блок temp_sense__no_rf не влезает в отведённые ему 52 байт")
  .text.temp_service__sample_without_rf 0x008ddfa4 : { KEEP(*(.text.temp_service__sample_without_rf)) }
  ASSERT(SIZEOF(.text.temp_service__sample_without_rf) <= 28, "блок temp_service__sample_without_rf не влезает в отведённые ему 28 байт")
  .text.STREAM_MGR__ready_for_modify 0x008ddfc0 : { KEEP(*(.text.STREAM_MGR__ready_for_modify)) }
  ASSERT(SIZEOF(.text.STREAM_MGR__ready_for_modify) <= 136, "блок STREAM_MGR__ready_for_modify не влезает в отведённые ему 136 байт")
  .text.conn__update_vring_metric 0x008de048 : { KEEP(*(.text.conn__update_vring_metric)) }
  ASSERT(SIZEOF(.text.conn__update_vring_metric) <= 68, "блок conn__update_vring_metric не влезает в отведённые ему 68 байт")
  .text.offload__parse_ese_with_flag 0x008de08c : { KEEP(*(.text.offload__parse_ese_with_flag)) }
  ASSERT(SIZEOF(.text.offload__parse_ese_with_flag) <= 8, "блок offload__parse_ese_with_flag не влезает в отведённые ему 8 байт")
  .text.u_schd__arm_timer 0x008de094 : { KEEP(*(.text.u_schd__arm_timer)) }
  ASSERT(SIZEOF(.text.u_schd__arm_timer) <= 68, "блок u_schd__arm_timer не влезает в отведённые ему 68 байт")
  .text.rf__apply_tx_power 0x008de0d8 : { KEEP(*(.text.rf__apply_tx_power)) }
  ASSERT(SIZEOF(.text.rf__apply_tx_power) <= 68, "блок rf__apply_tx_power не влезает в отведённые ему 68 байт")
  .text.regulatory_domain_set_tx_gain_offset 0x008de11c : { KEEP(*(.text.regulatory_domain_set_tx_gain_offset)) }
  ASSERT(SIZEOF(.text.regulatory_domain_set_tx_gain_offset) <= 60, "блок regulatory_domain_set_tx_gain_offset не влезает в отведённые ему 60 байт")
  .text.maintain_sm__release_radio_after_bf_evt 0x008de158 : { KEEP(*(.text.maintain_sm__release_radio_after_bf_evt)) }
  ASSERT(SIZEOF(.text.maintain_sm__release_radio_after_bf_evt) <= 68, "блок maintain_sm__release_radio_after_bf_evt не влезает в отведённые ему 68 байт")
  .text.conn_msm__on_ntf_lm_started__wait_for_assoc_done 0x008de19c : { KEEP(*(.text.conn_msm__on_ntf_lm_started__wait_for_assoc_done)) }
  ASSERT(SIZEOF(.text.conn_msm__on_ntf_lm_started__wait_for_assoc_done) <= 8, "блок conn_msm__on_ntf_lm_started__wait_for_assoc_done не влезает в отведённые ему 8 байт")
  .text.app_ie__remove_tlv 0x008de1a4 : { KEEP(*(.text.app_ie__remove_tlv)) }
  ASSERT(SIZEOF(.text.app_ie__remove_tlv) <= 172, "блок app_ie__remove_tlv не влезает в отведённые ему 172 байт")
  .text.remove_app_ie 0x008de250 : { KEEP(*(.text.remove_app_ie)) }
  ASSERT(SIZEOF(.text.remove_app_ie) <= 132, "блок remove_app_ie не влезает в отведённые ему 132 байт")
  .text.llist__pop_front 0x008de2d4 : { KEEP(*(.text.llist__pop_front)) }
  ASSERT(SIZEOF(.text.llist__pop_front) <= 48, "блок llist__pop_front не влезает в отведённые ему 48 байт")
  .text.FWQ_TX_AVAILABILITY__remove_packet 0x008de304 : { KEEP(*(.text.FWQ_TX_AVAILABILITY__remove_packet)) }
  ASSERT(SIZEOF(.text.FWQ_TX_AVAILABILITY__remove_packet) <= 196, "блок FWQ_TX_AVAILABILITY__remove_packet не влезает в отведённые ему 196 байт")
  .text.pbss__sta_flags_ptr 0x008de3c8 : { KEEP(*(.text.pbss__sta_flags_ptr)) }
  ASSERT(SIZEOF(.text.pbss__sta_flags_ptr) <= 12, "блок pbss__sta_flags_ptr не влезает в отведённые ему 12 байт")
  .text.radio_mgr__alloc_request 0x008de3d4 : { KEEP(*(.text.radio_mgr__alloc_request)) }
  ASSERT(SIZEOF(.text.radio_mgr__alloc_request) <= 80, "блок radio_mgr__alloc_request не влезает в отведённые ему 80 байт")
  .text.radio_mgr__unlink_request 0x008de424 : { KEEP(*(.text.radio_mgr__unlink_request)) }
  ASSERT(SIZEOF(.text.radio_mgr__unlink_request) <= 32, "блок radio_mgr__unlink_request не влезает в отведённые ему 32 байт")
  .text.RADIO_MGR__remove_request 0x008de444 : { KEEP(*(.text.RADIO_MGR__remove_request)) }
  ASSERT(SIZEOF(.text.RADIO_MGR__remove_request) <= 36, "блок RADIO_MGR__remove_request не влезает в отведённые ему 36 байт")
  .text.STREAM_MGR 0x008de468 : { KEEP(*(.text.STREAM_MGR)) }
  ASSERT(SIZEOF(.text.STREAM_MGR) <= 132, "блок STREAM_MGR не влезает в отведённые ему 132 байт")
  .text.llist__remove 0x008de4ec : { KEEP(*(.text.llist__remove)) }
  ASSERT(SIZEOF(.text.llist__remove) <= 160, "блок llist__remove не влезает в отведённые ему 160 байт")
  .text.maintain_sm__lock_radio 0x008de58c : { KEEP(*(.text.maintain_sm__lock_radio)) }
  ASSERT(SIZEOF(.text.maintain_sm__lock_radio) <= 40, "блок maintain_sm__lock_radio не влезает в отведённые ему 40 байт")
  .text.tail_hwd_dma__reset_vring 0x008de5b4 : { KEEP(*(.text.tail_hwd_dma__reset_vring)) }
  ASSERT(SIZEOF(.text.tail_hwd_dma__reset_vring) <= 4, "блок tail_hwd_dma__reset_vring не влезает в отведённые ему 4 байт")
  .text.set_g_8000c0_x2 0x008de5b8 : { KEEP(*(.text.set_g_8000c0_x2)) }
  ASSERT(SIZEOF(.text.set_g_8000c0_x2) <= 12, "блок set_g_8000c0_x2 не влезает в отведённые ему 12 байт")
  .text.llist__init 0x008de5c4 : { KEEP(*(.text.llist__init)) }
  ASSERT(SIZEOF(.text.llist__init) <= 12, "блок llist__init не влезает в отведённые ему 12 байт")
  .text.set_g_800100 0x008de5d0 : { KEEP(*(.text.set_g_800100)) }
  ASSERT(SIZEOF(.text.set_g_800100) <= 8, "блок set_g_800100 не влезает в отведённые ему 8 байт")
  .text.tx_macq__config_ring_params 0x008de5d8 : { KEEP(*(.text.tx_macq__config_ring_params)) }
  ASSERT(SIZEOF(.text.tx_macq__config_ring_params) <= 112, "блок tx_macq__config_ring_params не влезает в отведённые ему 112 байт")
  .text.tail_8de648 0x008de648 : { KEEP(*(.text.tail_8de648)) }
  ASSERT(SIZEOF(.text.tail_8de648) <= 4, "блок tail_8de648 не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_rcp_delba_arrived 0x008de64c : { KEEP(*(.text.ba_sm__on_rcp_delba_arrived)) }
  ASSERT(SIZEOF(.text.ba_sm__on_rcp_delba_arrived) <= 36, "блок ba_sm__on_rcp_delba_arrived не влезает в отведённые ему 36 байт")
  .text.vring_macq_delete_step 0x008de670 : { KEEP(*(.text.vring_macq_delete_step)) }
  ASSERT(SIZEOF(.text.vring_macq_delete_step) <= 172, "блок vring_macq_delete_step не влезает в отведённые ему 172 байт")
  .text.conn_msm__on_own_start_link__ready_for_assoc 0x008de71c : { KEEP(*(.text.conn_msm__on_own_start_link__ready_for_assoc)) }
  ASSERT(SIZEOF(.text.conn_msm__on_own_start_link__ready_for_assoc) <= 32, "блок conn_msm__on_own_start_link__ready_for_assoc не влезает в отведённые ему 32 байт")
  .text.ba_td_subsm__on_delba_tx_complete 0x008de73c : { KEEP(*(.text.ba_td_subsm__on_delba_tx_complete)) }
  ASSERT(SIZEOF(.text.ba_td_subsm__on_delba_tx_complete) <= 12, "блок ba_td_subsm__on_delba_tx_complete не влезает в отведённые ему 12 байт")
  .text.frag_8de748 0x008de748 : { KEEP(*(.text.frag_8de748)) }
  ASSERT(SIZEOF(.text.frag_8de748) <= 4, "блок frag_8de748 не влезает в отведённые ему 4 байт")
  .text.link_stats_sm__on_resume 0x008de74c : { KEEP(*(.text.link_stats_sm__on_resume)) }
  ASSERT(SIZEOF(.text.link_stats_sm__on_resume) <= 24, "блок link_stats_sm__on_resume не влезает в отведённые ему 24 байт")
  .text.conn__start_detector_services 0x008de764 : { KEEP(*(.text.conn__start_detector_services)) }
  ASSERT(SIZEOF(.text.conn__start_detector_services) <= 48, "блок conn__start_detector_services не влезает в отведённые ему 48 байт")
  .text.conn_mgr__foreach_link_arm_timer 0x008de794 : { KEEP(*(.text.conn_mgr__foreach_link_arm_timer)) }
  ASSERT(SIZEOF(.text.conn_mgr__foreach_link_arm_timer) <= 56, "блок conn_mgr__foreach_link_arm_timer не влезает в отведённые ему 56 байт")
  .text.lm_main_sm__on_resume_maintain_req 0x008de7cc : { KEEP(*(.text.lm_main_sm__on_resume_maintain_req)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_resume_maintain_req) <= 16, "блок lm_main_sm__on_resume_maintain_req не влезает в отведённые ему 16 байт")
  .text.ka_detector__start_service 0x008de7dc : { KEEP(*(.text.ka_detector__start_service)) }
  ASSERT(SIZEOF(.text.ka_detector__start_service) <= 36, "блок ka_detector__start_service не влезает в отведённые ему 36 байт")
  .text.ageing_detector__start_service 0x008de800 : { KEEP(*(.text.ageing_detector__start_service)) }
  ASSERT(SIZEOF(.text.ageing_detector__start_service) <= 36, "блок ageing_detector__start_service не влезает в отведённые ему 36 байт")
  .text.lm_if__inject_evt_b 0x008de824 : { KEEP(*(.text.lm_if__inject_evt_b)) }
  ASSERT(SIZEOF(.text.lm_if__inject_evt_b) <= 52, "блок lm_if__inject_evt_b не влезает в отведённые ему 52 байт")
  .text.vring_schd__resume_vring 0x008de858 : { KEEP(*(.text.vring_schd__resume_vring)) }
  ASSERT(SIZEOF(.text.vring_schd__resume_vring) <= 120, "блок vring_schd__resume_vring не влезает в отведённые ему 120 байт")
  .text.silent_rssi__classify_levels 0x008de8d0 : { KEEP(*(.text.silent_rssi__classify_levels)) }
  ASSERT(SIZEOF(.text.silent_rssi__classify_levels) <= 184, "блок silent_rssi__classify_levels не влезает в отведённые ему 184 байт")
  .text.marlon_r_if_class__rf_configure_role_power 0x008de988 : { KEEP(*(.text.marlon_r_if_class__rf_configure_role_power)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__rf_configure_role_power) <= 52, "блок marlon_r_if_class__rf_configure_role_power не влезает в отведённые ему 52 байт")
  .text.frag_8de9bc 0x008de9bc : { KEEP(*(.text.frag_8de9bc)) }
  ASSERT(SIZEOF(.text.frag_8de9bc) <= 4, "блок frag_8de9bc не влезает в отведённые ему 4 байт")
  .text.rf_kill__poll_and_notify 0x008de9c0 : { KEEP(*(.text.rf_kill__poll_and_notify)) }
  ASSERT(SIZEOF(.text.rf_kill__poll_and_notify) <= 56, "блок rf_kill__poll_and_notify не влезает в отведённые ему 56 байт")
  .text.silent_rssi__log_levels 0x008de9f8 : { KEEP(*(.text.silent_rssi__log_levels)) }
  ASSERT(SIZEOF(.text.silent_rssi__log_levels) <= 116, "блок silent_rssi__log_levels не влезает в отведённые ему 116 байт")
  .text.marlon_r_if_class__rf_hw_write_buffer 0x008dea6c : { KEEP(*(.text.marlon_r_if_class__rf_hw_write_buffer)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__rf_hw_write_buffer) <= 64, "блок marlon_r_if_class__rf_hw_write_buffer не влезает в отведённые ему 64 байт")
  .text.marlon_r_if_class__rf_write_with_block_retries 0x008deaac : { KEEP(*(.text.marlon_r_if_class__rf_write_with_block_retries)) }
  ASSERT(SIZEOF(.text.marlon_r_if_class__rf_write_with_block_retries) <= 588, "блок marlon_r_if_class__rf_write_with_block_retries не влезает в отведённые ему 588 байт")
  .text.mbox__ring_init 0x008decf8 : { KEEP(*(.text.mbox__ring_init)) }
  ASSERT(SIZEOF(.text.mbox__ring_init) <= 40, "блок mbox__ring_init не влезает в отведённые ему 40 байт")
  .text.mbox__init_operational 0x008ded20 : { KEEP(*(.text.mbox__init_operational)) }
  ASSERT(SIZEOF(.text.mbox__init_operational) <= 60, "блок mbox__init_operational не влезает в отведённые ему 60 байт")
  .text.mbox__init_debug 0x008ded5c : { KEEP(*(.text.mbox__init_debug)) }
  ASSERT(SIZEOF(.text.mbox__init_debug) <= 52, "блок mbox__init_debug не влезает в отведённые ему 52 байт")
  .text.rx_macq__program_ba_win 0x008ded90 : { KEEP(*(.text.rx_macq__program_ba_win)) }
  ASSERT(SIZEOF(.text.rx_macq__program_ba_win) <= 112, "блок rx_macq__program_ba_win не влезает в отведённые ему 112 байт")
  .text.rx_buf__init_descriptor 0x008dee00 : { KEEP(*(.text.rx_buf__init_descriptor)) }
  ASSERT(SIZEOF(.text.rx_buf__init_descriptor) <= 48, "блок rx_buf__init_descriptor не влезает в отведённые ему 48 байт")
  .text.rx_api__drain_list 0x008dee30 : { KEEP(*(.text.rx_api__drain_list)) }
  ASSERT(SIZEOF(.text.rx_api__drain_list) <= 156, "блок rx_api__drain_list не влезает в отведённые ему 156 байт")
  .text.tail_rx_pkt_srvs__dispatch 0x008deecc : { KEEP(*(.text.tail_rx_pkt_srvs__dispatch)) }
  ASSERT(SIZEOF(.text.tail_rx_pkt_srvs__dispatch) <= 12, "блок tail_rx_pkt_srvs__dispatch не влезает в отведённые ему 12 байт")
  .text.rm_chan_sw_sm__on_ucode_rx_off_evt 0x008deed8 : { KEEP(*(.text.rm_chan_sw_sm__on_ucode_rx_off_evt)) }
  ASSERT(SIZEOF(.text.rm_chan_sw_sm__on_ucode_rx_off_evt) <= 52, "блок rm_chan_sw_sm__on_ucode_rx_off_evt не влезает в отведённые ему 52 байт")
  .text.rm_chan_sw_sm__on_ucode_rx_on_evt 0x008def0c : { KEEP(*(.text.rm_chan_sw_sm__on_ucode_rx_on_evt)) }
  ASSERT(SIZEOF(.text.rm_chan_sw_sm__on_ucode_rx_on_evt) <= 56, "блок rm_chan_sw_sm__on_ucode_rx_on_evt не влезает в отведённые ему 56 байт")
  .text.rx_pkt_srvs__distribute_data 0x008def44 : { KEEP(*(.text.rx_pkt_srvs__distribute_data)) }
  ASSERT(SIZEOF(.text.rx_pkt_srvs__distribute_data) <= 168, "блок rx_pkt_srvs__distribute_data не влезает в отведённые ему 168 байт")
  .text.rx_pkt__mid_accepts 0x008defec : { KEEP(*(.text.rx_pkt__mid_accepts)) }
  ASSERT(SIZEOF(.text.rx_pkt__mid_accepts) <= 40, "блок rx_pkt__mid_accepts не влезает в отведённые ему 40 байт")
  .text.rx_mgmt_srvs__distribute 0x008df014 : { KEEP(*(.text.rx_mgmt_srvs__distribute)) }
  ASSERT(SIZEOF(.text.rx_mgmt_srvs__distribute) <= 212, "блок rx_mgmt_srvs__distribute не влезает в отведённые ему 212 байт")
  .text.tail_rx_mgmt_prs__alloc_ei 0x008df0e8 : { KEEP(*(.text.tail_rx_mgmt_prs__alloc_ei)) }
  ASSERT(SIZEOF(.text.tail_rx_mgmt_prs__alloc_ei) <= 12, "блок tail_rx_mgmt_prs__alloc_ei не влезает в отведённые ему 12 байт")
  .text.get_g_8062c4 0x008df0f4 : { KEEP(*(.text.get_g_8062c4)) }
  ASSERT(SIZEOF(.text.get_g_8062c4) <= 28, "блок get_g_8062c4 не влезает в отведённые ему 28 байт")
  .text.get_g_8062ec 0x008df110 : { KEEP(*(.text.get_g_8062ec)) }
  ASSERT(SIZEOF(.text.get_g_8062ec) <= 12, "блок get_g_8062ec не влезает в отведённые ему 12 байт")
  .text.rx_pkt_srvs__dispatch 0x008df11c : { KEEP(*(.text.rx_pkt_srvs__dispatch)) }
  ASSERT(SIZEOF(.text.rx_pkt_srvs__dispatch) <= 236, "блок rx_pkt_srvs__dispatch не влезает в отведённые ему 236 байт")
  .text.rx_pkt_handler 0x008df208 : { KEEP(*(.text.rx_pkt_handler)) }
  ASSERT(SIZEOF(.text.rx_pkt_handler) <= 304, "блок rx_pkt_handler не влезает в отведённые ему 304 байт")
  .text.discovery__rx_pkt_handler 0x008df338 : { KEEP(*(.text.discovery__rx_pkt_handler)) }
  ASSERT(SIZEOF(.text.discovery__rx_pkt_handler) <= 344, "блок discovery__rx_pkt_handler не влезает в отведённые ему 344 байт")
  .text.l2mgr__reset_oob_rings 0x008df490 : { KEEP(*(.text.l2mgr__reset_oob_rings)) }
  ASSERT(SIZEOF(.text.l2mgr__reset_oob_rings) <= 60, "блок l2mgr__reset_oob_rings не влезает в отведённые ему 60 байт")
  .text.sw_vring__program_ba_win 0x008df4cc : { KEEP(*(.text.sw_vring__program_ba_win)) }
  ASSERT(SIZEOF(.text.sw_vring__program_ba_win) <= 64, "блок sw_vring__program_ba_win не влезает в отведённые ему 64 байт")
  .text.rx_queue__config_by_kind 0x008df50c : { KEEP(*(.text.rx_queue__config_by_kind)) }
  ASSERT(SIZEOF(.text.rx_queue__config_by_kind) <= 240, "блок rx_queue__config_by_kind не влезает в отведённые ему 240 байт")
  .text.rx_queue__config_by_kind_b 0x008df5fc : { KEEP(*(.text.rx_queue__config_by_kind_b)) }
  ASSERT(SIZEOF(.text.rx_queue__config_by_kind_b) <= 132, "блок rx_queue__config_by_kind_b не влезает в отведённые ему 132 байт")
  .text.ese__set_alloc_type 0x008df680 : { KEEP(*(.text.ese__set_alloc_type)) }
  ASSERT(SIZEOF(.text.ese__set_alloc_type) <= 132, "блок ese__set_alloc_type не влезает в отведённые ему 132 байт")
  .text.rx_queue__set_type_bits 0x008df704 : { KEEP(*(.text.rx_queue__set_type_bits)) }
  ASSERT(SIZEOF(.text.rx_queue__set_type_bits) <= 12, "блок rx_queue__set_type_bits не влезает в отведённые ему 12 байт")
  .text.rx_macq__bind_queue 0x008df710 : { KEEP(*(.text.rx_macq__bind_queue)) }
  ASSERT(SIZEOF(.text.rx_macq__bind_queue) <= 148, "блок rx_macq__bind_queue не влезает в отведённые ему 148 байт")
  .text.rx_queue__program_desc 0x008df7a4 : { KEEP(*(.text.rx_queue__program_desc)) }
  ASSERT(SIZEOF(.text.rx_queue__program_desc) <= 232, "блок rx_queue__program_desc не влезает в отведённые ему 232 байт")
  .text.tail_vring__write_macq_desc 0x008df88c : { KEEP(*(.text.tail_vring__write_macq_desc)) }
  ASSERT(SIZEOF(.text.tail_vring__write_macq_desc) <= 12, "блок tail_vring__write_macq_desc не влезает в отведённые ему 12 байт")
  .text.tail_vring__write_macq_desc_8df898 0x008df898 : { KEEP(*(.text.tail_vring__write_macq_desc_8df898)) }
  ASSERT(SIZEOF(.text.tail_vring__write_macq_desc_8df898) <= 12, "блок tail_vring__write_macq_desc_8df898 не влезает в отведённые ему 12 байт")
  .text.tail_vring__write_macq_desc_8df8a4 0x008df8a4 : { KEEP(*(.text.tail_vring__write_macq_desc_8df8a4)) }
  ASSERT(SIZEOF(.text.tail_vring__write_macq_desc_8df8a4) <= 12, "блок tail_vring__write_macq_desc_8df8a4 не влезает в отведённые ему 12 байт")
  .text.rx_queue__calc_offset 0x008df8b0 : { KEEP(*(.text.rx_queue__calc_offset)) }
  ASSERT(SIZEOF(.text.rx_queue__calc_offset) <= 228, "блок rx_queue__calc_offset не влезает в отведённые ему 228 байт")
  .text.rx_desc__fill_defaults 0x008df994 : { KEEP(*(.text.rx_desc__fill_defaults)) }
  ASSERT(SIZEOF(.text.rx_desc__fill_defaults) <= 88, "блок rx_desc__fill_defaults не влезает в отведённые ему 88 байт")
  .text.get_g_800140_8df9ec 0x008df9ec : { KEEP(*(.text.get_g_800140_8df9ec)) }
  ASSERT(SIZEOF(.text.get_g_800140_8df9ec) <= 16, "блок get_g_800140_8df9ec не влезает в отведённые ему 16 байт")
  .text.maintain_sm__reschedule_task 0x008df9fc : { KEEP(*(.text.maintain_sm__reschedule_task)) }
  ASSERT(SIZEOF(.text.maintain_sm__reschedule_task) <= 68, "блок maintain_sm__reschedule_task не влезает в отведённые ему 68 байт")
  .text.link_stats_sm__arm_latency_timer 0x008dfa40 : { KEEP(*(.text.link_stats_sm__arm_latency_timer)) }
  ASSERT(SIZEOF(.text.link_stats_sm__arm_latency_timer) <= 64, "блок link_stats_sm__arm_latency_timer не влезает в отведённые ему 64 байт")
  .text.schedule_long_term_trigger 0x008dfa80 : { KEEP(*(.text.schedule_long_term_trigger)) }
  ASSERT(SIZEOF(.text.schedule_long_term_trigger) <= 236, "блок schedule_long_term_trigger не влезает в отведённые ему 236 байт")
  .text.periodic_service__tick 0x008dfb6c : { KEEP(*(.text.periodic_service__tick)) }
  ASSERT(SIZEOF(.text.periodic_service__tick) <= 124, "блок periodic_service__tick не влезает в отведённые ему 124 байт")
  .text.l2mgr__arm_notify_timer 0x008dfbe8 : { KEEP(*(.text.l2mgr__arm_notify_timer)) }
  ASSERT(SIZEOF(.text.l2mgr__arm_notify_timer) <= 44, "блок l2mgr__arm_notify_timer не влезает в отведённые ему 44 байт")
  .text.conn__arm_retry_timer 0x008dfc14 : { KEEP(*(.text.conn__arm_retry_timer)) }
  ASSERT(SIZEOF(.text.conn__arm_retry_timer) <= 64, "блок conn__arm_retry_timer не влезает в отведённые ему 64 байт")
  .text.link_stats_sm__arm_report_timer 0x008dfc54 : { KEEP(*(.text.link_stats_sm__arm_report_timer)) }
  ASSERT(SIZEOF(.text.link_stats_sm__arm_report_timer) <= 68, "блок link_stats_sm__arm_report_timer не влезает в отведённые ему 68 байт")
  .text.temp_sense__reschedule_timer 0x008dfc98 : { KEEP(*(.text.temp_sense__reschedule_timer)) }
  ASSERT(SIZEOF(.text.temp_sense__reschedule_timer) <= 60, "блок temp_sense__reschedule_timer не влезает в отведённые ему 60 байт")
  .text.calib_mngr__schedule_scheme_step 0x008dfcd4 : { KEEP(*(.text.calib_mngr__schedule_scheme_step)) }
  ASSERT(SIZEOF(.text.calib_mngr__schedule_scheme_step) <= 120, "блок calib_mngr__schedule_scheme_step не влезает в отведённые ему 120 байт")
  .text.calib_mngr__cancel_all_schemes 0x008dfd4c : { KEEP(*(.text.calib_mngr__cancel_all_schemes)) }
  ASSERT(SIZEOF(.text.calib_mngr__cancel_all_schemes) <= 44, "блок calib_mngr__cancel_all_schemes не влезает в отведённые ему 44 байт")
  .text.calib_engine__start_step 0x008dfd78 : { KEEP(*(.text.calib_engine__start_step)) }
  ASSERT(SIZEOF(.text.calib_engine__start_step) <= 96, "блок calib_engine__start_step не влезает в отведённые ему 96 байт")
  .text.calib_mngr__restart_scheme 0x008dfdd8 : { KEEP(*(.text.calib_mngr__restart_scheme)) }
  ASSERT(SIZEOF(.text.calib_mngr__restart_scheme) <= 40, "блок calib_mngr__restart_scheme не влезает в отведённые ему 40 байт")
  .text.SDP__sdp_drive_value 0x008dfe00 : { KEEP(*(.text.SDP__sdp_drive_value)) }
  ASSERT(SIZEOF(.text.SDP__sdp_drive_value) <= 84, "блок SDP__sdp_drive_value не влезает в отведённые ему 84 байт")
  .text.sdp_gpio__boot_init 0x008dfe54 : { KEEP(*(.text.sdp_gpio__boot_init)) }
  ASSERT(SIZEOF(.text.sdp_gpio__boot_init) <= 60, "блок sdp_gpio__boot_init не влезает в отведённые ему 60 байт")
  .text.SDP__sdp_init__2 0x008dfe90 : { KEEP(*(.text.SDP__sdp_init__2)) }
  ASSERT(SIZEOF(.text.SDP__sdp_init__2) <= 280, "блок SDP__sdp_init__2 не влезает в отведённые ему 280 байт")
  .text.SDP__sdp_is_in_use_sdp 0x008dffa8 : { KEEP(*(.text.SDP__sdp_is_in_use_sdp)) }
  ASSERT(SIZEOF(.text.SDP__sdp_is_in_use_sdp) <= 48, "блок SDP__sdp_is_in_use_sdp не влезает в отведённые ему 48 байт")
  .text.hw_personality_detect 0x008dffd8 : { KEEP(*(.text.hw_personality_detect)) }
  ASSERT(SIZEOF(.text.hw_personality_detect) <= 88, "блок hw_personality_detect не влезает в отведённые ему 88 байт")
  .text.find_mngr__search_start 0x008e0030 : { KEEP(*(.text.find_mngr__search_start)) }
  ASSERT(SIZEOF(.text.find_mngr__search_start) <= 104, "блок find_mngr__search_start не влезает в отведённые ему 104 байт")
  .text.find_mng__search 0x008e0098 : { KEEP(*(.text.find_mng__search)) }
  ASSERT(SIZEOF(.text.find_mng__search) <= 64, "блок find_mng__search не влезает в отведённые ему 64 байт")
  .text.find_sm__report_search_started 0x008e00d8 : { KEEP(*(.text.find_sm__report_search_started)) }
  ASSERT(SIZEOF(.text.find_sm__report_search_started) <= 20, "блок find_sm__report_search_started не влезает в отведённые ему 20 байт")
  .text.find_mngr__search_end 0x008e00ec : { KEEP(*(.text.find_mngr__search_end)) }
  ASSERT(SIZEOF(.text.find_mngr__search_end) <= 60, "блок find_mngr__search_end не влезает в отведённые ему 60 байт")
  .text.calib_lo_leakage_run 0x008e0128 : { KEEP(*(.text.calib_lo_leakage_run)) }
  ASSERT(SIZEOF(.text.calib_lo_leakage_run) <= 240, "блок calib_lo_leakage_run не влезает в отведённые ему 240 байт")
  .text.radio_mgr__request 0x008e0218 : { KEEP(*(.text.radio_mgr__request)) }
  ASSERT(SIZEOF(.text.radio_mgr__request) <= 92, "блок radio_mgr__request не влезает в отведённые ему 92 байт")
  .text.radio_vtbl__call_tune 0x008e0274 : { KEEP(*(.text.radio_vtbl__call_tune)) }
  ASSERT(SIZEOF(.text.radio_vtbl__call_tune) <= 44, "блок radio_vtbl__call_tune не влезает в отведённые ему 44 байт")
  .text.rm_main_sm__secondary_handle_free 0x008e02a0 : { KEEP(*(.text.rm_main_sm__secondary_handle_free)) }
  ASSERT(SIZEOF(.text.rm_main_sm__secondary_handle_free) <= 120, "блок rm_main_sm__secondary_handle_free не влезает в отведённые ему 120 байт")
  .text.calib_engine__on_step_done 0x008e0318 : { KEEP(*(.text.calib_engine__on_step_done)) }
  ASSERT(SIZEOF(.text.calib_engine__on_step_done) <= 56, "блок calib_engine__on_step_done не влезает в отведённые ему 56 байт")
  .text.radio_manager_main_sm__on_sec_tune 0x008e0350 : { KEEP(*(.text.radio_manager_main_sm__on_sec_tune)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_sec_tune) <= 36, "блок radio_manager_main_sm__on_sec_tune не влезает в отведённые ему 36 байт")
  .text.rm_main_sm__assert_line 0x008e0374 : { KEEP(*(.text.rm_main_sm__assert_line)) }
  ASSERT(SIZEOF(.text.rm_main_sm__assert_line) <= 24, "блок rm_main_sm__assert_line не влезает в отведённые ему 24 байт")
  .text.rm_main_sm__secondary_tune_done 0x008e038c : { KEEP(*(.text.rm_main_sm__secondary_tune_done)) }
  ASSERT(SIZEOF(.text.rm_main_sm__secondary_tune_done) <= 208, "блок rm_main_sm__secondary_tune_done не влезает в отведённые ему 208 байт")
  .text.frag_8e045c 0x008e045c : { KEEP(*(.text.frag_8e045c)) }
  ASSERT(SIZEOF(.text.frag_8e045c) <= 4, "блок frag_8e045c не влезает в отведённые ему 4 байт")
  .text.basic_if__post_event 0x008e0460 : { KEEP(*(.text.basic_if__post_event)) }
  ASSERT(SIZEOF(.text.basic_if__post_event) <= 44, "блок basic_if__post_event не влезает в отведённые ему 44 байт")
  .text.basic_if__mailbox_send 0x008e048c : { KEEP(*(.text.basic_if__mailbox_send)) }
  ASSERT(SIZEOF(.text.basic_if__mailbox_send) <= 212, "блок basic_if__mailbox_send не влезает в отведённые ему 212 байт")
  .text.ba_sm__send_addba_req 0x008e0560 : { KEEP(*(.text.ba_sm__send_addba_req)) }
  ASSERT(SIZEOF(.text.ba_sm__send_addba_req) <= 188, "блок ba_sm__send_addba_req не влезает в отведённые ему 188 байт")
  .text.l2mgr__send_ba_status_evt 0x008e061c : { KEEP(*(.text.l2mgr__send_ba_status_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_ba_status_evt) <= 120, "блок l2mgr__send_ba_status_evt не влезает в отведённые ему 120 байт")
  .text.send_cmd2_lmac 0x008e0694 : { KEEP(*(.text.send_cmd2_lmac)) }
  ASSERT(SIZEOF(.text.send_cmd2_lmac) <= 132, "блок send_cmd2_lmac не влезает в отведённые ему 132 байт")
  .text.lmac_if_send_cmd_0x1b 0x008e0718 : { KEEP(*(.text.lmac_if_send_cmd_0x1b)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x1b) <= 48, "блок lmac_if_send_cmd_0x1b не влезает в отведённые ему 48 байт")
  .text.TX_API__send_dband_bcon 0x008e0748 : { KEEP(*(.text.TX_API__send_dband_bcon)) }
  ASSERT(SIZEOF(.text.TX_API__send_dband_bcon) <= 112, "блок TX_API__send_dband_bcon не влезает в отведённые ему 112 байт")
  .text.ba_sm__send_delba 0x008e07b8 : { KEEP(*(.text.ba_sm__send_delba)) }
  ASSERT(SIZEOF(.text.ba_sm__send_delba) <= 140, "блок ba_sm__send_delba не влезает в отведённые ему 140 байт")
  .text.wmi_handler_echo 0x008e0844 : { KEEP(*(.text.wmi_handler_echo)) }
  ASSERT(SIZEOF(.text.wmi_handler_echo) <= 48, "блок wmi_handler_echo не влезает в отведённые ему 48 байт")
  .text.operational_if__send_evt 0x008e0874 : { KEEP(*(.text.operational_if__send_evt)) }
  ASSERT(SIZEOF(.text.operational_if__send_evt) <= 84, "блок operational_if__send_evt не влезает в отведённые ему 84 байт")
  .text.low_sme__send_evt2sw 0x008e08c8 : { KEEP(*(.text.low_sme__send_evt2sw)) }
  ASSERT(SIZEOF(.text.low_sme__send_evt2sw) <= 188, "блок low_sme__send_evt2sw не влезает в отведённые ему 188 байт")
  .text.lmac_echo__report_to_host 0x008e0984 : { KEEP(*(.text.lmac_echo__report_to_host)) }
  ASSERT(SIZEOF(.text.lmac_echo__report_to_host) <= 40, "блок lmac_echo__report_to_host не влезает в отведённые ему 40 байт")
  .text.wmi_handler_add_debug_tx_pckt 0x008e09ac : { KEEP(*(.text.wmi_handler_add_debug_tx_pckt)) }
  ASSERT(SIZEOF(.text.wmi_handler_add_debug_tx_pckt) <= 124, "блок wmi_handler_add_debug_tx_pckt не влезает в отведённые ему 124 байт")
  .text.fwq_tx__send_next 0x008e0a28 : { KEEP(*(.text.fwq_tx__send_next)) }
  ASSERT(SIZEOF(.text.fwq_tx__send_next) <= 88, "блок fwq_tx__send_next не влезает в отведённые ему 88 байт")
  .text.tx_api__prepare_descriptor 0x008e0a80 : { KEEP(*(.text.tx_api__prepare_descriptor)) }
  ASSERT(SIZEOF(.text.tx_api__prepare_descriptor) <= 184, "блок tx_api__prepare_descriptor не влезает в отведённые ему 184 байт")
  .text.SW_TX_MGMT_API__send_packet 0x008e0b38 : { KEEP(*(.text.SW_TX_MGMT_API__send_packet)) }
  ASSERT(SIZEOF(.text.SW_TX_MGMT_API__send_packet) <= 268, "блок SW_TX_MGMT_API__send_packet не влезает в отведённые ему 268 байт")
  .text.tx_api__send_mgmt 0x008e0c44 : { KEEP(*(.text.tx_api__send_mgmt)) }
  ASSERT(SIZEOF(.text.tx_api__send_mgmt) <= 48, "блок tx_api__send_mgmt не влезает в отведённые ему 48 байт")
  .text.TX_API__send_packet 0x008e0c74 : { KEEP(*(.text.TX_API__send_packet)) }
  ASSERT(SIZEOF(.text.TX_API__send_packet) <= 404, "блок TX_API__send_packet не влезает в отведённые ему 404 байт")
  .text.tx_api__send_mgmt_with_cb 0x008e0e08 : { KEEP(*(.text.tx_api__send_mgmt_with_cb)) }
  ASSERT(SIZEOF(.text.tx_api__send_mgmt_with_cb) <= 52, "блок tx_api__send_mgmt_with_cb не влезает в отведённые ему 52 байт")
  .text.sta_psc_sm__build_psc_req 0x008e0e3c : { KEEP(*(.text.sta_psc_sm__build_psc_req)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__build_psc_req) <= 200, "блок sta_psc_sm__build_psc_req не влезает в отведённые ему 200 байт")
  .text.sta_psc_sm__send_psc_req_flow_sm 0x008e0f04 : { KEEP(*(.text.sta_psc_sm__send_psc_req_flow_sm)) }
  ASSERT(SIZEOF(.text.sta_psc_sm__send_psc_req_flow_sm) <= 88, "блок sta_psc_sm__send_psc_req_flow_sm не влезает в отведённые ему 88 байт")
  .text.pcp_psc_sm__build_psc_resp 0x008e0f5c : { KEEP(*(.text.pcp_psc_sm__build_psc_resp)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__build_psc_resp) <= 152, "блок pcp_psc_sm__build_psc_resp не влезает в отведённые ему 152 байт")
  .text.pcp_psc_sm__send_psc_resp_flow 0x008e0ff4 : { KEEP(*(.text.pcp_psc_sm__send_psc_resp_flow)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__send_psc_resp_flow) <= 84, "блок pcp_psc_sm__send_psc_resp_flow не влезает в отведённые ему 84 байт")
  .text.low_sme__send_rf_mgmt_status 0x008e1048 : { KEEP(*(.text.low_sme__send_rf_mgmt_status)) }
  ASSERT(SIZEOF(.text.low_sme__send_rf_mgmt_status) <= 108, "блок low_sme__send_rf_mgmt_status не влезает в отведённые ему 108 байт")
  .text.pcp_psc_sm__send_usol_psc_resp_sm 0x008e10b4 : { KEEP(*(.text.pcp_psc_sm__send_usol_psc_resp_sm)) }
  ASSERT(SIZEOF(.text.pcp_psc_sm__send_usol_psc_resp_sm) <= 36, "блок pcp_psc_sm__send_usol_psc_resp_sm не влезает в отведённые ему 36 байт")
  .text.l2mgr__send_temp_sense_done 0x008e10d8 : { KEEP(*(.text.l2mgr__send_temp_sense_done)) }
  ASSERT(SIZEOF(.text.l2mgr__send_temp_sense_done) <= 84, "блок l2mgr__send_temp_sense_done не влезает в отведённые ему 84 байт")
  .text.ie_iter__init 0x008e112c : { KEEP(*(.text.ie_iter__init)) }
  ASSERT(SIZEOF(.text.ie_iter__init) <= 12, "блок ie_iter__init не влезает в отведённые ему 12 байт")
  .text.iter__init 0x008e1138 : { KEEP(*(.text.iter__init)) }
  ASSERT(SIZEOF(.text.iter__init) <= 8, "блок iter__init не влезает в отведённые ему 8 байт")
  .text.bitmap__init 0x008e1140 : { KEEP(*(.text.bitmap__init)) }
  ASSERT(SIZEOF(.text.bitmap__init) <= 4, "блок bitmap__init не влезает в отведённые ему 4 байт")
  .text.wmi_handler_get_rf_sector_params__set 0x008e1144 : { KEEP(*(.text.wmi_handler_get_rf_sector_params__set)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_rf_sector_params__set) <= 128, "блок wmi_handler_get_rf_sector_params__set не влезает в отведённые ему 128 байт")
  .text.wmi_handler_set_rf_sector_params__set 0x008e11c4 : { KEEP(*(.text.wmi_handler_set_rf_sector_params__set)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_rf_sector_params__set) <= 132, "блок wmi_handler_set_rf_sector_params__set не влезает в отведённые ему 132 байт")
  .text.mid_list__insert 0x008e1248 : { KEEP(*(.text.mid_list__insert)) }
  ASSERT(SIZEOF(.text.mid_list__insert) <= 64, "блок mid_list__insert не влезает в отведённые ему 64 байт")
  .text.wmi_handler_get_selected_rf_sector_index 0x008e1288 : { KEEP(*(.text.wmi_handler_get_selected_rf_sector_index)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_selected_rf_sector_index) <= 108, "блок wmi_handler_get_selected_rf_sector_index не влезает в отведённые ему 108 байт")
  .text.wmi_handler_set_selected_rf_sector_index 0x008e12f4 : { KEEP(*(.text.wmi_handler_set_selected_rf_sector_index)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_selected_rf_sector_index) <= 108, "блок wmi_handler_set_selected_rf_sector_index не влезает в отведённые ему 108 байт")
  .text.mid__setup_bcast_vring 0x008e1360 : { KEEP(*(.text.mid__setup_bcast_vring)) }
  ASSERT(SIZEOF(.text.mid__setup_bcast_vring) <= 160, "блок mid__setup_bcast_vring не влезает в отведённые ему 160 байт")
  .text.mid__attach_rx_pool 0x008e1400 : { KEEP(*(.text.mid__attach_rx_pool)) }
  ASSERT(SIZEOF(.text.mid__attach_rx_pool) <= 28, "блок mid__attach_rx_pool не влезает в отведённые ему 28 байт")
  .text.mid__set_rx_ring 0x008e141c : { KEEP(*(.text.mid__set_rx_ring)) }
  ASSERT(SIZEOF(.text.mid__set_rx_ring) <= 28, "блок mid__set_rx_ring не влезает в отведённые ему 28 байт")
  .text.app_ies__bind_buffer 0x008e1438 : { KEEP(*(.text.app_ies__bind_buffer)) }
  ASSERT(SIZEOF(.text.app_ies__bind_buffer) <= 12, "блок app_ies__bind_buffer не влезает в отведённые ему 12 байт")
  .text.u_schd__fill_task 0x008e1444 : { KEEP(*(.text.u_schd__fill_task)) }
  ASSERT(SIZEOF(.text.u_schd__fill_task) <= 20, "блок u_schd__fill_task не влезает в отведённые ему 20 байт")
  .text.mid__apply_app_ies 0x008e1458 : { KEEP(*(.text.mid__apply_app_ies)) }
  ASSERT(SIZEOF(.text.mid__apply_app_ies) <= 100, "блок mid__apply_app_ies не влезает в отведённые ему 100 байт")
  .text.set_app_ie 0x008e14bc : { KEEP(*(.text.set_app_ie)) }
  ASSERT(SIZEOF(.text.set_app_ie) <= 144, "блок set_app_ie не влезает в отведённые ему 144 байт")
  .text.agc_tbl__unpack_field16 0x008e154c : { KEEP(*(.text.agc_tbl__unpack_field16)) }
  ASSERT(SIZEOF(.text.agc_tbl__unpack_field16) <= 44, "блок agc_tbl__unpack_field16 не влезает в отведённые ему 44 байт")
  .text.calib_silent_rssi__write_reg 0x008e1578 : { KEEP(*(.text.calib_silent_rssi__write_reg)) }
  ASSERT(SIZEOF(.text.calib_silent_rssi__write_reg) <= 24, "блок calib_silent_rssi__write_reg не влезает в отведённые ему 24 байт")
  .text.mid__set_awake_window 0x008e1590 : { KEEP(*(.text.mid__set_awake_window)) }
  ASSERT(SIZEOF(.text.mid__set_awake_window) <= 12, "блок mid__set_awake_window не влезает в отведённые ему 12 байт")
  .text.set_g_8001f6_x2 0x008e159c : { KEEP(*(.text.set_g_8001f6_x2)) }
  ASSERT(SIZEOF(.text.set_g_8001f6_x2) <= 12, "блок set_g_8001f6_x2 не влезает в отведённые ему 12 байт")
  .text.conn_msm__rearm_assoc_timer 0x008e15a8 : { KEEP(*(.text.conn_msm__rearm_assoc_timer)) }
  ASSERT(SIZEOF(.text.conn_msm__rearm_assoc_timer) <= 56, "блок conn_msm__rearm_assoc_timer не влезает в отведённые ему 56 байт")
  .text.get_g_8000ac_8e15e0 0x008e15e0 : { KEEP(*(.text.get_g_8000ac_8e15e0)) }
  ASSERT(SIZEOF(.text.get_g_8000ac_8e15e0) <= 16, "блок get_g_8000ac_8e15e0 не влезает в отведённые ему 16 байт")
  .text.l2mgr__apply_mac_address 0x008e15f0 : { KEEP(*(.text.l2mgr__apply_mac_address)) }
  ASSERT(SIZEOF(.text.l2mgr__apply_mac_address) <= 52, "блок l2mgr__apply_mac_address не влезает в отведённые ему 52 байт")
  .text.set_g_8000bc 0x008e1624 : { KEEP(*(.text.set_g_8000bc)) }
  ASSERT(SIZEOF(.text.set_g_8000bc) <= 8, "блок set_g_8000bc не влезает в отведённые ему 8 байт")
  .text.lm_if__set_cid 0x008e162c : { KEEP(*(.text.lm_if__set_cid)) }
  ASSERT(SIZEOF(.text.lm_if__set_cid) <= 68, "блок lm_if__set_cid не влезает в отведённые ему 68 байт")
  .text.edca__set_default_ac_params 0x008e1684 : { KEEP(*(.text.edca__set_default_ac_params)) }
  ASSERT(SIZEOF(.text.edca__set_default_ac_params) <= 184, "блок edca__set_default_ac_params не влезает в отведённые ему 184 байт")
  .text.g_8035c8__set_defaults 0x008e173c : { KEEP(*(.text.g_8035c8__set_defaults)) }
  ASSERT(SIZEOF(.text.g_8035c8__set_defaults) <= 120, "блок g_8035c8__set_defaults не влезает в отведённые ему 120 байт")
  .text.l2mgr__build_mac_config 0x008e17b4 : { KEEP(*(.text.l2mgr__build_mac_config)) }
  ASSERT(SIZEOF(.text.l2mgr__build_mac_config) <= 228, "блок l2mgr__build_mac_config не влезает в отведённые ему 228 байт")
  .text.set_gtk 0x008e1898 : { KEEP(*(.text.set_gtk)) }
  ASSERT(SIZEOF(.text.set_gtk) <= 140, "блок set_gtk не влезает в отведённые ему 140 байт")
  .text.frag_8e1924 0x008e1924 : { KEEP(*(.text.frag_8e1924)) }
  ASSERT(SIZEOF(.text.frag_8e1924) <= 4, "блок frag_8e1924 не влезает в отведённые ему 4 байт")
  .text.set_g_80035c 0x008e1928 : { KEEP(*(.text.set_g_80035c)) }
  ASSERT(SIZEOF(.text.set_g_80035c) <= 12, "блок set_g_80035c не влезает в отведённые ему 12 байт")
  .text.set_g_80035c_8e1934 0x008e1934 : { KEEP(*(.text.set_g_80035c_8e1934)) }
  ASSERT(SIZEOF(.text.set_g_80035c_8e1934) <= 12, "блок set_g_80035c_8e1934 не влезает в отведённые ему 12 байт")
  .text.hwf__set_agc_index_1c 0x008e1940 : { KEEP(*(.text.hwf__set_agc_index_1c)) }
  ASSERT(SIZEOF(.text.hwf__set_agc_index_1c) <= 44, "блок hwf__set_agc_index_1c не влезает в отведённые ему 44 байт")
  .text.set_mem_85726c 0x008e196c : { KEEP(*(.text.set_mem_85726c)) }
  ASSERT(SIZEOF(.text.set_mem_85726c) <= 12, "блок set_mem_85726c не влезает в отведённые ему 12 байт")
  .text.conn_mgr__set_link_maintain_cfg 0x008e1978 : { KEEP(*(.text.conn_mgr__set_link_maintain_cfg)) }
  ASSERT(SIZEOF(.text.conn_mgr__set_link_maintain_cfg) <= 216, "блок conn_mgr__set_link_maintain_cfg не влезает в отведённые ему 216 байт")
  .text.set_g_80023d 0x008e1a50 : { KEEP(*(.text.set_g_80023d)) }
  ASSERT(SIZEOF(.text.set_g_80023d) <= 8, "блок set_g_80023d не влезает в отведённые ему 8 байт")
  .text.set_g_80023e 0x008e1a58 : { KEEP(*(.text.set_g_80023e)) }
  ASSERT(SIZEOF(.text.set_g_80023e) <= 8, "блок set_g_80023e не влезает в отведённые ему 8 байт")
  .text.set_g_80023f 0x008e1a60 : { KEEP(*(.text.set_g_80023f)) }
  ASSERT(SIZEOF(.text.set_g_80023f) <= 8, "блок set_g_80023f не влезает в отведённые ему 8 байт")
  .text.mac__apply_multicast_addr 0x008e1a68 : { KEEP(*(.text.mac__apply_multicast_addr)) }
  ASSERT(SIZEOF(.text.mac__apply_multicast_addr) <= 60, "блок mac__apply_multicast_addr не влезает в отведённые ему 60 байт")
  .text.tail_memcpy_fw 0x008e1aa4 : { KEEP(*(.text.tail_memcpy_fw)) }
  ASSERT(SIZEOF(.text.tail_memcpy_fw) <= 16, "блок tail_memcpy_fw не влезает в отведённые ему 16 байт")
  .text.set_g_800240 0x008e1ab4 : { KEEP(*(.text.set_g_800240)) }
  ASSERT(SIZEOF(.text.set_g_800240) <= 8, "блок set_g_800240 не влезает в отведённые ему 8 байт")
  .text.app_ies__set_probe_req_ies 0x008e1abc : { KEEP(*(.text.app_ies__set_probe_req_ies)) }
  ASSERT(SIZEOF(.text.app_ies__set_probe_req_ies) <= 64, "блок app_ies__set_probe_req_ies не влезает в отведённые ему 64 байт")
  .text.app_ies__set_buffer 0x008e1afc : { KEEP(*(.text.app_ies__set_buffer)) }
  ASSERT(SIZEOF(.text.app_ies__set_buffer) <= 56, "блок app_ies__set_buffer не влезает в отведённые ему 56 байт")
  .text.mid__log_network_type 0x008e1b34 : { KEEP(*(.text.mid__log_network_type)) }
  ASSERT(SIZEOF(.text.mid__log_network_type) <= 128, "блок mid__log_network_type не влезает в отведённые ему 128 байт")
  .text.set_old_wilocity_vs 0x008e1bb4 : { KEEP(*(.text.set_old_wilocity_vs)) }
  ASSERT(SIZEOF(.text.set_old_wilocity_vs) <= 112, "блок set_old_wilocity_vs не влезает в отведённые ему 112 байт")
  .text.frag_8e1c24 0x008e1c24 : { KEEP(*(.text.frag_8e1c24)) }
  ASSERT(SIZEOF(.text.frag_8e1c24) <= 12, "блок frag_8e1c24 не влезает в отведённые ему 12 байт")
  .text.set_parse_ei 0x008e1c30 : { KEEP(*(.text.set_parse_ei)) }
  ASSERT(SIZEOF(.text.set_parse_ei) <= 540, "блок set_parse_ei не влезает в отведённые ему 540 байт")
  .text.mid__refill_rx_buffers 0x008e1e4c : { KEEP(*(.text.mid__refill_rx_buffers)) }
  ASSERT(SIZEOF(.text.mid__refill_rx_buffers) <= 64, "блок mid__refill_rx_buffers не влезает в отведённые ему 64 байт")
  .text.mid__inject_sm_event 0x008e1e8c : { KEEP(*(.text.mid__inject_sm_event)) }
  ASSERT(SIZEOF(.text.mid__inject_sm_event) <= 76, "блок mid__inject_sm_event не влезает в отведённые ему 76 байт")
  .text.RADIO_MGR__set_primary_channel 0x008e1ed8 : { KEEP(*(.text.RADIO_MGR__set_primary_channel)) }
  ASSERT(SIZEOF(.text.RADIO_MGR__set_primary_channel) <= 76, "блок RADIO_MGR__set_primary_channel не влезает в отведённые ему 76 байт")
  .text.radio_manager_main_sm__on_primary_set__rm_st_prim_locked 0x008e1f24 : { KEEP(*(.text.radio_manager_main_sm__on_primary_set__rm_st_prim_locked)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_primary_set__rm_st_prim_locked) <= 24, "блок radio_manager_main_sm__on_primary_set__rm_st_prim_locked не влезает в отведённые ему 24 байт")
  .text.ps_cfg__load_profile 0x008e1f3c : { KEEP(*(.text.ps_cfg__load_profile)) }
  ASSERT(SIZEOF(.text.ps_cfg__load_profile) <= 80, "блок ps_cfg__load_profile не влезает в отведённые ему 80 байт")
  .text.ps_cfg__apply_profile 0x008e1f8c : { KEEP(*(.text.ps_cfg__apply_profile)) }
  ASSERT(SIZEOF(.text.ps_cfg__apply_profile) <= 92, "блок ps_cfg__apply_profile не влезает в отведённые ему 92 байт")
  .text.mid__replace_rsn_ie 0x008e1fe8 : { KEEP(*(.text.mid__replace_rsn_ie)) }
  ASSERT(SIZEOF(.text.mid__replace_rsn_ie) <= 100, "блок mid__replace_rsn_ie не влезает в отведённые ему 100 байт")
  .text.u_schd__fill_task_b 0x008e204c : { KEEP(*(.text.u_schd__fill_task_b)) }
  ASSERT(SIZEOF(.text.u_schd__fill_task_b) <= 12, "блок u_schd__fill_task_b не влезает в отведённые ему 12 байт")
  .text.vring_ba__build_cfg 0x008e2058 : { KEEP(*(.text.vring_ba__build_cfg)) }
  ASSERT(SIZEOF(.text.vring_ba__build_cfg) <= 104, "блок vring_ba__build_cfg не влезает в отведённые ему 104 байт")
  .text.basic_sm__store_pending_event 0x008e20c0 : { KEEP(*(.text.basic_sm__store_pending_event)) }
  ASSERT(SIZEOF(.text.basic_sm__store_pending_event) <= 64, "блок basic_sm__store_pending_event не влезает в отведённые ему 64 байт")
  .text.mid__set_ssid 0x008e2100 : { KEEP(*(.text.mid__set_ssid)) }
  ASSERT(SIZEOF(.text.mid__set_ssid) <= 24, "блок mid__set_ssid не влезает в отведённые ему 24 байт")
  .text.tail_basic_sm__defer_event 0x008e2118 : { KEEP(*(.text.tail_basic_sm__defer_event)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__defer_event) <= 4, "блок tail_basic_sm__defer_event не влезает в отведённые ему 4 байт")
  .text.mid__copy_bssid_8e211c 0x008e211c : { KEEP(*(.text.mid__copy_bssid_8e211c)) }
  ASSERT(SIZEOF(.text.mid__copy_bssid_8e211c) <= 16, "блок mid__copy_bssid_8e211c не влезает в отведённые ему 16 байт")
  .text.set_g_8001f4 0x008e212c : { KEEP(*(.text.set_g_8001f4)) }
  ASSERT(SIZEOF(.text.set_g_8001f4) <= 8, "блок set_g_8001f4 не влезает в отведённые ему 8 байт")
  .text.set_tk 0x008e2134 : { KEEP(*(.text.set_tk)) }
  ASSERT(SIZEOF(.text.set_tk) <= 112, "блок set_tk не влезает в отведённые ему 112 байт")
  .text.agc_tbl__unpack_field8 0x008e21a4 : { KEEP(*(.text.agc_tbl__unpack_field8)) }
  ASSERT(SIZEOF(.text.agc_tbl__unpack_field8) <= 44, "блок agc_tbl__unpack_field8 не влезает в отведённые ему 44 байт")
  .text.set_vendor_specific_version 0x008e21d0 : { KEEP(*(.text.set_vendor_specific_version)) }
  ASSERT(SIZEOF(.text.set_vendor_specific_version) <= 92, "блок set_vendor_specific_version не влезает в отведённые ему 92 байт")
  .text.wmi_handler_vring_switch_config 0x008e222c : { KEEP(*(.text.wmi_handler_vring_switch_config)) }
  ASSERT(SIZEOF(.text.wmi_handler_vring_switch_config) <= 68, "блок wmi_handler_vring_switch_config не влезает в отведённые ему 68 байт")
  .text.psc__copy_req_params 0x008e2270 : { KEEP(*(.text.psc__copy_req_params)) }
  ASSERT(SIZEOF(.text.psc__copy_req_params) <= 8, "блок psc__copy_req_params не влезает в отведённые ему 8 байт")
  .text.psc_if__copy_params 0x008e2278 : { KEEP(*(.text.psc_if__copy_params)) }
  ASSERT(SIZEOF(.text.psc_if__copy_params) <= 12, "блок psc_if__copy_params не влезает в отведённые ему 12 байт")
  .text.build_vendor_ie 0x008e2284 : { KEEP(*(.text.build_vendor_ie)) }
  ASSERT(SIZEOF(.text.build_vendor_ie) <= 192, "блок build_vendor_ie не влезает в отведённые ему 192 байт")
  .text.mem_pool__tag_block 0x008e2344 : { KEEP(*(.text.mem_pool__tag_block)) }
  ASSERT(SIZEOF(.text.mem_pool__tag_block) <= 44, "блок mem_pool__tag_block не влезает в отведённые ему 44 байт")
  .text.conn__update_metric 0x008e2370 : { KEEP(*(.text.conn__update_metric)) }
  ASSERT(SIZEOF(.text.conn__update_metric) <= 28, "блок conn__update_metric не влезает в отведённые ему 28 байт")
  .text.conn_mgr__arm_all_retry_timers 0x008e238c : { KEEP(*(.text.conn_mgr__arm_all_retry_timers)) }
  ASSERT(SIZEOF(.text.conn_mgr__arm_all_retry_timers) <= 40, "блок conn_mgr__arm_all_retry_timers не влезает в отведённые ему 40 байт")
  .text.connection__reset_metrics 0x008e23b4 : { KEEP(*(.text.connection__reset_metrics)) }
  ASSERT(SIZEOF(.text.connection__reset_metrics) <= 44, "блок connection__reset_metrics не влезает в отведённые ему 44 байт")
  .text.conn__push_metric_sample 0x008e23e0 : { KEEP(*(.text.conn__push_metric_sample)) }
  ASSERT(SIZEOF(.text.conn__push_metric_sample) <= 72, "блок conn__push_metric_sample не влезает в отведённые ему 72 байт")
  .text.conn__metric_average 0x008e2428 : { KEEP(*(.text.conn__metric_average)) }
  ASSERT(SIZEOF(.text.conn__metric_average) <= 20, "блок conn__metric_average не влезает в отведённые ему 20 байт")
  .text.get_g_800450 0x008e243c : { KEEP(*(.text.get_g_800450)) }
  ASSERT(SIZEOF(.text.get_g_800450) <= 24, "блок get_g_800450 не влезает в отведённые ему 24 байт")
  .text.u_schd__large_task_warn 0x008e2454 : { KEEP(*(.text.u_schd__large_task_warn)) }
  ASSERT(SIZEOF(.text.u_schd__large_task_warn) <= 164, "блок u_schd__large_task_warn не влезает в отведённые ему 164 байт")
  .text.link_stats_sm__started 0x008e24f8 : { KEEP(*(.text.link_stats_sm__started)) }
  ASSERT(SIZEOF(.text.link_stats_sm__started) <= 120, "блок link_stats_sm__started не влезает в отведённые ему 120 байт")
  .text.periodic_service__start 0x008e2570 : { KEEP(*(.text.periodic_service__start)) }
  ASSERT(SIZEOF(.text.periodic_service__start) <= 108, "блок periodic_service__start не влезает в отведённые ему 108 байт")
  .text.temp_sense__sample_if_due 0x008e25dc : { KEEP(*(.text.temp_sense__sample_if_due)) }
  ASSERT(SIZEOF(.text.temp_sense__sample_if_due) <= 72, "блок temp_sense__sample_if_due не влезает в отведённые ему 72 байт")
  .text.fwq_tx__enable_queue 0x008e2624 : { KEEP(*(.text.fwq_tx__enable_queue)) }
  ASSERT(SIZEOF(.text.fwq_tx__enable_queue) <= 68, "блок fwq_tx__enable_queue не влезает в отведённые ему 68 байт")
  .text.l2mgr__on_lmac_ready 0x008e2668 : { KEEP(*(.text.l2mgr__on_lmac_ready)) }
  ASSERT(SIZEOF(.text.l2mgr__on_lmac_ready) <= 20, "блок l2mgr__on_lmac_ready не влезает в отведённые ему 20 байт")
  .text.vring_schd__fill_vring_cfg 0x008e267c : { KEEP(*(.text.vring_schd__fill_vring_cfg)) }
  ASSERT(SIZEOF(.text.vring_schd__fill_vring_cfg) <= 124, "блок vring_schd__fill_vring_cfg не влезает в отведённые ему 124 байт")
  .text.ba_sm__on_ready_to_run__ba_setup_state 0x008e26f8 : { KEEP(*(.text.ba_sm__on_ready_to_run__ba_setup_state)) }
  ASSERT(SIZEOF(.text.ba_sm__on_ready_to_run__ba_setup_state) <= 32, "блок ba_sm__on_ready_to_run__ba_setup_state не влезает в отведённые ему 32 байт")
  .text.ba_sm__on_ready_to_run__ba_teardown_state 0x008e2718 : { KEEP(*(.text.ba_sm__on_ready_to_run__ba_teardown_state)) }
  ASSERT(SIZEOF(.text.ba_sm__on_ready_to_run__ba_teardown_state) <= 16, "блок ba_sm__on_ready_to_run__ba_teardown_state не влезает в отведённые ему 16 байт")
  .text.rm_ch_switch__resume_tx_queue 0x008e2728 : { KEEP(*(.text.rm_ch_switch__resume_tx_queue)) }
  ASSERT(SIZEOF(.text.rm_ch_switch__resume_tx_queue) <= 48, "блок rm_ch_switch__resume_tx_queue не влезает в отведённые ему 48 байт")
  .text.tail_conn_mgr__ranking_remove 0x008e2758 : { KEEP(*(.text.tail_conn_mgr__ranking_remove)) }
  ASSERT(SIZEOF(.text.tail_conn_mgr__ranking_remove) <= 4, "блок tail_conn_mgr__ranking_remove не влезает в отведённые ему 4 байт")
  .text.conn_main_sm__start_disc 0x008e275c : { KEEP(*(.text.conn_main_sm__start_disc)) }
  ASSERT(SIZEOF(.text.conn_main_sm__start_disc) <= 72, "блок conn_main_sm__start_disc не влезает в отведённые ему 72 байт")
  .text.calib_engine__post_event 0x008e27a4 : { KEEP(*(.text.calib_engine__post_event)) }
  ASSERT(SIZEOF(.text.calib_engine__post_event) <= 132, "блок calib_engine__post_event не влезает в отведённые ему 132 байт")
  .text.tail_8e2828 0x008e2828 : { KEEP(*(.text.tail_8e2828)) }
  ASSERT(SIZEOF(.text.tail_8e2828) <= 4, "блок tail_8e2828 не влезает в отведённые ему 4 байт")
  .text.conn_msm__on_own_start_link__unresourced 0x008e282c : { KEEP(*(.text.conn_msm__on_own_start_link__unresourced)) }
  ASSERT(SIZEOF(.text.conn_msm__on_own_start_link__unresourced) <= 72, "блок conn_msm__on_own_start_link__unresourced не влезает в отведённые ему 72 байт")
  .text.lm_if__start_link_loss_monitoring 0x008e2874 : { KEEP(*(.text.lm_if__start_link_loss_monitoring)) }
  ASSERT(SIZEOF(.text.lm_if__start_link_loss_monitoring) <= 80, "блок lm_if__start_link_loss_monitoring не влезает в отведённые ему 80 байт")
  .text.frag_8e28c4 0x008e28c4 : { KEEP(*(.text.frag_8e28c4)) }
  ASSERT(SIZEOF(.text.frag_8e28c4) <= 4, "блок frag_8e28c4 не влезает в отведённые ему 4 байт")
  .text.lm_main_sm__on_start_maintain_req 0x008e28c8 : { KEEP(*(.text.lm_main_sm__on_start_maintain_req)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_start_maintain_req) <= 16, "блок lm_main_sm__on_start_maintain_req не влезает в отведённые ему 16 байт")
  .text.bad_beacons_detector__arm 0x008e28d8 : { KEEP(*(.text.bad_beacons_detector__arm)) }
  ASSERT(SIZEOF(.text.bad_beacons_detector__arm) <= 20, "блок bad_beacons_detector__arm не влезает в отведённые ему 20 байт")
  .text.ka_necessity_detector__start_monitoring 0x008e28ec : { KEEP(*(.text.ka_necessity_detector__start_monitoring)) }
  ASSERT(SIZEOF(.text.ka_necessity_detector__start_monitoring) <= 232, "блок ka_necessity_detector__start_monitoring не влезает в отведённые ему 232 байт")
  .text.tx_ppdu_ageing_timeout_detector__start_monitoring 0x008e29d4 : { KEEP(*(.text.tx_ppdu_ageing_timeout_detector__start_monitoring)) }
  ASSERT(SIZEOF(.text.tx_ppdu_ageing_timeout_detector__start_monitoring) <= 184, "блок tx_ppdu_ageing_timeout_detector__start_monitoring не влезает в отведённые ему 184 байт")
  .text.find_mngr__session_start 0x008e2a8c : { KEEP(*(.text.find_mngr__session_start)) }
  ASSERT(SIZEOF(.text.find_mngr__session_start) <= 52, "блок find_mngr__session_start не влезает в отведённые ему 52 байт")
  .text.ba_td_subsm__on_ready_to_run 0x008e2ac0 : { KEEP(*(.text.ba_td_subsm__on_ready_to_run)) }
  ASSERT(SIZEOF(.text.ba_td_subsm__on_ready_to_run) <= 40, "блок ba_td_subsm__on_ready_to_run не влезает в отведённые ему 40 байт")
  .text.link_stats__report 0x008e2ae8 : { KEEP(*(.text.link_stats__report)) }
  ASSERT(SIZEOF(.text.link_stats__report) <= 624, "блок link_stats__report не влезает в отведённые ему 624 байт")
  .text.link_stats_sm__on_stop 0x008e2d58 : { KEEP(*(.text.link_stats_sm__on_stop)) }
  ASSERT(SIZEOF(.text.link_stats_sm__on_stop) <= 44, "блок link_stats_sm__on_stop не влезает в отведённые ему 44 байт")
  .text.detector__arm_timer 0x008e2d84 : { KEEP(*(.text.detector__arm_timer)) }
  ASSERT(SIZEOF(.text.detector__arm_timer) <= 24, "блок detector__arm_timer не влезает в отведённые ему 24 байт")
  .text.temp_sense__stop 0x008e2d9c : { KEEP(*(.text.temp_sense__stop)) }
  ASSERT(SIZEOF(.text.temp_sense__stop) <= 32, "блок temp_sense__stop не влезает в отведённые ему 32 байт")
  .text.frag_8e2dbc 0x008e2dbc : { KEEP(*(.text.frag_8e2dbc)) }
  ASSERT(SIZEOF(.text.frag_8e2dbc) <= 64, "блок frag_8e2dbc не влезает в отведённые ему 64 байт")
  .text.find_mngr__stop 0x008e2dfc : { KEEP(*(.text.find_mngr__stop)) }
  ASSERT(SIZEOF(.text.find_mngr__stop) <= 52, "блок find_mngr__stop не влезает в отведённые ему 52 байт")
  .text.tx_api__pause_for_ch_switch 0x008e2e30 : { KEEP(*(.text.tx_api__pause_for_ch_switch)) }
  ASSERT(SIZEOF(.text.tx_api__pause_for_ch_switch) <= 72, "блок tx_api__pause_for_ch_switch не влезает в отведённые ему 72 байт")
  .text.dma_mgr__reset_queue 0x008e2e78 : { KEEP(*(.text.dma_mgr__reset_queue)) }
  ASSERT(SIZEOF(.text.dma_mgr__reset_queue) <= 48, "блок dma_mgr__reset_queue не влезает в отведённые ему 48 байт")
  .text.ret_one_8e2ea8 0x008e2ea8 : { KEEP(*(.text.ret_one_8e2ea8)) }
  ASSERT(SIZEOF(.text.ret_one_8e2ea8) <= 4, "блок ret_one_8e2ea8 не влезает в отведённые ему 4 байт")
  .text.lm_main_sm__set_bf_cfg 0x008e2eac : { KEEP(*(.text.lm_main_sm__set_bf_cfg)) }
  ASSERT(SIZEOF(.text.lm_main_sm__set_bf_cfg) <= 28, "блок lm_main_sm__set_bf_cfg не влезает в отведённые ему 28 байт")
  .text.conn__stop_link_loss_monitoring 0x008e2ec8 : { KEEP(*(.text.conn__stop_link_loss_monitoring)) }
  ASSERT(SIZEOF(.text.conn__stop_link_loss_monitoring) <= 8, "блок conn__stop_link_loss_monitoring не влезает в отведённые ему 8 байт")
  .text.lm_if__stop_link_loss_monitoring 0x008e2ed0 : { KEEP(*(.text.lm_if__stop_link_loss_monitoring)) }
  ASSERT(SIZEOF(.text.lm_if__stop_link_loss_monitoring) <= 72, "блок lm_if__stop_link_loss_monitoring не влезает в отведённые ему 72 байт")
  .text.frag_8e2f18 0x008e2f18 : { KEEP(*(.text.frag_8e2f18)) }
  ASSERT(SIZEOF(.text.frag_8e2f18) <= 4, "блок frag_8e2f18 не влезает в отведённые ему 4 байт")
  .text.lm_main_sm__on_stop_link 0x008e2f1c : { KEEP(*(.text.lm_main_sm__on_stop_link)) }
  ASSERT(SIZEOF(.text.lm_main_sm__on_stop_link) <= 16, "блок lm_main_sm__on_stop_link не влезает в отведённые ему 16 байт")
  .text.lm_if__on_data_stopped 0x008e2f2c : { KEEP(*(.text.lm_if__on_data_stopped)) }
  ASSERT(SIZEOF(.text.lm_if__on_data_stopped) <= 68, "блок lm_if__on_data_stopped не влезает в отведённые ему 68 байт")
  .text.bad_beacons_detector__stop_monitoring 0x008e2f70 : { KEEP(*(.text.bad_beacons_detector__stop_monitoring)) }
  ASSERT(SIZEOF(.text.bad_beacons_detector__stop_monitoring) <= 28, "блок bad_beacons_detector__stop_monitoring не влезает в отведённые ему 28 байт")
  .text.ka_detector__rearm 0x008e2f8c : { KEEP(*(.text.ka_detector__rearm)) }
  ASSERT(SIZEOF(.text.ka_detector__rearm) <= 28, "блок ka_detector__rearm не влезает в отведённые ему 28 байт")
  .text.ageing_detector__rearm 0x008e2fa8 : { KEEP(*(.text.ageing_detector__rearm)) }
  ASSERT(SIZEOF(.text.ageing_detector__rearm) <= 28, "блок ageing_detector__rearm не влезает в отведённые ему 28 байт")
  .text.find_sm__stop_discovery 0x008e2fc4 : { KEEP(*(.text.find_sm__stop_discovery)) }
  ASSERT(SIZEOF(.text.find_sm__stop_discovery) <= 40, "блок find_sm__stop_discovery не влезает в отведённые ему 40 байт")
  .text.tail_sm_pring__state_step 0x008e2fec : { KEEP(*(.text.tail_sm_pring__state_step)) }
  ASSERT(SIZEOF(.text.tail_sm_pring__state_step) <= 4, "блок tail_sm_pring__state_step не влезает в отведённые ему 4 байт")
  .text.vring_schd__stop_vring 0x008e2ff0 : { KEEP(*(.text.vring_schd__stop_vring)) }
  ASSERT(SIZEOF(.text.vring_schd__stop_vring) <= 212, "блок vring_schd__stop_vring не влезает в отведённые ему 212 байт")
  .text.lm_main_sm__inject_conn_evt3 0x008e30c4 : { KEEP(*(.text.lm_main_sm__inject_conn_evt3)) }
  ASSERT(SIZEOF(.text.lm_main_sm__inject_conn_evt3) <= 8, "блок lm_main_sm__inject_conn_evt3 не влезает в отведённые ему 8 байт")
  .text.STREAM_MGR__2 0x008e30cc : { KEEP(*(.text.STREAM_MGR__2)) }
  ASSERT(SIZEOF(.text.STREAM_MGR__2) <= 124, "блок STREAM_MGR__2 не влезает в отведённые ему 124 байт")
  .text.vring__on_macq_delete_ntf 0x008e3148 : { KEEP(*(.text.vring__on_macq_delete_ntf)) }
  ASSERT(SIZEOF(.text.vring__on_macq_delete_ntf) <= 216, "блок vring__on_macq_delete_ntf не влезает в отведённые ему 216 байт")
  .text.discovery__ssid_matches 0x008e3220 : { KEEP(*(.text.discovery__ssid_matches)) }
  ASSERT(SIZEOF(.text.discovery__ssid_matches) <= 48, "блок discovery__ssid_matches не влезает в отведённые ему 48 байт")
  .text.stream__inject_evt1 0x008e3250 : { KEEP(*(.text.stream__inject_evt1)) }
  ASSERT(SIZEOF(.text.stream__inject_evt1) <= 12, "блок stream__inject_evt1 не влезает в отведённые ему 12 байт")
  .text.ber_test__measure 0x008e325c : { KEEP(*(.text.ber_test__measure)) }
  ASSERT(SIZEOF(.text.ber_test__measure) <= 116, "блок ber_test__measure не влезает в отведённые ему 116 байт")
  .text.radio_manager_main_sm__on_switch_2_primary 0x008e32d0 : { KEEP(*(.text.radio_manager_main_sm__on_switch_2_primary)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_switch_2_primary) <= 36, "блок radio_manager_main_sm__on_switch_2_primary не влезает в отведённые ему 36 байт")
  .text.switch_2_secondary 0x008e32f4 : { KEEP(*(.text.switch_2_secondary)) }
  ASSERT(SIZEOF(.text.switch_2_secondary) <= 68, "блок switch_2_secondary не влезает в отведённые ему 68 байт")
  .text.PS_CFG_SCHEME__switch_active_ps_profile 0x008e3338 : { KEEP(*(.text.PS_CFG_SCHEME__switch_active_ps_profile)) }
  ASSERT(SIZEOF(.text.PS_CFG_SCHEME__switch_active_ps_profile) <= 144, "блок PS_CFG_SCHEME__switch_active_ps_profile не влезает в отведённые ему 144 байт")
  .text.rm_ch_switch_sm__switch_on 0x008e33c8 : { KEEP(*(.text.rm_ch_switch_sm__switch_on)) }
  ASSERT(SIZEOF(.text.rm_ch_switch_sm__switch_on) <= 144, "блок rm_ch_switch_sm__switch_on не влезает в отведённые ему 144 байт")
  .text.set_reg_886d80_8e3458 0x008e3458 : { KEEP(*(.text.set_reg_886d80_8e3458)) }
  ASSERT(SIZEOF(.text.set_reg_886d80_8e3458) <= 24, "блок set_reg_886d80_8e3458 не влезает в отведённые ему 24 байт")
  .text.set_reg_886d80_8e3470 0x008e3470 : { KEEP(*(.text.set_reg_886d80_8e3470)) }
  ASSERT(SIZEOF(.text.set_reg_886d80_8e3470) <= 24, "блок set_reg_886d80_8e3470 не влезает в отведённые ему 24 байт")
  .text.sta_trace__push_record 0x008e3488 : { KEEP(*(.text.sta_trace__push_record)) }
  ASSERT(SIZEOF(.text.sta_trace__push_record) <= 92, "блок sta_trace__push_record не влезает в отведённые ему 92 байт")
  .text.sta_ctx__reset 0x008e34e4 : { KEEP(*(.text.sta_ctx__reset)) }
  ASSERT(SIZEOF(.text.sta_ctx__reset) <= 56, "блок sta_ctx__reset не влезает в отведённые ему 56 байт")
  .text.tail_pcie__set_event_bit_8e351c 0x008e351c : { KEEP(*(.text.tail_pcie__set_event_bit_8e351c)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8e351c) <= 4, "блок tail_pcie__set_event_bit_8e351c не влезает в отведённые ему 4 байт")
  .text.tail_pcie__set_event_bit_8e3520 0x008e3520 : { KEEP(*(.text.tail_pcie__set_event_bit_8e3520)) }
  ASSERT(SIZEOF(.text.tail_pcie__set_event_bit_8e3520) <= 4, "блок tail_pcie__set_event_bit_8e3520 не влезает в отведённые ему 4 байт")
  .text.boot__publish_ids 0x008e3524 : { KEEP(*(.text.boot__publish_ids)) }
  ASSERT(SIZEOF(.text.boot__publish_ids) <= 92, "блок boot__publish_ids не влезает в отведённые ему 92 байт")
  .text.get_reg_880b80 0x008e3580 : { KEEP(*(.text.get_reg_880b80)) }
  ASSERT(SIZEOF(.text.get_reg_880b80) <= 28, "блок get_reg_880b80 не влезает в отведённые ему 28 байт")
  .text.user_lfsr__configure 0x008e359c : { KEEP(*(.text.user_lfsr__configure)) }
  ASSERT(SIZEOF(.text.user_lfsr__configure) <= 48, "блок user_lfsr__configure не влезает в отведённые ему 48 байт")
  .text.set_reg_880a44 0x008e35cc : { KEEP(*(.text.set_reg_880a44)) }
  ASSERT(SIZEOF(.text.set_reg_880a44) <= 12, "блок set_reg_880a44 не влезает в отведённые ему 12 байт")
  .text.set_reg_880a48 0x008e35d8 : { KEEP(*(.text.set_reg_880a48)) }
  ASSERT(SIZEOF(.text.set_reg_880a48) <= 12, "блок set_reg_880a48 не влезает в отведённые ему 12 байт")
  .text.assert__restore_hw_for_dump 0x008e35e4 : { KEEP(*(.text.assert__restore_hw_for_dump)) }
  ASSERT(SIZEOF(.text.assert__restore_hw_for_dump) <= 32, "блок assert__restore_hw_for_dump не влезает в отведённые ему 32 байт")
  .text.assert__dump_dma_and_mac 0x008e3604 : { KEEP(*(.text.assert__dump_dma_and_mac)) }
  ASSERT(SIZEOF(.text.assert__dump_dma_and_mac) <= 16, "блок assert__dump_dma_and_mac не влезает в отведённые ему 16 байт")
  .text.CALIB_MNGR__system_state_evt_handler 0x008e3614 : { KEEP(*(.text.CALIB_MNGR__system_state_evt_handler)) }
  ASSERT(SIZEOF(.text.CALIB_MNGR__system_state_evt_handler) <= 256, "блок CALIB_MNGR__system_state_evt_handler не влезает в отведённые ему 256 байт")
  .text.POWER_MNGR__system_state_evt_handler 0x008e3714 : { KEEP(*(.text.POWER_MNGR__system_state_evt_handler)) }
  ASSERT(SIZEOF(.text.POWER_MNGR__system_state_evt_handler) <= 308, "блок POWER_MNGR__system_state_evt_handler не влезает в отведённые ему 308 байт")
  .text.frag_8e3848 0x008e3848 : { KEEP(*(.text.frag_8e3848)) }
  ASSERT(SIZEOF(.text.frag_8e3848) <= 12, "блок frag_8e3848 не влезает в отведённые ему 12 байт")
  .text.get_g_800118_8e3854 0x008e3854 : { KEEP(*(.text.get_g_800118_8e3854)) }
  ASSERT(SIZEOF(.text.get_g_800118_8e3854) <= 12, "блок get_g_800118_8e3854 не влезает в отведённые ему 12 байт")
  .text.get_g_800118_8e3860 0x008e3860 : { KEEP(*(.text.get_g_800118_8e3860)) }
  ASSERT(SIZEOF(.text.get_g_800118_8e3860) <= 8, "блок get_g_800118_8e3860 не влезает в отведённые ему 8 байт")
  .text.get_g_800118_8e3868 0x008e3868 : { KEEP(*(.text.get_g_800118_8e3868)) }
  ASSERT(SIZEOF(.text.get_g_800118_8e3868) <= 12, "блок get_g_800118_8e3868 не влезает в отведённые ему 12 байт")
  .text.get_g_800118_8e3874 0x008e3874 : { KEEP(*(.text.get_g_800118_8e3874)) }
  ASSERT(SIZEOF(.text.get_g_800118_8e3874) <= 12, "блок get_g_800118_8e3874 не влезает в отведённые ему 12 байт")
  .text.phy_monitor__on_system_state 0x008e3880 : { KEEP(*(.text.phy_monitor__on_system_state)) }
  ASSERT(SIZEOF(.text.phy_monitor__on_system_state) <= 124, "блок phy_monitor__on_system_state не влезает в отведённые ему 124 байт")
  .text.temp_sense__on_system_state 0x008e38fc : { KEEP(*(.text.temp_sense__on_system_state)) }
  ASSERT(SIZEOF(.text.temp_sense__on_system_state) <= 80, "блок temp_sense__on_system_state не влезает в отведённые ему 80 байт")
  .text.conn_mgr__system_state_evt_handler 0x008e394c : { KEEP(*(.text.conn_mgr__system_state_evt_handler)) }
  ASSERT(SIZEOF(.text.conn_mgr__system_state_evt_handler) <= 188, "блок conn_mgr__system_state_evt_handler не влезает в отведённые ему 188 байт")
  .text.L2MGR__system_state_evt_handler 0x008e3a08 : { KEEP(*(.text.L2MGR__system_state_evt_handler)) }
  ASSERT(SIZEOF(.text.L2MGR__system_state_evt_handler) <= 148, "блок L2MGR__system_state_evt_handler не влезает в отведённые ему 148 байт")
  .text.frag_8e3a9c 0x008e3a9c : { KEEP(*(.text.frag_8e3a9c)) }
  ASSERT(SIZEOF(.text.frag_8e3a9c) <= 4, "блок frag_8e3a9c не влезает в отведённые ему 4 байт")
  .text.vring_schd__vring_task 0x008e3aa0 : { KEEP(*(.text.vring_schd__vring_task)) }
  ASSERT(SIZEOF(.text.vring_schd__vring_task) <= 80, "блок vring_schd__vring_task не влезает в отведённые ему 80 байт")
  .text.phy_monitor__task_step 0x008e3af0 : { KEEP(*(.text.phy_monitor__task_step)) }
  ASSERT(SIZEOF(.text.phy_monitor__task_step) <= 388, "блок phy_monitor__task_step не влезает в отведённые ему 388 байт")
  .text.ka_necessity_detector__task 0x008e3c74 : { KEEP(*(.text.ka_necessity_detector__task)) }
  ASSERT(SIZEOF(.text.ka_necessity_detector__task) <= 608, "блок ka_necessity_detector__task не влезает в отведённые ему 608 байт")
  .text.tx_ppdu_ageing_timeout_detector__task 0x008e3ed4 : { KEEP(*(.text.tx_ppdu_ageing_timeout_detector__task)) }
  ASSERT(SIZEOF(.text.tx_ppdu_ageing_timeout_detector__task) <= 824, "блок tx_ppdu_ageing_timeout_detector__task не влезает в отведённые ему 824 байт")
  .text.wmi_handler_temp_sense 0x008e420c : { KEEP(*(.text.wmi_handler_temp_sense)) }
  ASSERT(SIZEOF(.text.wmi_handler_temp_sense) <= 96, "блок wmi_handler_temp_sense не влезает в отведённые ему 96 байт")
  .text.low_sme__termination_check 0x008e426c : { KEEP(*(.text.low_sme__termination_check)) }
  ASSERT(SIZEOF(.text.low_sme__termination_check) <= 84, "блок low_sme__termination_check не влезает в отведённые ему 84 байт")
  .text.set_reg_88024c 0x008e42c0 : { KEEP(*(.text.set_reg_88024c)) }
  ASSERT(SIZEOF(.text.set_reg_88024c) <= 12, "блок set_reg_88024c не влезает в отведённые ему 12 байт")
  .text.get_reg_880254 0x008e42cc : { KEEP(*(.text.get_reg_880254)) }
  ASSERT(SIZEOF(.text.get_reg_880254) <= 12, "блок get_reg_880254 не влезает в отведённые ему 12 байт")
  .text.set_reg_880200_8e42d8 0x008e42d8 : { KEEP(*(.text.set_reg_880200_8e42d8)) }
  ASSERT(SIZEOF(.text.set_reg_880200_8e42d8) <= 24, "блок set_reg_880200_8e42d8 не влезает в отведённые ему 24 байт")
  .text.irq_ack_880b00 0x008e42f0 : { KEEP(*(.text.irq_ack_880b00)) }
  ASSERT(SIZEOF(.text.irq_ack_880b00) <= 20, "блок irq_ack_880b00 не влезает в отведённые ему 20 байт")
  .text.set_reg_880200_8e4304 0x008e4304 : { KEEP(*(.text.set_reg_880200_8e4304)) }
  ASSERT(SIZEOF(.text.set_reg_880200_8e4304) <= 24, "блок set_reg_880200_8e4304 не влезает в отведённые ему 24 байт")
  .text.time_cmp 0x008e431c : { KEEP(*(.text.time_cmp)) }
  ASSERT(SIZEOF(.text.time_cmp) <= 24, "блок time_cmp не влезает в отведённые ему 24 байт")
  .text.calib_engine__schedule_all_schemes 0x008e4334 : { KEEP(*(.text.calib_engine__schedule_all_schemes)) }
  ASSERT(SIZEOF(.text.calib_engine__schedule_all_schemes) <= 40, "блок calib_engine__schedule_all_schemes не влезает в отведённые ему 40 байт")
  .text.u_schd__reschedule 0x008e435c : { KEEP(*(.text.u_schd__reschedule)) }
  ASSERT(SIZEOF(.text.u_schd__reschedule) <= 108, "блок u_schd__reschedule не влезает в отведённые ему 108 байт")
  .text.sm_pring__timeout 0x008e43c8 : { KEEP(*(.text.sm_pring__timeout)) }
  ASSERT(SIZEOF(.text.sm_pring__timeout) <= 488, "блок sm_pring__timeout не влезает в отведённые ему 488 байт")
  .text.timer_exp_handler 0x008e45b0 : { KEEP(*(.text.timer_exp_handler)) }
  ASSERT(SIZEOF(.text.timer_exp_handler) <= 96, "блок timer_exp_handler не влезает в отведённые ему 96 байт")
  .text.timer__start 0x008e4610 : { KEEP(*(.text.timer__start)) }
  ASSERT(SIZEOF(.text.timer__start) <= 84, "блок timer__start не влезает в отведённые ему 84 байт")
  .text.tail_irq_ack_880b00 0x008e4664 : { KEEP(*(.text.tail_irq_ack_880b00)) }
  ASSERT(SIZEOF(.text.tail_irq_ack_880b00) <= 4, "блок tail_irq_ack_880b00 не влезает в отведённые ему 4 байт")
  .text.irq_cause__bit2 0x008e4668 : { KEEP(*(.text.irq_cause__bit2)) }
  ASSERT(SIZEOF(.text.irq_cause__bit2) <= 8, "блок irq_cause__bit2 не влезает в отведённые ему 8 байт")
  .text.fw_set_timer_alarm 0x008e4670 : { KEEP(*(.text.fw_set_timer_alarm)) }
  ASSERT(SIZEOF(.text.fw_set_timer_alarm) <= 8, "блок fw_set_timer_alarm не влезает в отведённые ему 8 байт")
  .text.power__enter_halt 0x008e4678 : { KEEP(*(.text.power__enter_halt)) }
  ASSERT(SIZEOF(.text.power__enter_halt) <= 28, "блок power__enter_halt не влезает в отведённые ему 28 байт")
  .text.fw_read_timer 0x008e4694 : { KEEP(*(.text.fw_read_timer)) }
  ASSERT(SIZEOF(.text.fw_read_timer) <= 8, "блок fw_read_timer не влезает в отведённые ему 8 байт")
  .text.tail_u_schd__tick 0x008e469c : { KEEP(*(.text.tail_u_schd__tick)) }
  ASSERT(SIZEOF(.text.tail_u_schd__tick) <= 4, "блок tail_u_schd__tick не влезает в отведённые ему 4 байт")
  .text.power__start_two_timers 0x008e46a0 : { KEEP(*(.text.power__start_two_timers)) }
  ASSERT(SIZEOF(.text.power__start_two_timers) <= 40, "блок power__start_two_timers не влезает в отведённые ему 40 байт")
  .text.power_halt__start_timer 0x008e46c8 : { KEEP(*(.text.power_halt__start_timer)) }
  ASSERT(SIZEOF(.text.power_halt__start_timer) <= 40, "блок power_halt__start_timer не влезает в отведённые ему 40 байт")
  .text.tail_l2mgr__send_traffic_deferral_evt 0x008e46f0 : { KEEP(*(.text.tail_l2mgr__send_traffic_deferral_evt)) }
  ASSERT(SIZEOF(.text.tail_l2mgr__send_traffic_deferral_evt) <= 12, "блок tail_l2mgr__send_traffic_deferral_evt не влезает в отведённые ему 12 байт")
  .text.calib_bb_gain__pack_row 0x008e46fc : { KEEP(*(.text.calib_bb_gain__pack_row)) }
  ASSERT(SIZEOF(.text.calib_bb_gain__pack_row) <= 44, "блок calib_bb_gain__pack_row не влезает в отведённые ему 44 байт")
  .text.mem_pool__notify_dma 0x008e4728 : { KEEP(*(.text.mem_pool__notify_dma)) }
  ASSERT(SIZEOF(.text.mem_pool__notify_dma) <= 12, "блок mem_pool__notify_dma не влезает в отведённые ему 12 байт")
  .text.frag_8e4734 0x008e4734 : { KEEP(*(.text.frag_8e4734)) }
  ASSERT(SIZEOF(.text.frag_8e4734) <= 12, "блок frag_8e4734 не влезает в отведённые ему 12 байт")
  .text.frag_8e4740 0x008e4740 : { KEEP(*(.text.frag_8e4740)) }
  ASSERT(SIZEOF(.text.frag_8e4740) <= 24, "блок frag_8e4740 не влезает в отведённые ему 24 байт")
  .text.frag_8e4758 0x008e4758 : { KEEP(*(.text.frag_8e4758)) }
  ASSERT(SIZEOF(.text.frag_8e4758) <= 12, "блок frag_8e4758 не влезает в отведённые ему 12 байт")
  .text.frag_8e4764 0x008e4764 : { KEEP(*(.text.frag_8e4764)) }
  ASSERT(SIZEOF(.text.frag_8e4764) <= 16, "блок frag_8e4764 не влезает в отведённые ему 16 байт")
  .text.stub_ret_8e4774 0x008e4774 : { KEEP(*(.text.stub_ret_8e4774)) }
  ASSERT(SIZEOF(.text.stub_ret_8e4774) <= 4, "блок stub_ret_8e4774 не влезает в отведённые ему 4 байт")
  .text.fwq_tx__on_flush_done 0x008e4778 : { KEEP(*(.text.fwq_tx__on_flush_done)) }
  ASSERT(SIZEOF(.text.fwq_tx__on_flush_done) <= 48, "блок fwq_tx__on_flush_done не влезает в отведённые ему 48 байт")
  .text.get_reg_886d00_8e47a8 0x008e47a8 : { KEEP(*(.text.get_reg_886d00_8e47a8)) }
  ASSERT(SIZEOF(.text.get_reg_886d00_8e47a8) <= 12, "блок get_reg_886d00_8e47a8 не влезает в отведённые ему 12 байт")
  .text.mac__mul_886fc4_by_886d64 0x008e47b4 : { KEEP(*(.text.mac__mul_886fc4_by_886d64)) }
  ASSERT(SIZEOF(.text.mac__mul_886fc4_by_886d64) <= 28, "блок mac__mul_886fc4_by_886d64 не влезает в отведённые ему 28 байт")
  .text.mac__wait_counter_ready 0x008e47d0 : { KEEP(*(.text.mac__wait_counter_ready)) }
  ASSERT(SIZEOF(.text.mac__wait_counter_ready) <= 36, "блок mac__wait_counter_ready не влезает в отведённые ему 36 байт")
  .text.mac__read_counter_886d64 0x008e47f4 : { KEEP(*(.text.mac__read_counter_886d64)) }
  ASSERT(SIZEOF(.text.mac__read_counter_886d64) <= 48, "блок mac__read_counter_886d64 не влезает в отведённые ему 48 байт")
  .text.get_reg_886e80_8e4824 0x008e4824 : { KEEP(*(.text.get_reg_886e80_8e4824)) }
  ASSERT(SIZEOF(.text.get_reg_886e80_8e4824) <= 28, "блок get_reg_886e80_8e4824 не влезает в отведённые ему 28 байт")
  .text.mac_read_tsf64 0x008e4840 : { KEEP(*(.text.mac_read_tsf64)) }
  ASSERT(SIZEOF(.text.mac_read_tsf64) <= 36, "блок mac_read_tsf64 не влезает в отведённые ему 36 байт")
  .text.hwm__probe_33khz_clk 0x008e4864 : { KEEP(*(.text.hwm__probe_33khz_clk)) }
  ASSERT(SIZEOF(.text.hwm__probe_33khz_clk) <= 48, "блок hwm__probe_33khz_clk не влезает в отведённые ему 48 байт")
  .text.mac__wait_886d80_ready 0x008e4894 : { KEEP(*(.text.mac__wait_886d80_ready)) }
  ASSERT(SIZEOF(.text.mac__wait_886d80_ready) <= 84, "блок mac__wait_886d80_ready не влезает в отведённые ему 84 байт")
  .text.hwm__read_33khz_counter 0x008e48e8 : { KEEP(*(.text.hwm__read_33khz_counter)) }
  ASSERT(SIZEOF(.text.hwm__read_33khz_counter) <= 56, "блок hwm__read_33khz_counter не влезает в отведённые ему 56 байт")
  .text.mac__program_gp_timer 0x008e4920 : { KEEP(*(.text.mac__program_gp_timer)) }
  ASSERT(SIZEOF(.text.mac__program_gp_timer) <= 56, "блок mac__program_gp_timer не влезает в отведённые ему 56 байт")
  .text.hwm__start_33khz_measure 0x008e4958 : { KEEP(*(.text.hwm__start_33khz_measure)) }
  ASSERT(SIZEOF(.text.hwm__start_33khz_measure) <= 52, "блок hwm__start_33khz_measure не влезает в отведённые ему 52 байт")
  .text.set_reg_886f80 0x008e498c : { KEEP(*(.text.set_reg_886f80)) }
  ASSERT(SIZEOF(.text.set_reg_886f80) <= 16, "блок set_reg_886f80 не влезает в отведённые ему 16 байт")
  .text.mac__load_gp_timer_value 0x008e499c : { KEEP(*(.text.mac__load_gp_timer_value)) }
  ASSERT(SIZEOF(.text.mac__load_gp_timer_value) <= 32, "блок mac__load_gp_timer_value не влезает в отведённые ему 32 байт")
  .text.set_reg_886e40_x2 0x008e49bc : { KEEP(*(.text.set_reg_886e40_x2)) }
  ASSERT(SIZEOF(.text.set_reg_886e40_x2) <= 24, "блок set_reg_886e40_x2 не влезает в отведённые ему 24 байт")
  .text.set_reg_886e50 0x008e49d4 : { KEEP(*(.text.set_reg_886e50)) }
  ASSERT(SIZEOF(.text.set_reg_886e50) <= 16, "блок set_reg_886e50 не влезает в отведённые ему 16 байт")
  .text.mac__read_tsf_hi 0x008e49e4 : { KEEP(*(.text.mac__read_tsf_hi)) }
  ASSERT(SIZEOF(.text.mac__read_tsf_hi) <= 20, "блок mac__read_tsf_hi не влезает в отведённые ему 20 байт")
  .text.radio_mgr__set_tune_result 0x008e49f8 : { KEEP(*(.text.radio_mgr__set_tune_result)) }
  ASSERT(SIZEOF(.text.radio_mgr__set_tune_result) <= 12, "блок radio_mgr__set_tune_result не влезает в отведённые ему 12 байт")
  .text.frag_8e4a04 0x008e4a04 : { KEEP(*(.text.frag_8e4a04)) }
  ASSERT(SIZEOF(.text.frag_8e4a04) <= 4, "блок frag_8e4a04 не влезает в отведённые ему 4 байт")
  .text.radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked 0x008e4a08 : { KEEP(*(.text.radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked) <= 16, "блок radio_manager_main_sm__on_primary_unset__rm_st_prim_non_locked не влезает в отведённые ему 16 байт")
  .text.stub_ret_8e4a18 0x008e4a18 : { KEEP(*(.text.stub_ret_8e4a18)) }
  ASSERT(SIZEOF(.text.stub_ret_8e4a18) <= 4, "блок stub_ret_8e4a18 не влезает в отведённые ему 4 байт")
  .text.radio_manager_main_sm__on_primary_set__rm_st_idle 0x008e4a1c : { KEEP(*(.text.radio_manager_main_sm__on_primary_set__rm_st_idle)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_primary_set__rm_st_idle) <= 20, "блок radio_manager_main_sm__on_primary_set__rm_st_idle не влезает в отведённые ему 20 байт")
  .text.tx_api__init_oob_dma_queues 0x008e4a30 : { KEEP(*(.text.tx_api__init_oob_dma_queues)) }
  ASSERT(SIZEOF(.text.tx_api__init_oob_dma_queues) <= 52, "блок tx_api__init_oob_dma_queues не влезает в отведённые ему 52 байт")
  .text.tx_api__tx_complete_cb 0x008e4a64 : { KEEP(*(.text.tx_api__tx_complete_cb)) }
  ASSERT(SIZEOF(.text.tx_api__tx_complete_cb) <= 156, "блок tx_api__tx_complete_cb не влезает в отведённые ему 156 байт")
  .text.dma_mgr__reset_queue_0x19 0x008e4b00 : { KEEP(*(.text.dma_mgr__reset_queue_0x19)) }
  ASSERT(SIZEOF(.text.dma_mgr__reset_queue_0x19) <= 84, "блок dma_mgr__reset_queue_0x19 не влезает в отведённые ему 84 байт")
  .text.tx_desc__build_b 0x008e4b54 : { KEEP(*(.text.tx_desc__build_b)) }
  ASSERT(SIZEOF(.text.tx_desc__build_b) <= 76, "блок tx_desc__build_b не влезает в отведённые ему 76 байт")
  .text.tx_api__handle_completions_by_kind 0x008e4ba0 : { KEEP(*(.text.tx_api__handle_completions_by_kind)) }
  ASSERT(SIZEOF(.text.tx_api__handle_completions_by_kind) <= 68, "блок tx_api__handle_completions_by_kind не влезает в отведённые ему 68 байт")
  .text.mgmt_tx__begin_frame 0x008e4be4 : { KEEP(*(.text.mgmt_tx__begin_frame)) }
  ASSERT(SIZEOF(.text.mgmt_tx__begin_frame) <= 32, "блок mgmt_tx__begin_frame не влезает в отведённые ему 32 байт")
  .text.tx_mgmt_srvs__build_disassoc 0x008e4c04 : { KEEP(*(.text.tx_mgmt_srvs__build_disassoc)) }
  ASSERT(SIZEOF(.text.tx_mgmt_srvs__build_disassoc) <= 48, "блок tx_mgmt_srvs__build_disassoc не влезает в отведённые ему 48 байт")
  .text.tx_mgmt_srvs__build_dmg_beacon 0x008e4c34 : { KEEP(*(.text.tx_mgmt_srvs__build_dmg_beacon)) }
  ASSERT(SIZEOF(.text.tx_mgmt_srvs__build_dmg_beacon) <= 136, "блок tx_mgmt_srvs__build_dmg_beacon не влезает в отведённые ему 136 байт")
  .text.tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req 0x008e4cbc : { KEEP(*(.text.tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req)) }
  ASSERT(SIZEOF(.text.tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req) <= 80, "блок tx_mgmt_builder_srvs__tx_mgmt_scan_probe_req не влезает в отведённые ему 80 байт")
  .text.mgmt_tx__build_fixed_probe_resp 0x008e4d0c : { KEEP(*(.text.mgmt_tx__build_fixed_probe_resp)) }
  ASSERT(SIZEOF(.text.mgmt_tx__build_fixed_probe_resp) <= 144, "блок mgmt_tx__build_fixed_probe_resp не влезает в отведённые ему 144 байт")
  .text.dma_mgr__reset_queue_0x1a 0x008e4d9c : { KEEP(*(.text.dma_mgr__reset_queue_0x1a)) }
  ASSERT(SIZEOF(.text.dma_mgr__reset_queue_0x1a) <= 88, "блок dma_mgr__reset_queue_0x1a не влезает в отведённые ему 88 байт")
  .text.sm_pring__notify_vring_state 0x008e4df4 : { KEEP(*(.text.sm_pring__notify_vring_state)) }
  ASSERT(SIZEOF(.text.sm_pring__notify_vring_state) <= 152, "блок sm_pring__notify_vring_state не влезает в отведённые ему 152 байт")
  .text.sm_pring__notify_if_changed 0x008e4e8c : { KEEP(*(.text.sm_pring__notify_if_changed)) }
  ASSERT(SIZEOF(.text.sm_pring__notify_if_changed) <= 28, "блок sm_pring__notify_if_changed не влезает в отведённые ему 28 байт")
  .text.sm_pring__connectivity_update 0x008e4ea8 : { KEEP(*(.text.sm_pring__connectivity_update)) }
  ASSERT(SIZEOF(.text.sm_pring__connectivity_update) <= 52, "блок sm_pring__connectivity_update не влезает в отведённые ему 52 байт")
  .text.sm_pring__update_slot 0x008e4edc : { KEEP(*(.text.sm_pring__update_slot)) }
  ASSERT(SIZEOF(.text.sm_pring__update_slot) <= 24, "блок sm_pring__update_slot не влезает в отведённые ему 24 байт")
  .text.sm_pring__slot_optimized 0x008e4ef4 : { KEEP(*(.text.sm_pring__slot_optimized)) }
  ASSERT(SIZEOF(.text.sm_pring__slot_optimized) <= 100, "блок sm_pring__slot_optimized не влезает в отведённые ему 100 байт")
  .text.tx_dma__build_desc 0x008e4f58 : { KEEP(*(.text.tx_dma__build_desc)) }
  ASSERT(SIZEOF(.text.tx_dma__build_desc) <= 112, "блок tx_dma__build_desc не влезает в отведённые ему 112 байт")
  .text.mac__program_886c00_entry 0x008e4fc8 : { KEEP(*(.text.mac__program_886c00_entry)) }
  ASSERT(SIZEOF(.text.mac__program_886c00_entry) <= 56, "блок mac__program_886c00_entry не влезает в отведённые ему 56 байт")
  .text.rf_chain__zero_and_program 0x008e5000 : { KEEP(*(.text.rf_chain__zero_and_program)) }
  ASSERT(SIZEOF(.text.rf_chain__zero_and_program) <= 32, "блок rf_chain__zero_and_program не влезает в отведённые ему 32 байт")
  .text.tx_queue__configure_one 0x008e5020 : { KEEP(*(.text.tx_queue__configure_one)) }
  ASSERT(SIZEOF(.text.tx_queue__configure_one) <= 108, "блок tx_queue__configure_one не влезает в отведённые ему 108 байт")
  .text.mac_ring_disable 0x008e508c : { KEEP(*(.text.mac_ring_disable)) }
  ASSERT(SIZEOF(.text.mac_ring_disable) <= 32, "блок mac_ring_disable не влезает в отведённые ему 32 байт")
  .text.mac_ring_enable 0x008e50ac : { KEEP(*(.text.mac_ring_enable)) }
  ASSERT(SIZEOF(.text.mac_ring_enable) <= 24, "блок mac_ring_enable не влезает в отведённые ему 24 байт")
  .text.rgf_reg_886a00 0x008e50c4 : { KEEP(*(.text.rgf_reg_886a00)) }
  ASSERT(SIZEOF(.text.rgf_reg_886a00) <= 44, "блок rgf_reg_886a00 не влезает в отведённые ему 44 байт")
  .text.txq_ptp_sw_is_fifo_idle 0x008e50f0 : { KEEP(*(.text.txq_ptp_sw_is_fifo_idle)) }
  ASSERT(SIZEOF(.text.txq_ptp_sw_is_fifo_idle) <= 64, "блок txq_ptp_sw_is_fifo_idle не влезает в отведённые ему 64 байт")
  .text.vring_macq_delete__program_macq 0x008e5130 : { KEEP(*(.text.vring_macq_delete__program_macq)) }
  ASSERT(SIZEOF(.text.vring_macq_delete__program_macq) <= 60, "блок vring_macq_delete__program_macq не влезает в отведённые ему 60 байт")
  .text.txq_ring_param_config_queue 0x008e516c : { KEEP(*(.text.txq_ring_param_config_queue)) }
  ASSERT(SIZEOF(.text.txq_ring_param_config_queue) <= 260, "блок txq_ring_param_config_queue не влезает в отведённые ему 260 байт")
  .text.rf_chain__set_mode_field 0x008e5270 : { KEEP(*(.text.rf_chain__set_mode_field)) }
  ASSERT(SIZEOF(.text.rf_chain__set_mode_field) <= 24, "блок rf_chain__set_mode_field не влезает в отведённые ему 24 байт")
  .text.vring_macq_delete__program_ba_win 0x008e5288 : { KEEP(*(.text.vring_macq_delete__program_ba_win)) }
  ASSERT(SIZEOF(.text.vring_macq_delete__program_ba_win) <= 60, "блок vring_macq_delete__program_ba_win не влезает в отведённые ему 60 байт")
  .text.txrx_sel 0x008e52c4 : { KEEP(*(.text.txrx_sel)) }
  ASSERT(SIZEOF(.text.txrx_sel) <= 64, "блок txrx_sel не влезает в отведённые ему 64 байт")
  .text.sw_vring__setup_macq 0x008e5304 : { KEEP(*(.text.sw_vring__setup_macq)) }
  ASSERT(SIZEOF(.text.sw_vring__setup_macq) <= 60, "блок sw_vring__setup_macq не влезает в отведённые ему 60 байт")
  .text.sm__inject_evt_b 0x008e5340 : { KEEP(*(.text.sm__inject_evt_b)) }
  ASSERT(SIZEOF(.text.sm__inject_evt_b) <= 16, "блок sm__inject_evt_b не влезает в отведённые ему 16 байт")
  .text.tail_l2mgr__init_frame_pool 0x008e5350 : { KEEP(*(.text.tail_l2mgr__init_frame_pool)) }
  ASSERT(SIZEOF(.text.tail_l2mgr__init_frame_pool) <= 4, "блок tail_l2mgr__init_frame_pool не влезает в отведённые ему 4 байт")
  .text.tail_u_schd__large_task_warn 0x008e5354 : { KEEP(*(.text.tail_u_schd__large_task_warn)) }
  ASSERT(SIZEOF(.text.tail_u_schd__large_task_warn) <= 4, "блок tail_u_schd__large_task_warn не влезает в отведённые ему 4 байт")
  .text.sm_pring__state_step 0x008e5358 : { KEEP(*(.text.sm_pring__state_step)) }
  ASSERT(SIZEOF(.text.sm_pring__state_step) <= 204, "блок sm_pring__state_step не влезает в отведённые ему 204 байт")
  .text.ba_sm__on_start_ba_setup__ba_agreed_state 0x008e5424 : { KEEP(*(.text.ba_sm__on_start_ba_setup__ba_agreed_state)) }
  ASSERT(SIZEOF(.text.ba_sm__on_start_ba_setup__ba_agreed_state) <= 44, "блок ba_sm__on_start_ba_setup__ba_agreed_state не влезает в отведённые ему 44 байт")
  .text.frag_8e5450 0x008e5450 : { KEEP(*(.text.frag_8e5450)) }
  ASSERT(SIZEOF(.text.frag_8e5450) <= 4, "блок frag_8e5450 не влезает в отведённые ему 4 байт")
  .text.ba_sm__on_start_ba_teardown 0x008e5454 : { KEEP(*(.text.ba_sm__on_start_ba_teardown)) }
  ASSERT(SIZEOF(.text.ba_sm__on_start_ba_teardown) <= 48, "блок ba_sm__on_start_ba_teardown не влезает в отведённые ему 48 байт")
  .text.stream_mgr__foreach_pring_of_owner 0x008e5484 : { KEEP(*(.text.stream_mgr__foreach_pring_of_owner)) }
  ASSERT(SIZEOF(.text.stream_mgr__foreach_pring_of_owner) <= 68, "блок stream_mgr__foreach_pring_of_owner не влезает в отведённые ему 68 байт")
  .text.sm__inject_evt_7 0x008e54c8 : { KEEP(*(.text.sm__inject_evt_7)) }
  ASSERT(SIZEOF(.text.sm__inject_evt_7) <= 16, "блок sm__inject_evt_7 не влезает в отведённые ему 16 байт")
  .text.RADIO_MGR__unlock 0x008e54d8 : { KEEP(*(.text.RADIO_MGR__unlock)) }
  ASSERT(SIZEOF(.text.RADIO_MGR__unlock) <= 36, "блок RADIO_MGR__unlock не влезает в отведённые ему 36 байт")
  .text.gpio__880b64_set_bit18 0x008e54fc : { KEEP(*(.text.gpio__880b64_set_bit18)) }
  ASSERT(SIZEOF(.text.gpio__880b64_set_bit18) <= 40, "блок gpio__880b64_set_bit18 не влезает в отведённые ему 40 байт")
  .text.gpio__880b64_set_bit19 0x008e5524 : { KEEP(*(.text.gpio__880b64_set_bit19)) }
  ASSERT(SIZEOF(.text.gpio__880b64_set_bit19) <= 44, "блок gpio__880b64_set_bit19 не влезает в отведённые ему 44 байт")
  .text.tail_sta_psc_sm__psc_done_sm 0x008e5550 : { KEEP(*(.text.tail_sta_psc_sm__psc_done_sm)) }
  ASSERT(SIZEOF(.text.tail_sta_psc_sm__psc_done_sm) <= 12, "блок tail_sta_psc_sm__psc_done_sm не влезает в отведённые ему 12 байт")
  .text.set_mem_85726c_8e555c 0x008e555c : { KEEP(*(.text.set_mem_85726c_8e555c)) }
  ASSERT(SIZEOF(.text.set_mem_85726c_8e555c) <= 12, "блок set_mem_85726c_8e555c не влезает в отведённые ему 12 байт")
  .text.RADIO_MGR__unset_primary_channel 0x008e5568 : { KEEP(*(.text.RADIO_MGR__unset_primary_channel)) }
  ASSERT(SIZEOF(.text.RADIO_MGR__unset_primary_channel) <= 52, "блок RADIO_MGR__unset_primary_channel не влезает в отведённые ему 52 байт")
  .text.radio_manager_main_sm__on_primary_unset__rm_st_idle 0x008e559c : { KEEP(*(.text.radio_manager_main_sm__on_primary_unset__rm_st_idle)) }
  ASSERT(SIZEOF(.text.radio_manager_main_sm__on_primary_unset__rm_st_idle) <= 16, "блок radio_manager_main_sm__on_primary_unset__rm_st_idle не влезает в отведённые ему 16 байт")
  .text.bitmask_below 0x008e55ac : { KEEP(*(.text.bitmask_below)) }
  ASSERT(SIZEOF(.text.bitmask_below) <= 20, "блок bitmask_below не влезает в отведённые ему 20 байт")
  .text.frag_8e55c0 0x008e55c0 : { KEEP(*(.text.frag_8e55c0)) }
  ASSERT(SIZEOF(.text.frag_8e55c0) <= 12, "блок frag_8e55c0 не влезает в отведённые ему 12 байт")
  .text.conn__store_linkup_field 0x008e55cc : { KEEP(*(.text.conn__store_linkup_field)) }
  ASSERT(SIZEOF(.text.conn__store_linkup_field) <= 8, "блок conn__store_linkup_field не влезает в отведённые ему 8 байт")
  .text.dashboard__count_bf_result 0x008e55d4 : { KEEP(*(.text.dashboard__count_bf_result)) }
  ASSERT(SIZEOF(.text.dashboard__count_bf_result) <= 76, "блок dashboard__count_bf_result не влезает в отведённые ему 76 байт")
  .text.vring__program_macq_and_ba 0x008e5620 : { KEEP(*(.text.vring__program_macq_and_ba)) }
  ASSERT(SIZEOF(.text.vring__program_macq_and_ba) <= 76, "блок vring__program_macq_and_ba не влезает в отведённые ему 76 байт")
  .text.calib_engine__links_active 0x008e566c : { KEEP(*(.text.calib_engine__links_active)) }
  ASSERT(SIZEOF(.text.calib_engine__links_active) <= 24, "блок calib_engine__links_active не влезает в отведённые ему 24 байт")
  .text.vr_obj__update_connected_duration 0x008e5684 : { KEEP(*(.text.vr_obj__update_connected_duration)) }
  ASSERT(SIZEOF(.text.vr_obj__update_connected_duration) <= 104, "блок vr_obj__update_connected_duration не влезает в отведённые ему 104 байт")
  .text.ese__copy_alloc_header 0x008e56ec : { KEEP(*(.text.ese__copy_alloc_header)) }
  ASSERT(SIZEOF(.text.ese__copy_alloc_header) <= 28, "блок ese__copy_alloc_header не влезает в отведённые ему 28 байт")
  .text.fw_scheduled_dti__update_ie 0x008e5708 : { KEEP(*(.text.fw_scheduled_dti__update_ie)) }
  ASSERT(SIZEOF(.text.fw_scheduled_dti__update_ie) <= 124, "блок fw_scheduled_dti__update_ie не влезает в отведённые ему 124 байт")
  .text.bcon__refresh_dti_ie 0x008e5784 : { KEEP(*(.text.bcon__refresh_dti_ie)) }
  ASSERT(SIZEOF(.text.bcon__refresh_dti_ie) <= 32, "блок bcon__refresh_dti_ie не влезает в отведённые ему 32 байт")
  .text.dashboard__bf_results 0x008e57a4 : { KEEP(*(.text.dashboard__bf_results)) }
  ASSERT(SIZEOF(.text.dashboard__bf_results) <= 124, "блок dashboard__bf_results не влезает в отведённые ему 124 байт")
  .text.dashboard__on_disconnect 0x008e5820 : { KEEP(*(.text.dashboard__on_disconnect)) }
  ASSERT(SIZEOF(.text.dashboard__on_disconnect) <= 72, "блок dashboard__on_disconnect не влезает в отведённые ему 72 байт")
  .text.dashboard__add_connection 0x008e5868 : { KEEP(*(.text.dashboard__add_connection)) }
  ASSERT(SIZEOF(.text.dashboard__add_connection) <= 176, "блок dashboard__add_connection не влезает в отведённые ему 176 байт")
  .text.CALIB_MNGR__update_pcp_ap 0x008e5918 : { KEEP(*(.text.CALIB_MNGR__update_pcp_ap)) }
  ASSERT(SIZEOF(.text.CALIB_MNGR__update_pcp_ap) <= 60, "блок CALIB_MNGR__update_pcp_ap не влезает в отведённые ему 60 байт")
  .text.dashboard__store_passphrase 0x008e5954 : { KEEP(*(.text.dashboard__store_passphrase)) }
  ASSERT(SIZEOF(.text.dashboard__store_passphrase) <= 28, "блок dashboard__store_passphrase не влезает в отведённые ему 28 байт")
  .text.dashboard__update_rs_result 0x008e5970 : { KEEP(*(.text.dashboard__update_rs_result)) }
  ASSERT(SIZEOF(.text.dashboard__update_rs_result) <= 104, "блок dashboard__update_rs_result не влезает в отведённые ему 104 байт")
  .text.ut_hw_cmd_0x008 0x008e59d8 : { KEEP(*(.text.ut_hw_cmd_0x008)) }
  ASSERT(SIZEOF(.text.ut_hw_cmd_0x008) <= 28, "блок ut_hw_cmd_0x008 не влезает в отведённые ему 28 байт")
  .text.radio_mgr__copy_tune_params 0x008e59f4 : { KEEP(*(.text.radio_mgr__copy_tune_params)) }
  ASSERT(SIZEOF(.text.radio_mgr__copy_tune_params) <= 32, "блок radio_mgr__copy_tune_params не влезает в отведённые ему 32 байт")
  .text.dashboard__store_ssid 0x008e5a14 : { KEEP(*(.text.dashboard__store_ssid)) }
  ASSERT(SIZEOF(.text.dashboard__store_ssid) <= 24, "блок dashboard__store_ssid не влезает в отведённые ему 24 байт")
  .text.CALIB_MNGR__update_sys_state 0x008e5a2c : { KEEP(*(.text.CALIB_MNGR__update_sys_state)) }
  ASSERT(SIZEOF(.text.CALIB_MNGR__update_sys_state) <= 60, "блок CALIB_MNGR__update_sys_state не влезает в отведённые ему 60 байт")
  .text.CALIB_MNGR__update_sys_state_8e5a68 0x008e5a68 : { KEEP(*(.text.CALIB_MNGR__update_sys_state_8e5a68)) }
  ASSERT(SIZEOF(.text.CALIB_MNGR__update_sys_state_8e5a68) <= 16, "блок CALIB_MNGR__update_sys_state_8e5a68 не влезает в отведённые ему 16 байт")
  .text.tx_api__count_completion_status 0x008e5a78 : { KEEP(*(.text.tx_api__count_completion_status)) }
  ASSERT(SIZEOF(.text.tx_api__count_completion_status) <= 68, "блок tx_api__count_completion_status не влезает в отведённые ему 68 байт")
  .text.calib_mgr_ut 0x008e5abc : { KEEP(*(.text.calib_mgr_ut)) }
  ASSERT(SIZEOF(.text.calib_mgr_ut) <= 104, "блок calib_mgr_ut не влезает в отведённые ему 104 байт")
  .text.power_mgr_ut 0x008e5b24 : { KEEP(*(.text.power_mgr_ut)) }
  ASSERT(SIZEOF(.text.power_mgr_ut) <= 88, "блок power_mgr_ut не влезает в отведённые ему 88 байт")
  .text.ut__begin_response 0x008e5b7c : { KEEP(*(.text.ut__begin_response)) }
  ASSERT(SIZEOF(.text.ut__begin_response) <= 24, "блок ut__begin_response не влезает в отведённые ему 24 байт")
  .text.ut_hw__post_response 0x008e5b94 : { KEEP(*(.text.ut_hw__post_response)) }
  ASSERT(SIZEOF(.text.ut_hw__post_response) <= 84, "блок ut_hw__post_response не влезает в отведённые ему 84 байт")
  .text.UT_HW_DRIVERS_cmd_handler 0x008e5be8 : { KEEP(*(.text.UT_HW_DRIVERS_cmd_handler)) }
  ASSERT(SIZEOF(.text.UT_HW_DRIVERS_cmd_handler) <= 2348, "блок UT_HW_DRIVERS_cmd_handler не влезает в отведённые ему 2348 байт")
  .text.UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST 0x008e6514 : { KEEP(*(.text.UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST)) }
  ASSERT(SIZEOF(.text.UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST) <= 2376, "блок UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST не влезает в отведённые ему 2376 байт")
  .text.UT_HW_MODES_cmd_handler 0x008e6e5c : { KEEP(*(.text.UT_HW_MODES_cmd_handler)) }
  ASSERT(SIZEOF(.text.UT_HW_MODES_cmd_handler) <= 456, "блок UT_HW_MODES_cmd_handler не влезает в отведённые ему 456 байт")
  .text.UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler 0x008e7024 : { KEEP(*(.text.UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler)) }
  ASSERT(SIZEOF(.text.UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler) <= 116, "блок UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler не влезает в отведённые ему 116 байт")
  .text.vendor_ie__write_at_282 0x008e7098 : { KEEP(*(.text.vendor_ie__write_at_282)) }
  ASSERT(SIZEOF(.text.vendor_ie__write_at_282) <= 56, "блок vendor_ie__write_at_282 не влезает в отведённые ему 56 байт")
  .text.stub_ret_8e70d0 0x008e70d0 : { KEEP(*(.text.stub_ret_8e70d0)) }
  ASSERT(SIZEOF(.text.stub_ret_8e70d0) <= 4, "блок stub_ret_8e70d0 не влезает в отведённые ему 4 байт")
  .text.stub_ret_8e70d4 0x008e70d4 : { KEEP(*(.text.stub_ret_8e70d4)) }
  ASSERT(SIZEOF(.text.stub_ret_8e70d4) <= 4, "блок stub_ret_8e70d4 не влезает в отведённые ему 4 байт")
  .text.stub_ret_8e70d8 0x008e70d8 : { KEEP(*(.text.stub_ret_8e70d8)) }
  ASSERT(SIZEOF(.text.stub_ret_8e70d8) <= 4, "блок stub_ret_8e70d8 не влезает в отведённые ему 4 байт")
  .text.brd_if_multi_array__verify_board_file_format_version 0x008e70dc : { KEEP(*(.text.brd_if_multi_array__verify_board_file_format_version)) }
  ASSERT(SIZEOF(.text.brd_if_multi_array__verify_board_file_format_version) <= 88, "блок brd_if_multi_array__verify_board_file_format_version не влезает в отведённые ему 88 байт")
  .text.verify_pbc 0x008e7134 : { KEEP(*(.text.verify_pbc)) }
  ASSERT(SIZEOF(.text.verify_pbc) <= 100, "блок verify_pbc не влезает в отведённые ему 100 байт")
  .text.brd_if__check_section_header 0x008e7198 : { KEEP(*(.text.brd_if__check_section_header)) }
  ASSERT(SIZEOF(.text.brd_if__check_section_header) <= 84, "блок brd_if__check_section_header не влезает в отведённые ему 84 байт")
  .text.verify_ssid 0x008e71ec : { KEEP(*(.text.verify_ssid)) }
  ASSERT(SIZEOF(.text.verify_ssid) <= 84, "блок verify_ssid не влезает в отведённые ему 84 байт")
  .text.l2mgr__vring_drained 0x008e7240 : { KEEP(*(.text.l2mgr__vring_drained)) }
  ASSERT(SIZEOF(.text.l2mgr__vring_drained) <= 60, "блок l2mgr__vring_drained не влезает в отведённые ему 60 байт")
  .text.vring_list__find 0x008e727c : { KEEP(*(.text.vring_list__find)) }
  ASSERT(SIZEOF(.text.vring_list__find) <= 60, "блок vring_list__find не влезает в отведённые ему 60 байт")
  .text.vring_schd__find_by_cid 0x008e72b8 : { KEEP(*(.text.vring_schd__find_by_cid)) }
  ASSERT(SIZEOF(.text.vring_schd__find_by_cid) <= 68, "блок vring_schd__find_by_cid не влезает в отведённые ему 68 байт")
  .text.pring__isr_dispatch 0x008e72fc : { KEEP(*(.text.pring__isr_dispatch)) }
  ASSERT(SIZEOF(.text.pring__isr_dispatch) <= 144, "блок pring__isr_dispatch не влезает в отведённые ему 144 байт")
  .text.vring_schdlr__isr_dispatch 0x008e738c : { KEEP(*(.text.vring_schdlr__isr_dispatch)) }
  ASSERT(SIZEOF(.text.vring_schdlr__isr_dispatch) <= 96, "блок vring_schdlr__isr_dispatch не влезает в отведённые ему 96 байт")
  .text.vring__notify_delete 0x008e73ec : { KEEP(*(.text.vring__notify_delete)) }
  ASSERT(SIZEOF(.text.vring__notify_delete) <= 20, "блок vring__notify_delete не влезает в отведённые ему 20 байт")
  .text.tail_pcie_device_power_if__pcie_power_wake_signal 0x008e7400 : { KEEP(*(.text.tail_pcie_device_power_if__pcie_power_wake_signal)) }
  ASSERT(SIZEOF(.text.tail_pcie_device_power_if__pcie_power_wake_signal) <= 12, "блок tail_pcie_device_power_if__pcie_power_wake_signal не влезает в отведённые ему 12 байт")
  .text.wmi_handler_brp_rf_chains_limit 0x008e740c : { KEEP(*(.text.wmi_handler_brp_rf_chains_limit)) }
  ASSERT(SIZEOF(.text.wmi_handler_brp_rf_chains_limit) <= 12, "блок wmi_handler_brp_rf_chains_limit не влезает в отведённые ему 12 байт")
  .text.ese_cfg__apply 0x008e7418 : { KEEP(*(.text.ese_cfg__apply)) }
  ASSERT(SIZEOF(.text.ese_cfg__apply) <= 528, "блок ese_cfg__apply не влезает в отведённые ему 528 байт")
  .text.l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit 0x008e7628 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit) <= 100, "блок l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit не влезает в отведённые ему 100 байт")
  .text.l2_mgr__wmi_cmd_handler_p2p_cfg 0x008e768c : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_p2p_cfg)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_p2p_cfg) <= 4, "блок l2_mgr__wmi_cmd_handler_p2p_cfg не влезает в отведённые ему 4 байт")
  .text.wmi__store_power_mgmt_mode 0x008e7690 : { KEEP(*(.text.wmi__store_power_mgmt_mode)) }
  ASSERT(SIZEOF(.text.wmi__store_power_mgmt_mode) <= 8, "блок wmi__store_power_mgmt_mode не влезает в отведённые ему 8 байт")
  .text.wmi_handler_power_mgmt_cfg 0x008e7698 : { KEEP(*(.text.wmi_handler_power_mgmt_cfg)) }
  ASSERT(SIZEOF(.text.wmi_handler_power_mgmt_cfg) <= 4, "блок wmi_handler_power_mgmt_cfg не влезает в отведённые ему 4 байт")
  .text.l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit 0x008e769c : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit) <= 132, "блок l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit не влезает в отведённые ему 132 байт")
  .text.wmi_handler_discovery_start 0x008e7720 : { KEEP(*(.text.wmi_handler_discovery_start)) }
  ASSERT(SIZEOF(.text.wmi_handler_discovery_start) <= 4, "блок wmi_handler_discovery_start не влезает в отведённые ему 4 байт")
  .text.l2_mgr__wmi_cmd_handler_start_listen 0x008e7724 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_start_listen)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_start_listen) <= 4, "блок l2_mgr__wmi_cmd_handler_start_listen не влезает в отведённые ему 4 байт")
  .text.l2_mgr__wmi_cmd_handler_start_search 0x008e7728 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_start_search)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_start_search) <= 4, "блок l2_mgr__wmi_cmd_handler_start_search не влезает в отведённые ему 4 байт")
  .text.wmi_handler_discovery_stop 0x008e772c : { KEEP(*(.text.wmi_handler_discovery_stop)) }
  ASSERT(SIZEOF(.text.wmi_handler_discovery_stop) <= 4, "блок wmi_handler_discovery_stop не влезает в отведённые ему 4 байт")
  .text.wmi_handler_connect 0x008e7730 : { KEEP(*(.text.wmi_handler_connect)) }
  ASSERT(SIZEOF(.text.wmi_handler_connect) <= 68, "блок wmi_handler_connect не влезает в отведённые ему 68 байт")
  .text.host_if__connect_rf_kill 0x008e7774 : { KEEP(*(.text.host_if__connect_rf_kill)) }
  ASSERT(SIZEOF(.text.host_if__connect_rf_kill) <= 60, "блок host_if__connect_rf_kill не влезает в отведённые ему 60 байт")
  .text.WMI_DELETE_CIPHER_KEY_CMD 0x008e77b0 : { KEEP(*(.text.WMI_DELETE_CIPHER_KEY_CMD)) }
  ASSERT(SIZEOF(.text.WMI_DELETE_CIPHER_KEY_CMD) <= 52, "блок WMI_DELETE_CIPHER_KEY_CMD не влезает в отведённые ему 52 байт")
  .text.wmi_handler_disconnect 0x008e77e4 : { KEEP(*(.text.wmi_handler_disconnect)) }
  ASSERT(SIZEOF(.text.wmi_handler_disconnect) <= 8, "блок wmi_handler_disconnect не влезает в отведённые ему 8 байт")
  .text.wmi_handler_disconnect_sta 0x008e77ec : { KEEP(*(.text.wmi_handler_disconnect_sta)) }
  ASSERT(SIZEOF(.text.wmi_handler_disconnect_sta) <= 12, "блок wmi_handler_disconnect_sta не влезает в отведённые ему 12 байт")
  .text.wmi_handler_mac_addr_req 0x008e77f8 : { KEEP(*(.text.wmi_handler_mac_addr_req)) }
  ASSERT(SIZEOF(.text.wmi_handler_mac_addr_req) <= 148, "блок wmi_handler_mac_addr_req не влезает в отведённые ему 148 байт")
  .text.wmi_handler_link_maintain_cfg_read 0x008e788c : { KEEP(*(.text.wmi_handler_link_maintain_cfg_read)) }
  ASSERT(SIZEOF(.text.wmi_handler_link_maintain_cfg_read) <= 76, "блок wmi_handler_link_maintain_cfg_read не влезает в отведённые ему 76 байт")
  .text.wmi_handler_link_maintain_cfg_write 0x008e78d8 : { KEEP(*(.text.wmi_handler_link_maintain_cfg_write)) }
  ASSERT(SIZEOF(.text.wmi_handler_link_maintain_cfg_write) <= 76, "блок wmi_handler_link_maintain_cfg_write не влезает в отведённые ему 76 байт")
  .text.wmi_handler_bcon_ctrl 0x008e7924 : { KEEP(*(.text.wmi_handler_bcon_ctrl)) }
  ASSERT(SIZEOF(.text.wmi_handler_bcon_ctrl) <= 184, "блок wmi_handler_bcon_ctrl не влезает в отведённые ему 184 байт")
  .text.wmi_handler_pcp_start 0x008e79dc : { KEEP(*(.text.wmi_handler_pcp_start)) }
  ASSERT(SIZEOF(.text.wmi_handler_pcp_start) <= 72, "блок wmi_handler_pcp_start не влезает в отведённые ему 72 байт")
  .text.POWER_MNGR__wmi_ps_dev_profile_cfg_cmd 0x008e7a24 : { KEEP(*(.text.POWER_MNGR__wmi_ps_dev_profile_cfg_cmd)) }
  ASSERT(SIZEOF(.text.POWER_MNGR__wmi_ps_dev_profile_cfg_cmd) <= 96, "блок POWER_MNGR__wmi_ps_dev_profile_cfg_cmd не влезает в отведённые ему 96 байт")
  .text.wmi_handler_pxmt_range_cfg 0x008e7a84 : { KEEP(*(.text.wmi_handler_pxmt_range_cfg)) }
  ASSERT(SIZEOF(.text.wmi_handler_pxmt_range_cfg) <= 24, "блок wmi_handler_pxmt_range_cfg не влезает в отведённые ему 24 байт")
  .text.low_sme__wmi_rf_mgmt_cmd_handler 0x008e7a9c : { KEEP(*(.text.low_sme__wmi_rf_mgmt_cmd_handler)) }
  ASSERT(SIZEOF(.text.low_sme__wmi_rf_mgmt_cmd_handler) <= 96, "блок low_sme__wmi_rf_mgmt_cmd_handler не влезает в отведённые ему 96 байт")
  .text.wmi_handler_abort_scan 0x008e7afc : { KEEP(*(.text.wmi_handler_abort_scan)) }
  ASSERT(SIZEOF(.text.wmi_handler_abort_scan) <= 28, "блок wmi_handler_abort_scan не влезает в отведённые ему 28 байт")
  .text.low_sme__wmi_scan_cmd_handler 0x008e7b18 : { KEEP(*(.text.low_sme__wmi_scan_cmd_handler)) }
  ASSERT(SIZEOF(.text.low_sme__wmi_scan_cmd_handler) <= 136, "блок low_sme__wmi_scan_cmd_handler не влезает в отведённые ему 136 байт")
  .text.host_if__send_scan_complete 0x008e7ba0 : { KEEP(*(.text.host_if__send_scan_complete)) }
  ASSERT(SIZEOF(.text.host_if__send_scan_complete) <= 80, "блок host_if__send_scan_complete не влезает в отведённые ему 80 байт")
  .text.wmi_handler_rcp_addba_resp 0x008e7bf0 : { KEEP(*(.text.wmi_handler_rcp_addba_resp)) }
  ASSERT(SIZEOF(.text.wmi_handler_rcp_addba_resp) <= 316, "блок wmi_handler_rcp_addba_resp не влезает в отведённые ему 316 байт")
  .text.wmi_handler_rcp_delba 0x008e7d2c : { KEEP(*(.text.wmi_handler_rcp_delba)) }
  ASSERT(SIZEOF(.text.wmi_handler_rcp_delba) <= 208, "блок wmi_handler_rcp_delba не влезает в отведённые ему 208 байт")
  .text.wmi_handler_set_appie 0x008e7dfc : { KEEP(*(.text.wmi_handler_set_appie)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_appie) <= 4, "блок wmi_handler_set_appie не влезает в отведённые ему 4 байт")
  .text.lmac_if_send_long_range 0x008e7e00 : { KEEP(*(.text.lmac_if_send_long_range)) }
  ASSERT(SIZEOF(.text.lmac_if_send_long_range) <= 76, "блок lmac_if_send_long_range не влезает в отведённые ему 76 байт")
  .text.wmi_handler_set_mac_address 0x008e7e4c : { KEEP(*(.text.wmi_handler_set_mac_address)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_mac_address) <= 4, "блок wmi_handler_set_mac_address не влезает в отведённые ему 4 байт")
  .text.wmi_set_passphrase_handler 0x008e7e50 : { KEEP(*(.text.wmi_set_passphrase_handler)) }
  ASSERT(SIZEOF(.text.wmi_set_passphrase_handler) <= 88, "блок wmi_set_passphrase_handler не влезает в отведённые ему 88 байт")
  .text.POWER_MNGR__wmi_traffic_deferral_cmd 0x008e7ea8 : { KEEP(*(.text.POWER_MNGR__wmi_traffic_deferral_cmd)) }
  ASSERT(SIZEOF(.text.POWER_MNGR__wmi_traffic_deferral_cmd) <= 44, "блок POWER_MNGR__wmi_traffic_deferral_cmd не влезает в отведённые ему 44 байт")
  .text.wmi_handler_traffic_resume 0x008e7ed4 : { KEEP(*(.text.wmi_handler_traffic_resume)) }
  ASSERT(SIZEOF(.text.wmi_handler_traffic_resume) <= 12, "блок wmi_handler_traffic_resume не влезает в отведённые ему 12 байт")
  .text.wmi_ut_handler_dispatch 0x008e7ee0 : { KEEP(*(.text.wmi_ut_handler_dispatch)) }
  ASSERT(SIZEOF(.text.wmi_ut_handler_dispatch) <= 128, "блок wmi_ut_handler_dispatch не влезает в отведённые ему 128 байт")
  .text.marlon_r_if__write_reg 0x008e7f60 : { KEEP(*(.text.marlon_r_if__write_reg)) }
  ASSERT(SIZEOF(.text.marlon_r_if__write_reg) <= 80, "блок marlon_r_if__write_reg не влезает в отведённые ему 80 байт")
  .text.marlon_r_if__write_via_rfc 0x008e7fb0 : { KEEP(*(.text.marlon_r_if__write_via_rfc)) }
  ASSERT(SIZEOF(.text.marlon_r_if__write_via_rfc) <= 44, "блок marlon_r_if__write_via_rfc не влезает в отведённые ему 44 байт")
  .text.wmi_handler_otp_write 0x008e7fdc : { KEEP(*(.text.wmi_handler_otp_write)) }
  ASSERT(SIZEOF(.text.wmi_handler_otp_write) <= 44, "блок wmi_handler_otp_write не влезает в отведённые ему 44 байт")
  .text.tail_rfc_field_write 0x008e8008 : { KEEP(*(.text.tail_rfc_field_write)) }
  ASSERT(SIZEOF(.text.tail_rfc_field_write) <= 12, "блок tail_rfc_field_write не влезает в отведённые ему 12 байт")
  .text.marlon_r_if__write_verify 0x008e8014 : { KEEP(*(.text.marlon_r_if__write_verify)) }
  ASSERT(SIZEOF(.text.marlon_r_if__write_verify) <= 148, "блок marlon_r_if__write_verify не влезает в отведённые ему 148 байт")
  .text.fw_check_mpy_build 0x008e80a8 : { KEEP(*(.text.fw_check_mpy_build)) }
  ASSERT(SIZEOF(.text.fw_check_mpy_build) <= 128, "блок fw_check_mpy_build не влезает в отведённые ему 128 байт")
  .text.fwq_tx__ctor 0x008e8128 : { KEEP(*(.text.fwq_tx__ctor)) }
  ASSERT(SIZEOF(.text.fwq_tx__ctor) <= 48, "блок fwq_tx__ctor не влезает в отведённые ему 48 байт")
  .text.obj__set_vtable_800828 0x008e8158 : { KEEP(*(.text.obj__set_vtable_800828)) }
  ASSERT(SIZEOF(.text.obj__set_vtable_800828) <= 16, "блок obj__set_vtable_800828 не влезает в отведённые ему 16 байт")
  .text.bf_u16_s3_w8 0x008e8168 : { KEEP(*(.text.bf_u16_s3_w8)) }
  ASSERT(SIZEOF(.text.bf_u16_s3_w8) <= 12, "блок bf_u16_s3_w8 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s4_w12 0x008e8174 : { KEEP(*(.text.bf_u16_s4_w12)) }
  ASSERT(SIZEOF(.text.bf_u16_s4_w12) <= 12, "блок bf_u16_s4_w12 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s5_w5 0x008e8180 : { KEEP(*(.text.bf_u16_s5_w5)) }
  ASSERT(SIZEOF(.text.bf_u16_s5_w5) <= 12, "блок bf_u16_s5_w5 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s5_w6 0x008e818c : { KEEP(*(.text.bf_u16_s5_w6)) }
  ASSERT(SIZEOF(.text.bf_u16_s5_w6) <= 12, "блок bf_u16_s5_w6 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s6_w10 0x008e8198 : { KEEP(*(.text.bf_u16_s6_w10)) }
  ASSERT(SIZEOF(.text.bf_u16_s6_w10) <= 12, "блок bf_u16_s6_w10 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s6_w6 0x008e81a4 : { KEEP(*(.text.bf_u16_s6_w6)) }
  ASSERT(SIZEOF(.text.bf_u16_s6_w6) <= 12, "блок bf_u16_s6_w6 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s6_w7 0x008e81b0 : { KEEP(*(.text.bf_u16_s6_w7)) }
  ASSERT(SIZEOF(.text.bf_u16_s6_w7) <= 12, "блок bf_u16_s6_w7 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s7_w3 0x008e81bc : { KEEP(*(.text.bf_u16_s7_w3)) }
  ASSERT(SIZEOF(.text.bf_u16_s7_w3) <= 12, "блок bf_u16_s7_w3 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s7_w5 0x008e81c8 : { KEEP(*(.text.bf_u16_s7_w5)) }
  ASSERT(SIZEOF(.text.bf_u16_s7_w5) <= 12, "блок bf_u16_s7_w5 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s7_w6 0x008e81d4 : { KEEP(*(.text.bf_u16_s7_w6)) }
  ASSERT(SIZEOF(.text.bf_u16_s7_w6) <= 12, "блок bf_u16_s7_w6 не влезает в отведённые ему 12 байт")
  .text.bf_u16_s7_w7 0x008e81e0 : { KEEP(*(.text.bf_u16_s7_w7)) }
  ASSERT(SIZEOF(.text.bf_u16_s7_w7) <= 12, "блок bf_u16_s7_w7 не влезает в отведённые ему 12 байт")
  .text.bf_u32_s4_w24 0x008e81ec : { KEEP(*(.text.bf_u32_s4_w24)) }
  ASSERT(SIZEOF(.text.bf_u32_s4_w24) <= 12, "блок bf_u32_s4_w24 не влезает в отведённые ему 12 байт")
  .text.bf_b_s0_w2 0x008e81f8 : { KEEP(*(.text.bf_b_s0_w2)) }
  ASSERT(SIZEOF(.text.bf_b_s0_w2) <= 12, "блок bf_b_s0_w2 не влезает в отведённые ему 12 байт")
  .text.bf_b_s0_w4 0x008e8204 : { KEEP(*(.text.bf_b_s0_w4)) }
  ASSERT(SIZEOF(.text.bf_b_s0_w4) <= 12, "блок bf_b_s0_w4 не влезает в отведённые ему 12 байт")
  .text.bf_b_s0_w5 0x008e8210 : { KEEP(*(.text.bf_b_s0_w5)) }
  ASSERT(SIZEOF(.text.bf_b_s0_w5) <= 12, "блок bf_b_s0_w5 не влезает в отведённые ему 12 байт")
  .text.bf_b_s0_w6 0x008e821c : { KEEP(*(.text.bf_b_s0_w6)) }
  ASSERT(SIZEOF(.text.bf_b_s0_w6) <= 12, "блок bf_b_s0_w6 не влезает в отведённые ему 12 байт")
  .text.bf_b_s1_w3 0x008e8228 : { KEEP(*(.text.bf_b_s1_w3)) }
  ASSERT(SIZEOF(.text.bf_b_s1_w3) <= 12, "блок bf_b_s1_w3 не влезает в отведённые ему 12 байт")
  .text.bf_b_s2_w3 0x008e8234 : { KEEP(*(.text.bf_b_s2_w3)) }
  ASSERT(SIZEOF(.text.bf_b_s2_w3) <= 12, "блок bf_b_s2_w3 не влезает в отведённые ему 12 байт")
  .text.bf_b_s2_w4 0x008e8240 : { KEEP(*(.text.bf_b_s2_w4)) }
  ASSERT(SIZEOF(.text.bf_b_s2_w4) <= 12, "блок bf_b_s2_w4 не влезает в отведённые ему 12 байт")
  .text.bf_b_s2_w5 0x008e824c : { KEEP(*(.text.bf_b_s2_w5)) }
  ASSERT(SIZEOF(.text.bf_b_s2_w5) <= 12, "блок bf_b_s2_w5 не влезает в отведённые ему 12 байт")
  .text.bf_b_s2_w6 0x008e8258 : { KEEP(*(.text.bf_b_s2_w6)) }
  ASSERT(SIZEOF(.text.bf_b_s2_w6) <= 12, "блок bf_b_s2_w6 не влезает в отведённые ему 12 байт")
  .text.bf_b_s4_w2 0x008e8264 : { KEEP(*(.text.bf_b_s4_w2)) }
  ASSERT(SIZEOF(.text.bf_b_s4_w2) <= 12, "блок bf_b_s4_w2 не влезает в отведённые ему 12 байт")
  .text.bf_b_s4_w4 0x008e8270 : { KEEP(*(.text.bf_b_s4_w4)) }
  ASSERT(SIZEOF(.text.bf_b_s4_w4) <= 12, "блок bf_b_s4_w4 не влезает в отведённые ему 12 байт")
  .text.bf_b_s5_w3 0x008e827c : { KEEP(*(.text.bf_b_s5_w3)) }
  ASSERT(SIZEOF(.text.bf_b_s5_w3) <= 12, "блок bf_b_s5_w3 не влезает в отведённые ему 12 байт")
  .text.bf_b_s6_w2 0x008e8288 : { KEEP(*(.text.bf_b_s6_w2)) }
  ASSERT(SIZEOF(.text.bf_b_s6_w2) <= 12, "блок bf_b_s6_w2 не влезает в отведённые ему 12 байт")
  .text.bf_h_s0_w12 0x008e8294 : { KEEP(*(.text.bf_h_s0_w12)) }
  ASSERT(SIZEOF(.text.bf_h_s0_w12) <= 12, "блок bf_h_s0_w12 не влезает в отведённые ему 12 байт")
  .text.bf_h_s0_w2 0x008e82a0 : { KEEP(*(.text.bf_h_s0_w2)) }
  ASSERT(SIZEOF(.text.bf_h_s0_w2) <= 12, "блок bf_h_s0_w2 не влезает в отведённые ему 12 байт")
  .text.bf_h_s0_w3 0x008e82ac : { KEEP(*(.text.bf_h_s0_w3)) }
  ASSERT(SIZEOF(.text.bf_h_s0_w3) <= 12, "блок bf_h_s0_w3 не влезает в отведённые ему 12 байт")
  .text.bf_h_s0_w4 0x008e82b8 : { KEEP(*(.text.bf_h_s0_w4)) }
  ASSERT(SIZEOF(.text.bf_h_s0_w4) <= 12, "блок bf_h_s0_w4 не влезает в отведённые ему 12 байт")
  .text.bf_h_s2_w2 0x008e82c4 : { KEEP(*(.text.bf_h_s2_w2)) }
  ASSERT(SIZEOF(.text.bf_h_s2_w2) <= 12, "блок bf_h_s2_w2 не влезает в отведённые ему 12 байт")
  .text.bf_h_s4_w2 0x008e82d0 : { KEEP(*(.text.bf_h_s4_w2)) }
  ASSERT(SIZEOF(.text.bf_h_s4_w2) <= 12, "блок bf_h_s4_w2 не влезает в отведённые ему 12 байт")
  .text.bf_h_s4_w4 0x008e82dc : { KEEP(*(.text.bf_h_s4_w4)) }
  ASSERT(SIZEOF(.text.bf_h_s4_w4) <= 12, "блок bf_h_s4_w4 не влезает в отведённые ему 12 байт")
  .text.bf_h_s4_w5 0x008e82e8 : { KEEP(*(.text.bf_h_s4_w5)) }
  ASSERT(SIZEOF(.text.bf_h_s4_w5) <= 12, "блок bf_h_s4_w5 не влезает в отведённые ему 12 байт")
  .text.bf_h_s5_w2 0x008e82f4 : { KEEP(*(.text.bf_h_s5_w2)) }
  ASSERT(SIZEOF(.text.bf_h_s5_w2) <= 12, "блок bf_h_s5_w2 не влезает в отведённые ему 12 байт")
  .text.bf_h_s8_w2 0x008e8300 : { KEEP(*(.text.bf_h_s8_w2)) }
  ASSERT(SIZEOF(.text.bf_h_s8_w2) <= 12, "блок bf_h_s8_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w10 0x008e830c : { KEEP(*(.text.bf_w_s0_w10)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w10) <= 12, "блок bf_w_s0_w10 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w12 0x008e8318 : { KEEP(*(.text.bf_w_s0_w12)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w12) <= 12, "блок bf_w_s0_w12 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w13 0x008e8324 : { KEEP(*(.text.bf_w_s0_w13)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w13) <= 12, "блок bf_w_s0_w13 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w2 0x008e8330 : { KEEP(*(.text.bf_w_s0_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w2) <= 12, "блок bf_w_s0_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w3 0x008e833c : { KEEP(*(.text.bf_w_s0_w3)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w3) <= 12, "блок bf_w_s0_w3 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w4 0x008e8348 : { KEEP(*(.text.bf_w_s0_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w4) <= 12, "блок bf_w_s0_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w5 0x008e8354 : { KEEP(*(.text.bf_w_s0_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w5) <= 12, "блок bf_w_s0_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w6 0x008e8360 : { KEEP(*(.text.bf_w_s0_w6)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w6) <= 12, "блок bf_w_s0_w6 не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w7 0x008e836c : { KEEP(*(.text.bf_w_s0_w7)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w7) <= 12, "блок bf_w_s0_w7 не влезает в отведённые ему 12 байт")
  .text.bf_w_s12_w12 0x008e8378 : { KEEP(*(.text.bf_w_s12_w12)) }
  ASSERT(SIZEOF(.text.bf_w_s12_w12) <= 12, "блок bf_w_s12_w12 не влезает в отведённые ему 12 байт")
  .text.bf_w_s12_w4 0x008e8384 : { KEEP(*(.text.bf_w_s12_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s12_w4) <= 12, "блок bf_w_s12_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s13_w2 0x008e8390 : { KEEP(*(.text.bf_w_s13_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s13_w2) <= 12, "блок bf_w_s13_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s14_w2 0x008e839c : { KEEP(*(.text.bf_w_s14_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s14_w2) <= 12, "блок bf_w_s14_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s14_w3 0x008e83a8 : { KEEP(*(.text.bf_w_s14_w3)) }
  ASSERT(SIZEOF(.text.bf_w_s14_w3) <= 12, "блок bf_w_s14_w3 не влезает в отведённые ему 12 байт")
  .text.bf_w_s15_w17 0x008e83b4 : { KEEP(*(.text.bf_w_s15_w17)) }
  ASSERT(SIZEOF(.text.bf_w_s15_w17) <= 12, "блок bf_w_s15_w17 не влезает в отведённые ему 12 байт")
  .text.bf_w_s16_w12 0x008e83c0 : { KEEP(*(.text.bf_w_s16_w12)) }
  ASSERT(SIZEOF(.text.bf_w_s16_w12) <= 12, "блок bf_w_s16_w12 не влезает в отведённые ему 12 байт")
  .text.bf_w_s16_w4 0x008e83cc : { KEEP(*(.text.bf_w_s16_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s16_w4) <= 12, "блок bf_w_s16_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s16_w5 0x008e83d8 : { KEEP(*(.text.bf_w_s16_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s16_w5) <= 12, "блок bf_w_s16_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s16_w7 0x008e83e4 : { KEEP(*(.text.bf_w_s16_w7)) }
  ASSERT(SIZEOF(.text.bf_w_s16_w7) <= 12, "блок bf_w_s16_w7 не влезает в отведённые ему 12 байт")
  .text.bf_w_s17_w4 0x008e83f0 : { KEEP(*(.text.bf_w_s17_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s17_w4) <= 12, "блок bf_w_s17_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s20_w10 0x008e83fc : { KEEP(*(.text.bf_w_s20_w10)) }
  ASSERT(SIZEOF(.text.bf_w_s20_w10) <= 12, "блок bf_w_s20_w10 не влезает в отведённые ему 12 байт")
  .text.bf_w_s20_w12 0x008e8408 : { KEEP(*(.text.bf_w_s20_w12)) }
  ASSERT(SIZEOF(.text.bf_w_s20_w12) <= 12, "блок bf_w_s20_w12 не влезает в отведённые ему 12 байт")
  .text.bf_w_s21_w5 0x008e8414 : { KEEP(*(.text.bf_w_s21_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s21_w5) <= 12, "блок bf_w_s21_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s22_w2 0x008e8420 : { KEEP(*(.text.bf_w_s22_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s22_w2) <= 12, "блок bf_w_s22_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s22_w5 0x008e842c : { KEEP(*(.text.bf_w_s22_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s22_w5) <= 12, "блок bf_w_s22_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s24_w2 0x008e8438 : { KEEP(*(.text.bf_w_s24_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s24_w2) <= 12, "блок bf_w_s24_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s24_w4 0x008e8444 : { KEEP(*(.text.bf_w_s24_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s24_w4) <= 12, "блок bf_w_s24_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s24_w5 0x008e8450 : { KEEP(*(.text.bf_w_s24_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s24_w5) <= 12, "блок bf_w_s24_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s24_w7 0x008e845c : { KEEP(*(.text.bf_w_s24_w7)) }
  ASSERT(SIZEOF(.text.bf_w_s24_w7) <= 12, "блок bf_w_s24_w7 не влезает в отведённые ему 12 байт")
  .text.bf_w_s26_w2 0x008e8468 : { KEEP(*(.text.bf_w_s26_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s26_w2) <= 12, "блок bf_w_s26_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s27_w5 0x008e8474 : { KEEP(*(.text.bf_w_s27_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s27_w5) <= 12, "блок bf_w_s27_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s28_w4 0x008e8480 : { KEEP(*(.text.bf_w_s28_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s28_w4) <= 12, "блок bf_w_s28_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s29_w2 0x008e848c : { KEEP(*(.text.bf_w_s29_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s29_w2) <= 12, "блок bf_w_s29_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s29_w3 0x008e8498 : { KEEP(*(.text.bf_w_s29_w3)) }
  ASSERT(SIZEOF(.text.bf_w_s29_w3) <= 12, "блок bf_w_s29_w3 не влезает в отведённые ему 12 байт")
  .text.bf_w_s2_w2 0x008e84a4 : { KEEP(*(.text.bf_w_s2_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s2_w2) <= 12, "блок bf_w_s2_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s2_w4 0x008e84b0 : { KEEP(*(.text.bf_w_s2_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s2_w4) <= 12, "блок bf_w_s2_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s3_w29 0x008e84bc : { KEEP(*(.text.bf_w_s3_w29)) }
  ASSERT(SIZEOF(.text.bf_w_s3_w29) <= 12, "блок bf_w_s3_w29 не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w12 0x008e84c8 : { KEEP(*(.text.bf_w_s4_w12)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w12) <= 12, "блок bf_w_s4_w12 не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w2 0x008e84d4 : { KEEP(*(.text.bf_w_s4_w2)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w2) <= 12, "блок bf_w_s4_w2 не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w28 0x008e84e0 : { KEEP(*(.text.bf_w_s4_w28)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w28) <= 12, "блок bf_w_s4_w28 не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w3 0x008e84ec : { KEEP(*(.text.bf_w_s4_w3)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w3) <= 12, "блок bf_w_s4_w3 не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w4 0x008e84f8 : { KEEP(*(.text.bf_w_s4_w4)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w4) <= 12, "блок bf_w_s4_w4 не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w5 0x008e8504 : { KEEP(*(.text.bf_w_s4_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w5) <= 12, "блок bf_w_s4_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s5_w5 0x008e8510 : { KEEP(*(.text.bf_w_s5_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s5_w5) <= 12, "блок bf_w_s5_w5 не влезает в отведённые ему 12 байт")
  .text.bf_w_s6_w14 0x008e851c : { KEEP(*(.text.bf_w_s6_w14)) }
  ASSERT(SIZEOF(.text.bf_w_s6_w14) <= 12, "блок bf_w_s6_w14 не влезает в отведённые ему 12 байт")
  .text.bf_w_s6_w26 0x008e8528 : { KEEP(*(.text.bf_w_s6_w26)) }
  ASSERT(SIZEOF(.text.bf_w_s6_w26) <= 12, "блок bf_w_s6_w26 не влезает в отведённые ему 12 байт")
  .text.bf_w_s7_w8 0x008e8534 : { KEEP(*(.text.bf_w_s7_w8)) }
  ASSERT(SIZEOF(.text.bf_w_s7_w8) <= 12, "блок bf_w_s7_w8 не влезает в отведённые ему 12 байт")
  .text.bf_w_s8_w12 0x008e8540 : { KEEP(*(.text.bf_w_s8_w12)) }
  ASSERT(SIZEOF(.text.bf_w_s8_w12) <= 12, "блок bf_w_s8_w12 не влезает в отведённые ему 12 байт")
  .text.bf_w_s8_w24 0x008e854c : { KEEP(*(.text.bf_w_s8_w24)) }
  ASSERT(SIZEOF(.text.bf_w_s8_w24) <= 12, "блок bf_w_s8_w24 не влезает в отведённые ему 12 байт")
  .text.bf_w_s8_w3 0x008e8558 : { KEEP(*(.text.bf_w_s8_w3)) }
  ASSERT(SIZEOF(.text.bf_w_s8_w3) <= 12, "блок bf_w_s8_w3 не влезает в отведённые ему 12 байт")
  .text.bf_w_s8_w5 0x008e8564 : { KEEP(*(.text.bf_w_s8_w5)) }
  ASSERT(SIZEOF(.text.bf_w_s8_w5) <= 12, "блок bf_w_s8_w5 не влезает в отведённые ему 12 байт")
  .text.tail_rx_pkt_srvs__dispatch_8e8570 0x008e8570 : { KEEP(*(.text.tail_rx_pkt_srvs__dispatch_8e8570)) }
  ASSERT(SIZEOF(.text.tail_rx_pkt_srvs__dispatch_8e8570) <= 4, "блок tail_rx_pkt_srvs__dispatch_8e8570 не влезает в отведённые ему 4 байт")
  .text.frag_8e8574 0x008e8574 : { KEEP(*(.text.frag_8e8574)) }
  ASSERT(SIZEOF(.text.frag_8e8574) <= 12, "блок frag_8e8574 не влезает в отведённые ему 12 байт")
  .text.frag_8e8580 0x008e8580 : { KEEP(*(.text.frag_8e8580)) }
  ASSERT(SIZEOF(.text.frag_8e8580) <= 4, "блок frag_8e8580 не влезает в отведённые ему 4 байт")
  .text.calib_sar__vt24 0x008e8584 : { KEEP(*(.text.calib_sar__vt24)) }
  ASSERT(SIZEOF(.text.calib_sar__vt24) <= 4, "блок calib_sar__vt24 не влезает в отведённые ему 4 байт")
  .text.calib_lo_power__vt24 0x008e8588 : { KEEP(*(.text.calib_lo_power__vt24)) }
  ASSERT(SIZEOF(.text.calib_lo_power__vt24) <= 4, "блок calib_lo_power__vt24 не влезает в отведённые ему 4 байт")
  .text.calib_lo_leakage__vt24 0x008e858c : { KEEP(*(.text.calib_lo_leakage__vt24)) }
  ASSERT(SIZEOF(.text.calib_lo_leakage__vt24) <= 4, "блок calib_lo_leakage__vt24 не влезает в отведённые ему 4 байт")
  .text.calib_if_gain__vt24 0x008e8590 : { KEEP(*(.text.calib_if_gain__vt24)) }
  ASSERT(SIZEOF(.text.calib_if_gain__vt24) <= 4, "блок calib_if_gain__vt24 не влезает в отведённые ему 4 байт")
  .text.calib_bb_gain_dc__vt24 0x008e8594 : { KEEP(*(.text.calib_bb_gain_dc__vt24)) }
  ASSERT(SIZEOF(.text.calib_bb_gain_dc__vt24) <= 4, "блок calib_bb_gain_dc__vt24 не влезает в отведённые ему 4 байт")
  .text.calib_silent_rssi__vt24 0x008e8598 : { KEEP(*(.text.calib_silent_rssi__vt24)) }
  ASSERT(SIZEOF(.text.calib_silent_rssi__vt24) <= 4, "блок calib_silent_rssi__vt24 не влезает в отведённые ему 4 байт")
  .text.frag_8e859c 0x008e859c : { KEEP(*(.text.frag_8e859c)) }
  ASSERT(SIZEOF(.text.frag_8e859c) <= 4, "блок frag_8e859c не влезает в отведённые ему 4 байт")
  .text.frag_8e85a0 0x008e85a0 : { KEEP(*(.text.frag_8e85a0)) }
  ASSERT(SIZEOF(.text.frag_8e85a0) <= 4, "блок frag_8e85a0 не влезает в отведённые ему 4 байт")
  .text.stub_ret_8e85a4 0x008e85a4 : { KEEP(*(.text.stub_ret_8e85a4)) }
  ASSERT(SIZEOF(.text.stub_ret_8e85a4) <= 4, "блок stub_ret_8e85a4 не влезает в отведённые ему 4 байт")
  .text.rm__inject_lock_evt_at28 0x008e85a8 : { KEEP(*(.text.rm__inject_lock_evt_at28)) }
  ASSERT(SIZEOF(.text.rm__inject_lock_evt_at28) <= 8, "блок rm__inject_lock_evt_at28 не влезает в отведённые ему 8 байт")
  .text.rfc__write_buffer_and_wait 0x008e85b0 : { KEEP(*(.text.rfc__write_buffer_and_wait)) }
  ASSERT(SIZEOF(.text.rfc__write_buffer_and_wait) <= 152, "блок rfc__write_buffer_and_wait не влезает в отведённые ему 152 байт")
  .text.pcie__l1_latency_wa 0x008e8648 : { KEEP(*(.text.pcie__l1_latency_wa)) }
  ASSERT(SIZEOF(.text.pcie__l1_latency_wa) <= 532, "блок pcie__l1_latency_wa не влезает в отведённые ему 532 байт")
  .text.frag_8e885c 0x008e885c : { KEEP(*(.text.frag_8e885c)) }
  ASSERT(SIZEOF(.text.frag_8e885c) <= 12, "блок frag_8e885c не влезает в отведённые ему 12 байт")
  .text.bf_insert 0x008e8868 : { KEEP(*(.text.bf_insert)) }
  ASSERT(SIZEOF(.text.bf_insert) <= 36, "блок bf_insert не влезает в отведённые ему 36 байт")
  .text.bf_unaligned16 0x008e888c : { KEEP(*(.text.bf_unaligned16)) }
  ASSERT(SIZEOF(.text.bf_unaligned16) <= 44, "блок bf_unaligned16 не влезает в отведённые ему 44 байт")
  .text.bf_unaligned32 0x008e88b8 : { KEEP(*(.text.bf_unaligned32)) }
  ASSERT(SIZEOF(.text.bf_unaligned32) <= 88, "блок bf_unaligned32 не влезает в отведённые ему 88 байт")
  .text.bf_word_set 0x008e8910 : { KEEP(*(.text.bf_word_set)) }
  ASSERT(SIZEOF(.text.bf_word_set) <= 20, "блок bf_word_set не влезает в отведённые ему 20 байт")
  .text.bf_byte_set 0x008e8924 : { KEEP(*(.text.bf_byte_set)) }
  ASSERT(SIZEOF(.text.bf_byte_set) <= 20, "блок bf_byte_set не влезает в отведённые ему 20 байт")
  .text.bf_half_set 0x008e8938 : { KEEP(*(.text.bf_half_set)) }
  ASSERT(SIZEOF(.text.bf_half_set) <= 20, "блок bf_half_set не влезает в отведённые ему 20 байт")
  .text.mgmt_tx__push_clustering_control 0x008e894c : { KEEP(*(.text.mgmt_tx__push_clustering_control)) }
  ASSERT(SIZEOF(.text.mgmt_tx__push_clustering_control) <= 20, "блок mgmt_tx__push_clustering_control не влезает в отведённые ему 20 байт")
  .text.mgmt_tx__push_bi_control 0x008e8960 : { KEEP(*(.text.mgmt_tx__push_bi_control)) }
  ASSERT(SIZEOF(.text.mgmt_tx__push_bi_control) <= 20, "блок mgmt_tx__push_bi_control не влезает в отведённые ему 20 байт")
  .text.mgmt_tx__set_frame_control 0x008e8974 : { KEEP(*(.text.mgmt_tx__set_frame_control)) }
  ASSERT(SIZEOF(.text.mgmt_tx__set_frame_control) <= 68, "блок mgmt_tx__set_frame_control не влезает в отведённые ему 68 байт")
  .text.BUILDER_push_dmg_parameters 0x008e89b8 : { KEEP(*(.text.BUILDER_push_dmg_parameters)) }
  ASSERT(SIZEOF(.text.BUILDER_push_dmg_parameters) <= 100, "блок BUILDER_push_dmg_parameters не влезает в отведённые ему 100 байт")
  .text.WBE_DRIVER__pcie_boot_init 0x008e8a1c : { KEEP(*(.text.WBE_DRIVER__pcie_boot_init)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__pcie_boot_init) <= 928, "блок WBE_DRIVER__pcie_boot_init не влезает в отведённые ему 928 байт")
  .text.conn__abort 0x008e8dbc : { KEEP(*(.text.conn__abort)) }
  ASSERT(SIZEOF(.text.conn__abort) <= 80, "блок conn__abort не влезает в отведённые ему 80 байт")
  .text.scan_mngr__abort_scan 0x008e8e0c : { KEEP(*(.text.scan_mngr__abort_scan)) }
  ASSERT(SIZEOF(.text.scan_mngr__abort_scan) <= 100, "блок scan_mngr__abort_scan не влезает в отведённые ему 100 байт")
  .text.l2_mgr__aborting_scan 0x008e8e70 : { KEEP(*(.text.l2_mgr__aborting_scan)) }
  ASSERT(SIZEOF(.text.l2_mgr__aborting_scan) <= 104, "блок l2_mgr__aborting_scan не влезает в отведённые ему 104 байт")
  .text.channels_switch_sm__action_abort_allocate 0x008e8ed8 : { KEEP(*(.text.channels_switch_sm__action_abort_allocate)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_abort_allocate) <= 40, "блок channels_switch_sm__action_abort_allocate не влезает в отведённые ему 40 байт")
  .text.channels_switch_sm__action_abort_dwelling 0x008e8f00 : { KEEP(*(.text.channels_switch_sm__action_abort_dwelling)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_abort_dwelling) <= 44, "блок channels_switch_sm__action_abort_dwelling не влезает в отведённые ему 44 байт")
  .text.channels_switch_sm__scan_abort_tunning 0x008e8f2c : { KEEP(*(.text.channels_switch_sm__scan_abort_tunning)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__scan_abort_tunning) <= 32, "блок channels_switch_sm__scan_abort_tunning не влезает в отведённые ему 32 байт")
  .text.channels_switch_sm__action_allocate_radio 0x008e8f4c : { KEEP(*(.text.channels_switch_sm__action_allocate_radio)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_allocate_radio) <= 140, "блок channels_switch_sm__action_allocate_radio не влезает в отведённые ему 140 байт")
  .text.channels_switch_sm__action_dwelling_stopped 0x008e8fd8 : { KEEP(*(.text.channels_switch_sm__action_dwelling_stopped)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_dwelling_stopped) <= 48, "блок channels_switch_sm__action_dwelling_stopped не влезает в отведённые ему 48 байт")
  .text.channels_switch_sm__action_pop_ch_and_tune 0x008e9008 : { KEEP(*(.text.channels_switch_sm__action_pop_ch_and_tune)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_pop_ch_and_tune) <= 236, "блок channels_switch_sm__action_pop_ch_and_tune не влезает в отведённые ему 236 байт")
  .text.channels_switch_sm__action_radio_tunned 0x008e90f4 : { KEEP(*(.text.channels_switch_sm__action_radio_tunned)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_radio_tunned) <= 36, "блок channels_switch_sm__action_radio_tunned не влезает в отведённые ему 36 байт")
  .text.channels_switch_sm__action_scan_complete 0x008e9118 : { KEEP(*(.text.channels_switch_sm__action_scan_complete)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_scan_complete) <= 76, "блок channels_switch_sm__action_scan_complete не влезает в отведённые ему 76 байт")
  .text.channels_switch_sm__action_start_dwelling 0x008e9164 : { KEEP(*(.text.channels_switch_sm__action_start_dwelling)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__action_start_dwelling) <= 96, "блок channels_switch_sm__action_start_dwelling не влезает в отведённые ему 96 байт")
  .text.pcie__rearm_l1_timer 0x008e91c4 : { KEEP(*(.text.pcie__rearm_l1_timer)) }
  ASSERT(SIZEOF(.text.pcie__rearm_l1_timer) <= 48, "блок pcie__rearm_l1_timer не влезает в отведённые ему 48 байт")
  .text.frag_8e91f4 0x008e91f4 : { KEEP(*(.text.frag_8e91f4)) }
  ASSERT(SIZEOF(.text.frag_8e91f4) <= 4, "блок frag_8e91f4 не влезает в отведённые ему 4 байт")
  .text.ba_setup_sm__arm_timer 0x008e91f8 : { KEEP(*(.text.ba_setup_sm__arm_timer)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__arm_timer) <= 64, "блок ba_setup_sm__arm_timer не влезает в отведённые ему 64 байт")
  .text.ba_setup_sm__addba_req_retry_timeout_cb 0x008e9238 : { KEEP(*(.text.ba_setup_sm__addba_req_retry_timeout_cb)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__addba_req_retry_timeout_cb) <= 64, "блок ba_setup_sm__addba_req_retry_timeout_cb не влезает в отведённые ему 64 байт")
  .text.ba_setup_sm__addba_req_sent 0x008e9278 : { KEEP(*(.text.ba_setup_sm__addba_req_sent)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__addba_req_sent) <= 76, "блок ba_setup_sm__addba_req_sent не влезает в отведённые ему 76 байт")
  .text.ba_setup_sm__assert_line 0x008e92c4 : { KEEP(*(.text.ba_setup_sm__assert_line)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__assert_line) <= 24, "блок ba_setup_sm__assert_line не влезает в отведённые ему 24 байт")
  .text.ba_setup_sm__addba_resp 0x008e92dc : { KEEP(*(.text.ba_setup_sm__addba_resp)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__addba_resp) <= 208, "блок ba_setup_sm__addba_resp не влезает в отведённые ему 208 байт")
  .text.ba_setup_sm__addba_resp_timeout_cb 0x008e93ac : { KEEP(*(.text.ba_setup_sm__addba_resp_timeout_cb)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__addba_resp_timeout_cb) <= 68, "блок ba_setup_sm__addba_resp_timeout_cb не влезает в отведённые ему 68 байт")
  .text.tail_8e93f0 0x008e93f0 : { KEEP(*(.text.tail_8e93f0)) }
  ASSERT(SIZEOF(.text.tail_8e93f0) <= 4, "блок tail_8e93f0 не влезает в отведённые ему 4 байт")
  .text.ba_setup_sm__on_abort 0x008e93f4 : { KEEP(*(.text.ba_setup_sm__on_abort)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__on_abort) <= 28, "блок ba_setup_sm__on_abort не влезает в отведённые ему 28 байт")
  .text.ba_setup_sm__addba_session_success 0x008e9410 : { KEEP(*(.text.ba_setup_sm__addba_session_success)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__addba_session_success) <= 44, "блок ba_setup_sm__addba_session_success не влезает в отведённые ему 44 байт")
  .text.frag_8e943c 0x008e943c : { KEEP(*(.text.frag_8e943c)) }
  ASSERT(SIZEOF(.text.frag_8e943c) <= 4, "блок frag_8e943c не влезает в отведённые ему 4 байт")
  .text.install_key_index_stub 0x008e9440 : { KEEP(*(.text.install_key_index_stub)) }
  ASSERT(SIZEOF(.text.install_key_index_stub) <= 100, "блок install_key_index_stub не влезает в отведённые ему 100 байт")
  .text.alloc_dband_info 0x008e94a4 : { KEEP(*(.text.alloc_dband_info)) }
  ASSERT(SIZEOF(.text.alloc_dband_info) <= 36, "блок alloc_dband_info не влезает в отведённые ему 36 байт")
  .text.pcie_perst_handler_step 0x008e94c8 : { KEEP(*(.text.pcie_perst_handler_step)) }
  ASSERT(SIZEOF(.text.pcie_perst_handler_step) <= 168, "блок pcie_perst_handler_step не влезает в отведённые ему 168 байт")
  .text.radio_mgr__reset_and_lock_secondary 0x008e9570 : { KEEP(*(.text.radio_mgr__reset_and_lock_secondary)) }
  ASSERT(SIZEOF(.text.radio_mgr__reset_and_lock_secondary) <= 68, "блок radio_mgr__reset_and_lock_secondary не влезает в отведённые ему 68 байт")
  .text.pcie__dbi_write_shadow 0x008e95b4 : { KEEP(*(.text.pcie__dbi_write_shadow)) }
  ASSERT(SIZEOF(.text.pcie__dbi_write_shadow) <= 180, "блок pcie__dbi_write_shadow не влезает в отведённые ему 180 байт")
  .text.arc_action_point__arm 0x008e9668 : { KEEP(*(.text.arc_action_point__arm)) }
  ASSERT(SIZEOF(.text.arc_action_point__arm) <= 104, "блок arc_action_point__arm не влезает в отведённые ему 104 байт")
  .text.arc__debug_cause 0x008e96d0 : { KEEP(*(.text.arc__debug_cause)) }
  ASSERT(SIZEOF(.text.arc__debug_cause) <= 12, "блок arc__debug_cause не влезает в отведённые ему 12 байт")
  .text.arc__read_aux_by_index 0x008e96dc : { KEEP(*(.text.arc__read_aux_by_index)) }
  ASSERT(SIZEOF(.text.arc__read_aux_by_index) <= 12, "блок arc__read_aux_by_index не влезает в отведённые ему 12 байт")
  .text.arc_action_point__install_default 0x008e96e8 : { KEEP(*(.text.arc_action_point__install_default)) }
  ASSERT(SIZEOF(.text.arc_action_point__install_default) <= 40, "блок arc_action_point__install_default не влезает в отведённые ему 40 байт")
  .text.mlme_sm__assoc_reject_ev_handle 0x008e9710 : { KEEP(*(.text.mlme_sm__assoc_reject_ev_handle)) }
  ASSERT(SIZEOF(.text.mlme_sm__assoc_reject_ev_handle) <= 160, "блок mlme_sm__assoc_reject_ev_handle не влезает в отведённые ему 160 байт")
  .text.mlme_sm__assoc_resp_event 0x008e97b0 : { KEEP(*(.text.mlme_sm__assoc_resp_event)) }
  ASSERT(SIZEOF(.text.mlme_sm__assoc_resp_event) <= 316, "блок mlme_sm__assoc_resp_event не влезает в отведённые ему 316 байт")
  .text.mlme_sm__assoc_resp_start 0x008e98ec : { KEEP(*(.text.mlme_sm__assoc_resp_start)) }
  ASSERT(SIZEOF(.text.mlme_sm__assoc_resp_start) <= 40, "блок mlme_sm__assoc_resp_start не влезает в отведённые ему 40 байт")
  .text.mlme_sm__assoc_timeout_cb 0x008e9914 : { KEEP(*(.text.mlme_sm__assoc_timeout_cb)) }
  ASSERT(SIZEOF(.text.mlme_sm__assoc_timeout_cb) <= 44, "блок mlme_sm__assoc_timeout_cb не влезает в отведённые ему 44 байт")
  .text.mlme_sm__assoc_req_handle 0x008e9940 : { KEEP(*(.text.mlme_sm__assoc_req_handle)) }
  ASSERT(SIZEOF(.text.mlme_sm__assoc_req_handle) <= 640, "блок mlme_sm__assoc_req_handle не влезает в отведённые ему 640 байт")
  .text.l2mgr__publish_assoc_done 0x008e9bc0 : { KEEP(*(.text.l2mgr__publish_assoc_done)) }
  ASSERT(SIZEOF(.text.l2mgr__publish_assoc_done) <= 148, "блок l2mgr__publish_assoc_done не влезает в отведённые ему 148 байт")
  .text.mlme_sm__association_timeout_ev_handle 0x008e9c54 : { KEEP(*(.text.mlme_sm__association_timeout_ev_handle)) }
  ASSERT(SIZEOF(.text.mlme_sm__association_timeout_ev_handle) <= 160, "блок mlme_sm__association_timeout_ev_handle не влезает в отведённые ему 160 байт")
  .text.ba_setup_sm__on_timeout 0x008e9cf4 : { KEEP(*(.text.ba_setup_sm__on_timeout)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__on_timeout) <= 84, "блок ba_setup_sm__on_timeout не влезает в отведённые ему 84 байт")
  .text.find_main_sm__bcon 0x008e9d48 : { KEEP(*(.text.find_main_sm__bcon)) }
  ASSERT(SIZEOF(.text.find_main_sm__bcon) <= 228, "блок find_main_sm__bcon не влезает в отведённые ему 228 байт")
  .text.find_sm__dband_bcon_in_search 0x008e9e2c : { KEEP(*(.text.find_sm__dband_bcon_in_search)) }
  ASSERT(SIZEOF(.text.find_sm__dband_bcon_in_search) <= 52, "блок find_sm__dband_bcon_in_search не влезает в отведённые ему 52 байт")
  .text.find_main_sm__bf_ntf 0x008e9e60 : { KEEP(*(.text.find_main_sm__bf_ntf)) }
  ASSERT(SIZEOF(.text.find_main_sm__bf_ntf) <= 264, "блок find_main_sm__bf_ntf не влезает в отведённые ему 264 байт")
  .text.epi_8e9f68 0x008e9f68 : { KEEP(*(.text.epi_8e9f68)) }
  ASSERT(SIZEOF(.text.epi_8e9f68) <= 4, "блок epi_8e9f68 не влезает в отведённые ему 4 байт")
  .text.maintain_sm__on_bf_results 0x008e9f6c : { KEEP(*(.text.maintain_sm__on_bf_results)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_bf_results) <= 88, "блок maintain_sm__on_bf_results не влезает в отведённые ему 88 байт")
  .text.tx_data_builder__log_addrs 0x008e9fc4 : { KEEP(*(.text.tx_data_builder__log_addrs)) }
  ASSERT(SIZEOF(.text.tx_data_builder__log_addrs) <= 272, "блок tx_data_builder__log_addrs не влезает в отведённые ему 272 байт")
  .text.scan_mngr__calculate_passive_scan_info 0x008ea0d4 : { KEEP(*(.text.scan_mngr__calculate_passive_scan_info)) }
  ASSERT(SIZEOF(.text.scan_mngr__calculate_passive_scan_info) <= 80, "блок scan_mngr__calculate_passive_scan_info не влезает в отведённые ему 80 байт")
  .text.tail_pcie__l1_latency_wa 0x008ea124 : { KEEP(*(.text.tail_pcie__l1_latency_wa)) }
  ASSERT(SIZEOF(.text.tail_pcie__l1_latency_wa) <= 4, "блок tail_pcie__l1_latency_wa не влезает в отведённые ему 4 байт")
  .text.l2_mgr__channel_locked_cb 0x008ea128 : { KEEP(*(.text.l2_mgr__channel_locked_cb)) }
  ASSERT(SIZEOF(.text.l2_mgr__channel_locked_cb) <= 76, "блок l2_mgr__channel_locked_cb не влезает в отведённые ему 76 байт")
  .text.tail_basic_sm__inject_event_8ea174 0x008ea174 : { KEEP(*(.text.tail_basic_sm__inject_event_8ea174)) }
  ASSERT(SIZEOF(.text.tail_basic_sm__inject_event_8ea174) <= 12, "блок tail_basic_sm__inject_event_8ea174 не влезает в отведённые ему 12 байт")
  .text.channels_switch_sm__channel_switched_cb 0x008ea180 : { KEEP(*(.text.channels_switch_sm__channel_switched_cb)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__channel_switched_cb) <= 40, "блок channels_switch_sm__channel_switched_cb не влезает в отведённые ему 40 байт")
  .text.frag_8ea1a8 0x008ea1a8 : { KEEP(*(.text.frag_8ea1a8)) }
  ASSERT(SIZEOF(.text.frag_8ea1a8) <= 4, "блок frag_8ea1a8 не влезает в отведённые ему 4 байт")
  .text.rf_kill_sm__on_w_enable__disabled 0x008ea1ac : { KEEP(*(.text.rf_kill_sm__on_w_enable__disabled)) }
  ASSERT(SIZEOF(.text.rf_kill_sm__on_w_enable__disabled) <= 44, "блок rf_kill_sm__on_w_enable__disabled не влезает в отведённые ему 44 байт")
  .text.l2mgr__false_alarm_aging_cb 0x008ea1d8 : { KEEP(*(.text.l2mgr__false_alarm_aging_cb)) }
  ASSERT(SIZEOF(.text.l2mgr__false_alarm_aging_cb) <= 76, "блок l2mgr__false_alarm_aging_cb не влезает в отведённые ему 76 байт")
  .text.check_rf_boardfile 0x008ea224 : { KEEP(*(.text.check_rf_boardfile)) }
  ASSERT(SIZEOF(.text.check_rf_boardfile) <= 164, "блок check_rf_boardfile не влезает в отведённые ему 164 байт")
  .text.ba__retry_flow 0x008ea2c8 : { KEEP(*(.text.ba__retry_flow)) }
  ASSERT(SIZEOF(.text.ba__retry_flow) <= 92, "блок ba__retry_flow не влезает в отведённые ему 92 байт")
  .text.scan_mngr__clean_all_lists 0x008ea324 : { KEEP(*(.text.scan_mngr__clean_all_lists)) }
  ASSERT(SIZEOF(.text.scan_mngr__clean_all_lists) <= 244, "блок scan_mngr__clean_all_lists не влезает в отведённые ему 244 байт")
  .text.pcie__clear_dbi_gateway 0x008ea418 : { KEEP(*(.text.pcie__clear_dbi_gateway)) }
  ASSERT(SIZEOF(.text.pcie__clear_dbi_gateway) <= 24, "блок pcie__clear_dbi_gateway не влезает в отведённые ему 24 байт")
  .text.ba_setup_sm__close_all_timers 0x008ea430 : { KEEP(*(.text.ba_setup_sm__close_all_timers)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__close_all_timers) <= 48, "блок ba_setup_sm__close_all_timers не влезает в отведённые ему 48 байт")
  .text.ba_setup_sm__close_addba_req_retry_timeout_event 0x008ea460 : { KEEP(*(.text.ba_setup_sm__close_addba_req_retry_timeout_event)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__close_addba_req_retry_timeout_event) <= 40, "блок ba_setup_sm__close_addba_req_retry_timeout_event не влезает в отведённые ему 40 байт")
  .text.ba_setup_sm__close_addba_resp_timeout 0x008ea488 : { KEEP(*(.text.ba_setup_sm__close_addba_resp_timeout)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__close_addba_resp_timeout) <= 40, "блок ba_setup_sm__close_addba_resp_timeout не влезает в отведённые ему 40 байт")
  .text.ba_setup_sm__close_ba_setup_global_timeout 0x008ea4b0 : { KEEP(*(.text.ba_setup_sm__close_ba_setup_global_timeout)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__close_ba_setup_global_timeout) <= 64, "блок ba_setup_sm__close_ba_setup_global_timeout не влезает в отведённые ему 64 байт")
  .text.tx_budget__arm_refill 0x008ea4f0 : { KEEP(*(.text.tx_budget__arm_refill)) }
  ASSERT(SIZEOF(.text.tx_budget__arm_refill) <= 32, "блок tx_budget__arm_refill не влезает в отведённые ему 32 байт")
  .text.l2mgr__config_security 0x008ea510 : { KEEP(*(.text.l2mgr__config_security)) }
  ASSERT(SIZEOF(.text.l2mgr__config_security) <= 48, "блок l2mgr__config_security не влезает в отведённые ему 48 байт")
  .text.scan_mngr__init 0x008ea540 : { KEEP(*(.text.scan_mngr__init)) }
  ASSERT(SIZEOF(.text.scan_mngr__init) <= 36, "блок scan_mngr__init не влезает в отведённые ему 36 байт")
  .text.maintain_sm__set_rs_params 0x008ea564 : { KEEP(*(.text.maintain_sm__set_rs_params)) }
  ASSERT(SIZEOF(.text.maintain_sm__set_rs_params) <= 52, "блок maintain_sm__set_rs_params не влезает в отведённые ему 52 байт")
  .text.calib_lo__set_result 0x008ea598 : { KEEP(*(.text.calib_lo__set_result)) }
  ASSERT(SIZEOF(.text.calib_lo__set_result) <= 12, "блок calib_lo__set_result не влезает в отведённые ему 12 байт")
  .text.scan_mngr__config_dwell_time 0x008ea5a4 : { KEEP(*(.text.scan_mngr__config_dwell_time)) }
  ASSERT(SIZEOF(.text.scan_mngr__config_dwell_time) <= 144, "блок scan_mngr__config_dwell_time не влезает в отведённые ему 144 байт")
  .text.rgf_reg_880280_8ea634 0x008ea634 : { KEEP(*(.text.rgf_reg_880280_8ea634)) }
  ASSERT(SIZEOF(.text.rgf_reg_880280_8ea634) <= 44, "блок rgf_reg_880280_8ea634 не влезает в отведённые ему 44 байт")
  .text.l2_offload__cfg_rx_decap 0x008ea660 : { KEEP(*(.text.l2_offload__cfg_rx_decap)) }
  ASSERT(SIZEOF(.text.l2_offload__cfg_rx_decap) <= 248, "блок l2_offload__cfg_rx_decap не влезает в отведённые ему 248 байт")
  .text.l2_mgr__connect 0x008ea758 : { KEEP(*(.text.l2_mgr__connect)) }
  ASSERT(SIZEOF(.text.l2_mgr__connect) <= 276, "блок l2_mgr__connect не влезает в отведённые ему 276 байт")
  .text.scan_mngr__connect 0x008ea86c : { KEEP(*(.text.scan_mngr__connect)) }
  ASSERT(SIZEOF(.text.scan_mngr__connect) <= 128, "блок scan_mngr__connect не влезает в отведённые ему 128 байт")
  .text.mlme_sm__tx_complete_cb 0x008ea8ec : { KEEP(*(.text.mlme_sm__tx_complete_cb)) }
  ASSERT(SIZEOF(.text.mlme_sm__tx_complete_cb) <= 152, "блок mlme_sm__tx_complete_cb не влезает в отведённые ему 152 байт")
  .text.mid__copy_addr 0x008ea984 : { KEEP(*(.text.mid__copy_addr)) }
  ASSERT(SIZEOF(.text.mid__copy_addr) <= 16, "блок mid__copy_addr не влезает в отведённые ему 16 байт")
  .text.boot__init_named_object 0x008ea994 : { KEEP(*(.text.boot__init_named_object)) }
  ASSERT(SIZEOF(.text.boot__init_named_object) <= 44, "блок boot__init_named_object не влезает в отведённые ему 44 байт")
  .text.boot__copy_name 0x008ea9c0 : { KEEP(*(.text.boot__copy_name)) }
  ASSERT(SIZEOF(.text.boot__copy_name) <= 8, "блок boot__copy_name не влезает в отведённые ему 8 байт")
  .text.frag_8ea9c8 0x008ea9c8 : { KEEP(*(.text.frag_8ea9c8)) }
  ASSERT(SIZEOF(.text.frag_8ea9c8) <= 4, "блок frag_8ea9c8 не влезает в отведённые ему 4 байт")
  .text.mlme_sm__on_evt8 0x008ea9cc : { KEEP(*(.text.mlme_sm__on_evt8)) }
  ASSERT(SIZEOF(.text.mlme_sm__on_evt8) <= 8, "блок mlme_sm__on_evt8 не влезает в отведённые ему 8 байт")
  .text.mlme_sm__data_port_open_ev_handle 0x008ea9d4 : { KEEP(*(.text.mlme_sm__data_port_open_ev_handle)) }
  ASSERT(SIZEOF(.text.mlme_sm__data_port_open_ev_handle) <= 104, "блок mlme_sm__data_port_open_ev_handle не влезает в отведённые ему 104 байт")
  .text.l2mgr__data_port_open_timeout_cb 0x008eaa3c : { KEEP(*(.text.l2mgr__data_port_open_timeout_cb)) }
  ASSERT(SIZEOF(.text.l2mgr__data_port_open_timeout_cb) <= 40, "блок l2mgr__data_port_open_timeout_cb не влезает в отведённые ему 40 байт")
  .text.pcie_serdes_step 0x008eaa64 : { KEEP(*(.text.pcie_serdes_step)) }
  ASSERT(SIZEOF(.text.pcie_serdes_step) <= 132, "блок pcie_serdes_step не влезает в отведённые ему 132 байт")
  .text.pcie__dbi_transfer 0x008eaae8 : { KEEP(*(.text.pcie__dbi_transfer)) }
  ASSERT(SIZEOF(.text.pcie__dbi_transfer) <= 172, "блок pcie__dbi_transfer не влезает в отведённые ему 172 байт")
  .text.hwd_pcie_dbi_write 0x008eab94 : { KEEP(*(.text.hwd_pcie_dbi_write)) }
  ASSERT(SIZEOF(.text.hwd_pcie_dbi_write) <= 116, "блок hwd_pcie_dbi_write не влезает в отведённые ему 116 байт")
  .text.link_lost_diag__dump_dma 0x008eac08 : { KEEP(*(.text.link_lost_diag__dump_dma)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_dma) <= 28, "блок link_lost_diag__dump_dma не влезает в отведённые ему 28 байт")
  .text.link_lost_diag__dump_all 0x008eac24 : { KEEP(*(.text.link_lost_diag__dump_all)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_all) <= 36, "блок link_lost_diag__dump_all не влезает в отведённые ему 36 байт")
  .text.link_lost_diag_part2 0x008eac48 : { KEEP(*(.text.link_lost_diag_part2)) }
  ASSERT(SIZEOF(.text.link_lost_diag_part2) <= 240, "блок link_lost_diag_part2 не влезает в отведённые ему 240 байт")
  .text.link_lost_diag__dump_mac_rx 0x008ead38 : { KEEP(*(.text.link_lost_diag__dump_mac_rx)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_mac_rx) <= 228, "блок link_lost_diag__dump_mac_rx не влезает в отведённые ему 228 байт")
  .text.link_lost_diag__dump_pcie 0x008eae1c : { KEEP(*(.text.link_lost_diag__dump_pcie)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_pcie) <= 68, "блок link_lost_diag__dump_pcie не влезает в отведённые ему 68 байт")
  .text.link_lost_diag__dump_false_alarms 0x008eae60 : { KEEP(*(.text.link_lost_diag__dump_false_alarms)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_false_alarms) <= 68, "блок link_lost_diag__dump_false_alarms не влезает в отведённые ему 68 байт")
  .text.link_lost_diag__dump_rf 0x008eaea4 : { KEEP(*(.text.link_lost_diag__dump_rf)) }
  ASSERT(SIZEOF(.text.link_lost_diag__dump_rf) <= 228, "блок link_lost_diag__dump_rf не влезает в отведённые ему 228 байт")
  .text.maintain_sm__reset_link_cfg 0x008eaf88 : { KEEP(*(.text.maintain_sm__reset_link_cfg)) }
  ASSERT(SIZEOF(.text.maintain_sm__reset_link_cfg) <= 72, "блок maintain_sm__reset_link_cfg не влезает в отведённые ему 72 байт")
  .text.rf_kill_sm__on_w_disable__enabled 0x008eafd0 : { KEEP(*(.text.rf_kill_sm__on_w_disable__enabled)) }
  ASSERT(SIZEOF(.text.rf_kill_sm__on_w_disable__enabled) <= 32, "блок rf_kill_sm__on_w_disable__enabled не влезает в отведённые ему 32 байт")
  .text.disassoc_done 0x008eaff0 : { KEEP(*(.text.disassoc_done)) }
  ASSERT(SIZEOF(.text.disassoc_done) <= 88, "блок disassoc_done не влезает в отведённые ему 88 байт")
  .text.conn_disc_sm__disassoc_sent_cb 0x008eb048 : { KEEP(*(.text.conn_disc_sm__disassoc_sent_cb)) }
  ASSERT(SIZEOF(.text.conn_disc_sm__disassoc_sent_cb) <= 76, "блок conn_disc_sm__disassoc_sent_cb не влезает в отведённые ему 76 байт")
  .text.mlme_sm__handle_disassoc 0x008eb094 : { KEEP(*(.text.mlme_sm__handle_disassoc)) }
  ASSERT(SIZEOF(.text.mlme_sm__handle_disassoc) <= 108, "блок mlme_sm__handle_disassoc не влезает в отведённые ему 108 байт")
  .text.tail_8eb100 0x008eb100 : { KEEP(*(.text.tail_8eb100)) }
  ASSERT(SIZEOF(.text.tail_8eb100) <= 4, "блок tail_8eb100 не влезает в отведённые ему 4 байт")
  .text.disconn_sm__on_own_disc_done 0x008eb104 : { KEEP(*(.text.disconn_sm__on_own_disc_done)) }
  ASSERT(SIZEOF(.text.disconn_sm__on_own_disc_done) <= 24, "блок disconn_sm__on_own_disc_done не влезает в отведённые ему 24 байт")
  .text.l2mgr__disconnect_flow 0x008eb11c : { KEEP(*(.text.l2mgr__disconnect_flow)) }
  ASSERT(SIZEOF(.text.l2mgr__disconnect_flow) <= 72, "блок l2mgr__disconnect_flow не влезает в отведённые ему 72 байт")
  .text.disc_wd_timeout_cb 0x008eb164 : { KEEP(*(.text.disc_wd_timeout_cb)) }
  ASSERT(SIZEOF(.text.disc_wd_timeout_cb) <= 40, "блок disc_wd_timeout_cb не влезает в отведённые ему 40 байт")
  .text.frag_8eb18c 0x008eb18c : { KEEP(*(.text.frag_8eb18c)) }
  ASSERT(SIZEOF(.text.frag_8eb18c) <= 4, "блок frag_8eb18c не влезает в отведённые ему 4 байт")
  .text.conn__disconnect 0x008eb190 : { KEEP(*(.text.conn__disconnect)) }
  ASSERT(SIZEOF(.text.conn__disconnect) <= 68, "блок conn__disconnect не влезает в отведённые ему 68 байт")
  .text.wmi_handler_disconnect_log 0x008eb1d4 : { KEEP(*(.text.wmi_handler_disconnect_log)) }
  ASSERT(SIZEOF(.text.wmi_handler_disconnect_log) <= 88, "блок wmi_handler_disconnect_log не влезает в отведённые ему 88 байт")
  .text.disconnect_by_peer 0x008eb22c : { KEEP(*(.text.disconnect_by_peer)) }
  ASSERT(SIZEOF(.text.disconnect_by_peer) <= 68, "блок disconnect_by_peer не влезает в отведённые ему 68 байт")
  .text.l2mgr__disconnect_done 0x008eb270 : { KEEP(*(.text.l2mgr__disconnect_done)) }
  ASSERT(SIZEOF(.text.l2mgr__disconnect_done) <= 248, "блок l2mgr__disconnect_done не влезает в отведённые ему 248 байт")
  .text.mlme_sm__disconnect_ev_handle 0x008eb368 : { KEEP(*(.text.mlme_sm__disconnect_ev_handle)) }
  ASSERT(SIZEOF(.text.mlme_sm__disconnect_ev_handle) <= 224, "блок mlme_sm__disconnect_ev_handle не влезает в отведённые ему 224 байт")
  .text.l2mgr__wmi_disconnect_log 0x008eb448 : { KEEP(*(.text.l2mgr__wmi_disconnect_log)) }
  ASSERT(SIZEOF(.text.l2mgr__wmi_disconnect_log) <= 76, "блок l2mgr__wmi_disconnect_log не влезает в отведённые ему 76 байт")
  .text.l2mgr__disconnect_sta 0x008eb494 : { KEEP(*(.text.l2mgr__disconnect_sta)) }
  ASSERT(SIZEOF(.text.l2mgr__disconnect_sta) <= 112, "блок l2mgr__disconnect_sta не влезает в отведённые ему 112 байт")
  .text.conn_main_sm__report_disc_state 0x008eb504 : { KEEP(*(.text.conn_main_sm__report_disc_state)) }
  ASSERT(SIZEOF(.text.conn_main_sm__report_disc_state) <= 8, "блок conn_main_sm__report_disc_state не влезает в отведённые ему 8 байт")
  .text.discovery_handle_probe_req 0x008eb50c : { KEEP(*(.text.discovery_handle_probe_req)) }
  ASSERT(SIZEOF(.text.discovery_handle_probe_req) <= 364, "блок discovery_handle_probe_req не влезает в отведённые ему 364 байт")
  .text.discovery_handle_probe_resp 0x008eb678 : { KEEP(*(.text.discovery_handle_probe_resp)) }
  ASSERT(SIZEOF(.text.discovery_handle_probe_resp) <= 244, "блок discovery_handle_probe_resp не влезает в отведённые ему 244 байт")
  .text.discovery_is_ssid_approved 0x008eb76c : { KEEP(*(.text.discovery_is_ssid_approved)) }
  ASSERT(SIZEOF(.text.discovery_is_ssid_approved) <= 184, "блок discovery_is_ssid_approved не влезает в отведённые ему 184 байт")
  .text.mgmt_tx__render_probe_resp 0x008eb824 : { KEEP(*(.text.mgmt_tx__render_probe_resp)) }
  ASSERT(SIZEOF(.text.mgmt_tx__render_probe_resp) <= 72, "блок mgmt_tx__render_probe_resp не влезает в отведённые ему 72 байт")
  .text.channels_switch_sm__dwell_timeout_cb 0x008eb86c : { KEEP(*(.text.channels_switch_sm__dwell_timeout_cb)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__dwell_timeout_cb) <= 36, "блок channels_switch_sm__dwell_timeout_cb не влезает в отведённые ему 36 байт")
  .text.maintain_sm__fbf_failed 0x008eb890 : { KEEP(*(.text.maintain_sm__fbf_failed)) }
  ASSERT(SIZEOF(.text.maintain_sm__fbf_failed) <= 72, "блок maintain_sm__fbf_failed не влезает в отведённые ему 72 байт")
  .text.frag_8eb8d8 0x008eb8d8 : { KEEP(*(.text.frag_8eb8d8)) }
  ASSERT(SIZEOF(.text.frag_8eb8d8) <= 4, "блок frag_8eb8d8 не влезает в отведённые ему 4 байт")
  .text.find_main_sm__first_detection 0x008eb8dc : { KEEP(*(.text.find_main_sm__first_detection)) }
  ASSERT(SIZEOF(.text.find_main_sm__first_detection) <= 44, "блок find_main_sm__first_detection не влезает в отведённые ему 44 байт")
  .text.MAINTAIN_SM__OPEN 0x008eb908 : { KEEP(*(.text.MAINTAIN_SM__OPEN)) }
  ASSERT(SIZEOF(.text.MAINTAIN_SM__OPEN) <= 164, "блок MAINTAIN_SM__OPEN не влезает в отведённые ему 164 байт")
  .text.lo_power_gc_ctrl 0x008eb9ac : { KEEP(*(.text.lo_power_gc_ctrl)) }
  ASSERT(SIZEOF(.text.lo_power_gc_ctrl) <= 464, "блок lo_power_gc_ctrl не влезает в отведённые ему 464 байт")
  .text.tail_mem_pool__free 0x008ebb7c : { KEEP(*(.text.tail_mem_pool__free)) }
  ASSERT(SIZEOF(.text.tail_mem_pool__free) <= 12, "блок tail_mem_pool__free не влезает в отведённые ему 12 байт")
  .text.free_dband_info 0x008ebb88 : { KEEP(*(.text.free_dband_info)) }
  ASSERT(SIZEOF(.text.free_dband_info) <= 36, "блок free_dband_info не влезает в отведённые ему 36 байт")
  .text.disconn_sm__on_ntf_fw_tx_stopped 0x008ebbac : { KEEP(*(.text.disconn_sm__on_ntf_fw_tx_stopped)) }
  ASSERT(SIZEOF(.text.disconn_sm__on_ntf_fw_tx_stopped) <= 72, "блок disconn_sm__on_ntf_fw_tx_stopped не влезает в отведённые ему 72 байт")
  .text.set_reg_880a10 0x008ebbf4 : { KEEP(*(.text.set_reg_880a10)) }
  ASSERT(SIZEOF(.text.set_reg_880a10) <= 12, "блок set_reg_880a10 не влезает в отведённые ему 12 байт")
  .text.fw_version__log_date 0x008ebc00 : { KEEP(*(.text.fw_version__log_date)) }
  ASSERT(SIZEOF(.text.fw_version__log_date) <= 88, "блок fw_version__log_date не влезает в отведённые ему 88 байт")
  .text.fw_version__log 0x008ebc58 : { KEEP(*(.text.fw_version__log)) }
  ASSERT(SIZEOF(.text.fw_version__log) <= 56, "блок fw_version__log не влезает в отведённые ему 56 байт")
  .text.pcie__l1_sub_timing_setup 0x008ebc90 : { KEEP(*(.text.pcie__l1_sub_timing_setup)) }
  ASSERT(SIZEOF(.text.pcie__l1_sub_timing_setup) <= 24, "блок pcie__l1_sub_timing_setup не влезает в отведённые ему 24 байт")
  .text.frag_8ebca8 0x008ebca8 : { KEEP(*(.text.frag_8ebca8)) }
  ASSERT(SIZEOF(.text.frag_8ebca8) <= 20, "блок frag_8ebca8 не влезает в отведённые ему 20 байт")
  .text.obj__set_vtable_801888 0x008ebcbc : { KEEP(*(.text.obj__set_vtable_801888)) }
  ASSERT(SIZEOF(.text.obj__set_vtable_801888) <= 16, "блок obj__set_vtable_801888 не влезает в отведённые ему 16 байт")
  .text.fw_ver__fill_from_regs 0x008ebccc : { KEEP(*(.text.fw_ver__fill_from_regs)) }
  ASSERT(SIZEOF(.text.fw_ver__fill_from_regs) <= 56, "блок fw_ver__fill_from_regs не влезает в отведённые ему 56 байт")
  .text.scan__entry_by_index 0x008ebd04 : { KEEP(*(.text.scan__entry_by_index)) }
  ASSERT(SIZEOF(.text.scan__entry_by_index) <= 16, "блок scan__entry_by_index не влезает в отведённые ему 16 байт")
  .text.mid_ctx__at 0x008ebd14 : { KEEP(*(.text.mid_ctx__at)) }
  ASSERT(SIZEOF(.text.mid_ctx__at) <= 12, "блок mid_ctx__at не влезает в отведённые ему 12 байт")
  .text.llist_pair__insert_into_shorter 0x008ebd20 : { KEEP(*(.text.llist_pair__insert_into_shorter)) }
  ASSERT(SIZEOF(.text.llist_pair__insert_into_shorter) <= 92, "блок llist_pair__insert_into_shorter не влезает в отведённые ему 92 байт")
  .text.flags_of_g800180_g800184 0x008ebd7c : { KEEP(*(.text.flags_of_g800180_g800184)) }
  ASSERT(SIZEOF(.text.flags_of_g800180_g800184) <= 40, "блок flags_of_g800180_g800184 не влезает в отведённые ему 40 байт")
  .text.stub_ret_8ebda4 0x008ebda4 : { KEEP(*(.text.stub_ret_8ebda4)) }
  ASSERT(SIZEOF(.text.stub_ret_8ebda4) <= 4, "блок stub_ret_8ebda4 не влезает в отведённые ему 4 байт")
  .text.scan_mngr__handle_abft_bf_result_in_scan 0x008ebda8 : { KEEP(*(.text.scan_mngr__handle_abft_bf_result_in_scan)) }
  ASSERT(SIZEOF(.text.scan_mngr__handle_abft_bf_result_in_scan) <= 224, "блок scan_mngr__handle_abft_bf_result_in_scan не влезает в отведённые ему 224 байт")
  .text.handle_abft_event 0x008ebe88 : { KEEP(*(.text.handle_abft_event)) }
  ASSERT(SIZEOF(.text.handle_abft_event) <= 56, "блок handle_abft_event не влезает в отведённые ему 56 байт")
  .text.l2mgr__notify_link_up 0x008ebec0 : { KEEP(*(.text.l2mgr__notify_link_up)) }
  ASSERT(SIZEOF(.text.l2mgr__notify_link_up) <= 36, "блок l2mgr__notify_link_up не влезает в отведённые ему 36 байт")
  .text.scan_mngr__handle_link_up_event 0x008ebee4 : { KEEP(*(.text.scan_mngr__handle_link_up_event)) }
  ASSERT(SIZEOF(.text.scan_mngr__handle_link_up_event) <= 236, "блок scan_mngr__handle_link_up_event не влезает в отведённые ему 236 байт")
  .text.l2_mgr__high_false_alarm_secondary_lock_cb 0x008ebfd0 : { KEEP(*(.text.l2_mgr__high_false_alarm_secondary_lock_cb)) }
  ASSERT(SIZEOF(.text.l2_mgr__high_false_alarm_secondary_lock_cb) <= 140, "блок l2_mgr__high_false_alarm_secondary_lock_cb не влезает в отведённые ему 140 байт")
  .text.g_80008c__clear_if_8825c0_bit1 0x008ec05c : { KEEP(*(.text.g_80008c__clear_if_8825c0_bit1)) }
  ASSERT(SIZEOF(.text.g_80008c__clear_if_8825c0_bit1) <= 20, "блок g_80008c__clear_if_8825c0_bit1 не влезает в отведённые ему 20 байт")
  .text.lmac_if__send_init_cfg 0x008ec070 : { KEEP(*(.text.lmac_if__send_init_cfg)) }
  ASSERT(SIZEOF(.text.lmac_if__send_init_cfg) <= 164, "блок lmac_if__send_init_cfg не влезает в отведённые ему 164 байт")
  .text.mac_bringup__prog_881000 0x008ec114 : { KEEP(*(.text.mac_bringup__prog_881000)) }
  ASSERT(SIZEOF(.text.mac_bringup__prog_881000) <= 124, "блок mac_bringup__prog_881000 не влезает в отведённые ему 124 байт")
  .text.hwf_rf_xpm_block_access_check_inputs 0x008ec190 : { KEEP(*(.text.hwf_rf_xpm_block_access_check_inputs)) }
  ASSERT(SIZEOF(.text.hwf_rf_xpm_block_access_check_inputs) <= 268, "блок hwf_rf_xpm_block_access_check_inputs не влезает в отведённые ему 268 байт")
  .text.hwf_rf_xpm_read_block 0x008ec29c : { KEEP(*(.text.hwf_rf_xpm_read_block)) }
  ASSERT(SIZEOF(.text.hwf_rf_xpm_read_block) <= 108, "блок hwf_rf_xpm_read_block не влезает в отведённые ему 108 байт")
  .text.hwf_rf_xpm_read_byte 0x008ec308 : { KEEP(*(.text.hwf_rf_xpm_read_byte)) }
  ASSERT(SIZEOF(.text.hwf_rf_xpm_read_byte) <= 88, "блок hwf_rf_xpm_read_byte не влезает в отведённые ему 88 байт")
  .text.hwf_rf_xpm_single_byte_access_check_inputs 0x008ec360 : { KEEP(*(.text.hwf_rf_xpm_single_byte_access_check_inputs)) }
  ASSERT(SIZEOF(.text.hwf_rf_xpm_single_byte_access_check_inputs) <= 132, "блок hwf_rf_xpm_single_byte_access_check_inputs не влезает в отведённые ему 132 байт")
  .text.baseband__identify 0x008ec3e4 : { KEEP(*(.text.baseband__identify)) }
  ASSERT(SIZEOF(.text.baseband__identify) <= 120, "блок baseband__identify не влезает в отведённые ему 120 байт")
  .text.rf__identify_type 0x008ec45c : { KEEP(*(.text.rf__identify_type)) }
  ASSERT(SIZEOF(.text.rf__identify_type) <= 152, "блок rf__identify_type не влезает в отведённые ему 152 байт")
  .text.tx_hdr_build_step 0x008ec4f4 : { KEEP(*(.text.tx_hdr_build_step)) }
  ASSERT(SIZEOF(.text.tx_hdr_build_step) <= 164, "блок tx_hdr_build_step не влезает в отведённые ему 164 байт")
  .text.llc_snap__write_header 0x008ec598 : { KEEP(*(.text.llc_snap__write_header)) }
  ASSERT(SIZEOF(.text.llc_snap__write_header) <= 40, "блок llc_snap__write_header не влезает в отведённые ему 40 байт")
  .text.mgmt_tx__build_mac_header 0x008ec5c0 : { KEEP(*(.text.mgmt_tx__build_mac_header)) }
  ASSERT(SIZEOF(.text.mgmt_tx__build_mac_header) <= 60, "блок mgmt_tx__build_mac_header не влезает в отведённые ему 60 байт")
  .text.frame__build_addba_req 0x008ec5fc : { KEEP(*(.text.frame__build_addba_req)) }
  ASSERT(SIZEOF(.text.frame__build_addba_req) <= 104, "блок frame__build_addba_req не влезает в отведённые ему 104 байт")
  .text.frame__build_addba_resp 0x008ec664 : { KEEP(*(.text.frame__build_addba_resp)) }
  ASSERT(SIZEOF(.text.frame__build_addba_resp) <= 108, "блок frame__build_addba_resp не влезает в отведённые ему 108 байт")
  .text.mgmt_tx__assoc_req_fixed_fields 0x008ec6d0 : { KEEP(*(.text.mgmt_tx__assoc_req_fixed_fields)) }
  ASSERT(SIZEOF(.text.mgmt_tx__assoc_req_fixed_fields) <= 36, "блок mgmt_tx__assoc_req_fixed_fields не влезает в отведённые ему 36 байт")
  .text.mgmt_tx__assoc_req_ies 0x008ec6f4 : { KEEP(*(.text.mgmt_tx__assoc_req_ies)) }
  ASSERT(SIZEOF(.text.mgmt_tx__assoc_req_ies) <= 96, "блок mgmt_tx__assoc_req_ies не влезает в отведённые ему 96 байт")
  .text.frame_builder__assoc_resp_fix_fields 0x008ec754 : { KEEP(*(.text.frame_builder__assoc_resp_fix_fields)) }
  ASSERT(SIZEOF(.text.frame_builder__assoc_resp_fix_fields) <= 140, "блок frame_builder__assoc_resp_fix_fields не влезает в отведённые ему 140 байт")
  .text.mgmt_tx__assoc_resp_tlv 0x008ec7e0 : { KEEP(*(.text.mgmt_tx__assoc_resp_tlv)) }
  ASSERT(SIZEOF(.text.mgmt_tx__assoc_resp_tlv) <= 128, "блок mgmt_tx__assoc_resp_tlv не влезает в отведённые ему 128 байт")
  .text.frame__build_delba 0x008ec860 : { KEEP(*(.text.frame__build_delba)) }
  ASSERT(SIZEOF(.text.frame__build_delba) <= 60, "блок frame__build_delba не влезает в отведённые ему 60 байт")
  .text.tx_mgmt_build_step 0x008ec89c : { KEEP(*(.text.tx_mgmt_build_step)) }
  ASSERT(SIZEOF(.text.tx_mgmt_build_step) <= 132, "блок tx_mgmt_build_step не влезает в отведённые ему 132 байт")
  .text.ieee80211_mgt_information_response_construct 0x008ec920 : { KEEP(*(.text.ieee80211_mgt_information_response_construct)) }
  ASSERT(SIZEOF(.text.ieee80211_mgt_information_response_construct) <= 264, "блок ieee80211_mgt_information_response_construct не влезает в отведённые ему 264 байт")
  .text.mgmt_tx__probe_req_ies 0x008eca28 : { KEEP(*(.text.mgmt_tx__probe_req_ies)) }
  ASSERT(SIZEOF(.text.mgmt_tx__probe_req_ies) <= 92, "блок mgmt_tx__probe_req_ies не влезает в отведённые ему 92 байт")
  .text.mgmt_tx__probe_resp_tsf_bi_ie 0x008eca84 : { KEEP(*(.text.mgmt_tx__probe_resp_tsf_bi_ie)) }
  ASSERT(SIZEOF(.text.mgmt_tx__probe_resp_tsf_bi_ie) <= 104, "блок mgmt_tx__probe_resp_tsf_bi_ie не влезает в отведённые ему 104 байт")
  .text.mgmt_tx__append_probe_resp_ies 0x008ecaec : { KEEP(*(.text.mgmt_tx__append_probe_resp_ies)) }
  ASSERT(SIZEOF(.text.mgmt_tx__append_probe_resp_ies) <= 232, "блок mgmt_tx__append_probe_resp_ies не влезает в отведённые ему 232 байт")
  .text.frame__build_psc_req 0x008ecbd4 : { KEEP(*(.text.frame__build_psc_req)) }
  ASSERT(SIZEOF(.text.frame__build_psc_req) <= 108, "блок frame__build_psc_req не влезает в отведённые ему 108 байт")
  .text.frame__build_psc_resp 0x008ecc40 : { KEEP(*(.text.frame__build_psc_resp)) }
  ASSERT(SIZEOF(.text.frame__build_psc_resp) <= 108, "блок frame__build_psc_resp не влезает в отведённые ему 108 байт")
  .text.frame__build_psc_resp_short 0x008eccac : { KEEP(*(.text.frame__build_psc_resp_short)) }
  ASSERT(SIZEOF(.text.frame__build_psc_resp_short) <= 100, "блок frame__build_psc_resp_short не влезает в отведённые ему 100 байт")
  .text.mgmt_tx__probe_resp_ies 0x008ecd10 : { KEEP(*(.text.mgmt_tx__probe_resp_ies)) }
  ASSERT(SIZEOF(.text.mgmt_tx__probe_resp_ies) <= 628, "блок mgmt_tx__probe_resp_ies не влезает в отведённые ему 628 байт")
  .text.rf_kill_sm__init 0x008ecf84 : { KEEP(*(.text.rf_kill_sm__init)) }
  ASSERT(SIZEOF(.text.rf_kill_sm__init) <= 124, "блок rf_kill_sm__init не влезает в отведённые ему 124 байт")
  .text.boot__init_subsystems 0x008ed000 : { KEEP(*(.text.boot__init_subsystems)) }
  ASSERT(SIZEOF(.text.boot__init_subsystems) <= 192, "блок boot__init_subsystems не влезает в отведённые ему 192 байт")
  .text.set_g_8000b0_x3 0x008ed0c0 : { KEEP(*(.text.set_g_8000b0_x3)) }
  ASSERT(SIZEOF(.text.set_g_8000b0_x3) <= 16, "блок set_g_8000b0_x3 не влезает в отведённые ему 16 байт")
  .text.ba_setup_sm__init 0x008ed0d0 : { KEEP(*(.text.ba_setup_sm__init)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__init) <= 68, "блок ba_setup_sm__init не влезает в отведённые ему 68 байт")
  .text.maintain_sm__init 0x008ed114 : { KEEP(*(.text.maintain_sm__init)) }
  ASSERT(SIZEOF(.text.maintain_sm__init) <= 116, "блок maintain_sm__init не влезает в отведённые ему 116 байт")
  .text.disconn_sm__init 0x008ed188 : { KEEP(*(.text.disconn_sm__init)) }
  ASSERT(SIZEOF(.text.disconn_sm__init) <= 56, "блок disconn_sm__init не влезает в отведённые ему 56 байт")
  .text.find_main_sm__init 0x008ed1c0 : { KEEP(*(.text.find_main_sm__init)) }
  ASSERT(SIZEOF(.text.find_main_sm__init) <= 64, "блок find_main_sm__init не влезает в отведённые ему 64 байт")
  .text.mid__set_default_counters 0x008ed200 : { KEEP(*(.text.mid__set_default_counters)) }
  ASSERT(SIZEOF(.text.mid__set_default_counters) <= 24, "блок mid__set_default_counters не влезает в отведённые ему 24 байт")
  .text.dashboard__init 0x008ed218 : { KEEP(*(.text.dashboard__init)) }
  ASSERT(SIZEOF(.text.dashboard__init) <= 44, "блок dashboard__init не влезает в отведённые ему 44 байт")
  .text.channels_switch_sm__init 0x008ed244 : { KEEP(*(.text.channels_switch_sm__init)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__init) <= 76, "блок channels_switch_sm__init не влезает в отведённые ему 76 байт")
  .text.connection__init 0x008ed290 : { KEEP(*(.text.connection__init)) }
  ASSERT(SIZEOF(.text.connection__init) <= 120, "блок connection__init не влезает в отведённые ему 120 байт")
  .text.tx_api__init_oob_pools 0x008ed308 : { KEEP(*(.text.tx_api__init_oob_pools)) }
  ASSERT(SIZEOF(.text.tx_api__init_oob_pools) <= 144, "блок tx_api__init_oob_pools не влезает в отведённые ему 144 байт")
  .text.l2mgr__init 0x008ed398 : { KEEP(*(.text.l2mgr__init)) }
  ASSERT(SIZEOF(.text.l2mgr__init) <= 156, "блок l2mgr__init не влезает в отведённые ему 156 байт")
  .text.l2mgr__init_operational_if 0x008ed434 : { KEEP(*(.text.l2mgr__init_operational_if)) }
  ASSERT(SIZEOF(.text.l2mgr__init_operational_if) <= 32, "блок l2mgr__init_operational_if не влезает в отведённые ему 32 байт")
  .text.mlme_sm__init 0x008ed454 : { KEEP(*(.text.mlme_sm__init)) }
  ASSERT(SIZEOF(.text.mlme_sm__init) <= 76, "блок mlme_sm__init не влезает в отведённые ему 76 байт")
  .text.l2mgr__init_radio_mgr 0x008ed4a0 : { KEEP(*(.text.l2mgr__init_radio_mgr)) }
  ASSERT(SIZEOF(.text.l2mgr__init_radio_mgr) <= 24, "блок l2mgr__init_radio_mgr не влезает в отведённые ему 24 байт")
  .text.mid__open_reset_state 0x008ed4b8 : { KEEP(*(.text.mid__open_reset_state)) }
  ASSERT(SIZEOF(.text.mid__open_reset_state) <= 92, "блок mid__open_reset_state не влезает в отведённые ему 92 байт")
  .text.mid_ctx_pool__init 0x008ed514 : { KEEP(*(.text.mid_ctx_pool__init)) }
  ASSERT(SIZEOF(.text.mid_ctx_pool__init) <= 48, "блок mid_ctx_pool__init не влезает в отведённые ему 48 байт")
  .text.l2mgr__init_mbox 0x008ed544 : { KEEP(*(.text.l2mgr__init_mbox)) }
  ASSERT(SIZEOF(.text.l2mgr__init_mbox) <= 16, "блок l2mgr__init_mbox не влезает в отведённые ему 16 байт")
  .text.frag_8ed554 0x008ed554 : { KEEP(*(.text.frag_8ed554)) }
  ASSERT(SIZEOF(.text.frag_8ed554) <= 4, "блок frag_8ed554 не влезает в отведённые ему 4 байт")
  .text.ba_setup_sm__on_start 0x008ed558 : { KEEP(*(.text.ba_setup_sm__on_start)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__on_start) <= 32, "блок ba_setup_sm__on_start не влезает в отведённые ему 32 байт")
  .text.l2mgr__init_frame_pool 0x008ed578 : { KEEP(*(.text.l2mgr__init_frame_pool)) }
  ASSERT(SIZEOF(.text.l2mgr__init_frame_pool) <= 64, "блок l2mgr__init_frame_pool не влезает в отведённые ему 64 байт")
  .text.ber_stats__snapshot 0x008ed5b8 : { KEEP(*(.text.ber_stats__snapshot)) }
  ASSERT(SIZEOF(.text.ber_stats__snapshot) <= 20, "блок ber_stats__snapshot не влезает в отведённые ему 20 байт")
  .text.l2mgr__send_vring_en 0x008ed5cc : { KEEP(*(.text.l2mgr__send_vring_en)) }
  ASSERT(SIZEOF(.text.l2mgr__send_vring_en) <= 8, "блок l2mgr__send_vring_en не влезает в отведённые ему 8 байт")
  .text.l2mgr__notify_key_ready 0x008ed5d4 : { KEEP(*(.text.l2mgr__notify_key_ready)) }
  ASSERT(SIZEOF(.text.l2mgr__notify_key_ready) <= 40, "блок l2mgr__notify_key_ready не влезает в отведённые ему 40 байт")
  .text.l2mgr__data_port_open 0x008ed5fc : { KEEP(*(.text.l2mgr__data_port_open)) }
  ASSERT(SIZEOF(.text.l2mgr__data_port_open) <= 320, "блок l2mgr__data_port_open не влезает в отведённые ему 320 байт")
  .text.l2mgr__send_keys_to_ucode 0x008ed73c : { KEEP(*(.text.l2mgr__send_keys_to_ucode)) }
  ASSERT(SIZEOF(.text.l2mgr__send_keys_to_ucode) <= 60, "блок l2mgr__send_keys_to_ucode не влезает в отведённые ему 60 байт")
  .text.l2mgr__install_key 0x008ed778 : { KEEP(*(.text.l2mgr__install_key)) }
  ASSERT(SIZEOF(.text.l2mgr__install_key) <= 164, "блок l2mgr__install_key не влезает в отведённые ему 164 байт")
  .text.frag_8ed81c 0x008ed81c : { KEEP(*(.text.frag_8ed81c)) }
  ASSERT(SIZEOF(.text.frag_8ed81c) <= 4, "блок frag_8ed81c не влезает в отведённые ему 4 байт")
  .text.mid__conn_state_ne_1 0x008ed820 : { KEEP(*(.text.mid__conn_state_ne_1)) }
  ASSERT(SIZEOF(.text.mid__conn_state_ne_1) <= 16, "блок mid__conn_state_ne_1 не влезает в отведённые ему 16 байт")
  .text.ber_test__copy_counters 0x008ed830 : { KEEP(*(.text.ber_test__copy_counters)) }
  ASSERT(SIZEOF(.text.ber_test__copy_counters) <= 12, "блок ber_test__copy_counters не влезает в отведённые ему 12 байт")
  .text.ber_test__accumulate_counters 0x008ed83c : { KEEP(*(.text.ber_test__accumulate_counters)) }
  ASSERT(SIZEOF(.text.ber_test__accumulate_counters) <= 64, "блок ber_test__accumulate_counters не влезает в отведённые ему 64 байт")
  .text.l2mgr__send_ready_evt 0x008ed87c : { KEEP(*(.text.l2mgr__send_ready_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_ready_evt) <= 92, "блок l2mgr__send_ready_evt не влезает в отведённые ему 92 байт")
  .text.WBE_DRIVER__link_down 0x008ed8d8 : { KEEP(*(.text.WBE_DRIVER__link_down)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__link_down) <= 352, "блок WBE_DRIVER__link_down не влезает в отведённые ему 352 байт")
  .text.WBE_DRIVER__link_down_notif 0x008eda38 : { KEEP(*(.text.WBE_DRIVER__link_down_notif)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__link_down_notif) <= 64, "блок WBE_DRIVER__link_down_notif не влезает в отведённые ему 64 байт")
  .text.l2_mgr__link_up_evt 0x008eda78 : { KEEP(*(.text.l2_mgr__link_up_evt)) }
  ASSERT(SIZEOF(.text.l2_mgr__link_up_evt) <= 92, "блок l2_mgr__link_up_evt не влезает в отведённые ему 92 байт")
  .text.WBE_DRIVER__HOST_8edad4 0x008edad4 : { KEEP(*(.text.WBE_DRIVER__HOST_8edad4)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__HOST_8edad4) <= 60, "блок WBE_DRIVER__HOST_8edad4 не влезает в отведённые ему 60 байт")
  .text.stub_ret_8edb10 0x008edb10 : { KEEP(*(.text.stub_ret_8edb10)) }
  ASSERT(SIZEOF(.text.stub_ret_8edb10) <= 4, "блок stub_ret_8edb10 не влезает в отведённые ему 4 байт")
  .text.WBE_DRIVER__link_up_notif 0x008edb14 : { KEEP(*(.text.WBE_DRIVER__link_up_notif)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__link_up_notif) <= 120, "блок WBE_DRIVER__link_up_notif не влезает в отведённые ему 120 байт")
  .text.conn__linkup_ntf 0x008edb8c : { KEEP(*(.text.conn__linkup_ntf)) }
  ASSERT(SIZEOF(.text.conn__linkup_ntf) <= 48, "блок conn__linkup_ntf не влезает в отведённые ему 48 байт")
  .text.find_mngr__enter_listen 0x008edbbc : { KEEP(*(.text.find_mngr__enter_listen)) }
  ASSERT(SIZEOF(.text.find_mngr__enter_listen) <= 96, "блок find_mngr__enter_listen не влезает в отведённые ему 96 байт")
  .text.ps__on_awake_peers 0x008edc1c : { KEEP(*(.text.ps__on_awake_peers)) }
  ASSERT(SIZEOF(.text.ps__on_awake_peers) <= 44, "блок ps__on_awake_peers не влезает в отведённые ему 44 байт")
  .text.l2_mgr__lmac_high_false_alarm_evt_handler 0x008edc48 : { KEEP(*(.text.l2_mgr__lmac_high_false_alarm_evt_handler)) }
  ASSERT(SIZEOF(.text.l2_mgr__lmac_high_false_alarm_evt_handler) <= 76, "блок l2_mgr__lmac_high_false_alarm_evt_handler не влезает в отведённые ему 76 байт")
  .text.lmac_if__ucode_init 0x008edc94 : { KEEP(*(.text.lmac_if__ucode_init)) }
  ASSERT(SIZEOF(.text.lmac_if__ucode_init) <= 116, "блок lmac_if__ucode_init не влезает в отведённые ему 116 байт")
  .text.l2_mgr__lmac_new_link_evt_handler 0x008edd08 : { KEEP(*(.text.l2_mgr__lmac_new_link_evt_handler)) }
  ASSERT(SIZEOF(.text.l2_mgr__lmac_new_link_evt_handler) <= 340, "блок l2_mgr__lmac_new_link_evt_handler не влезает в отведённые ему 340 байт")
  .text.lmac_if__lmac_ready_evt 0x008ede5c : { KEEP(*(.text.lmac_if__lmac_ready_evt)) }
  ASSERT(SIZEOF(.text.lmac_if__lmac_ready_evt) <= 188, "блок lmac_if__lmac_ready_evt не влезает в отведённые ему 188 байт")
  .text.lms_stopped 0x008edf18 : { KEEP(*(.text.lms_stopped)) }
  ASSERT(SIZEOF(.text.lms_stopped) <= 64, "блок lms_stopped не влезает в отведённые ему 64 байт")
  .text.fw_log__init_buffer 0x008edf58 : { KEEP(*(.text.fw_log__init_buffer)) }
  ASSERT(SIZEOF(.text.fw_log__init_buffer) <= 88, "блок fw_log__init_buffer не влезает в отведённые ему 88 байт")
  .text.fw_log__emit0 0x008edfb0 : { KEEP(*(.text.fw_log__emit0)) }
  ASSERT(SIZEOF(.text.fw_log__emit0) <= 28, "блок fw_log__emit0 не влезает в отведённые ему 28 байт")
  .text.fw_log__emit1 0x008edfcc : { KEEP(*(.text.fw_log__emit1)) }
  ASSERT(SIZEOF(.text.fw_log__emit1) <= 44, "блок fw_log__emit1 не влезает в отведённые ему 44 байт")
  .text.fw_log__emit2 0x008edff8 : { KEEP(*(.text.fw_log__emit2)) }
  ASSERT(SIZEOF(.text.fw_log__emit2) <= 60, "блок fw_log__emit2 не влезает в отведённые ему 60 байт")
  .text.fw_log__emit3 0x008ee034 : { KEEP(*(.text.fw_log__emit3)) }
  ASSERT(SIZEOF(.text.fw_log__emit3) <= 76, "блок fw_log__emit3 не влезает в отведённые ему 76 байт")
  .text.fw_log__emit1_nonl 0x008ee080 : { KEEP(*(.text.fw_log__emit1_nonl)) }
  ASSERT(SIZEOF(.text.fw_log__emit1_nonl) <= 44, "блок fw_log__emit1_nonl не влезает в отведённые ему 44 байт")
  .text.fw_log__emit2_nonl 0x008ee0ac : { KEEP(*(.text.fw_log__emit2_nonl)) }
  ASSERT(SIZEOF(.text.fw_log__emit2_nonl) <= 60, "блок fw_log__emit2_nonl не влезает в отведённые ему 60 байт")
  .text.fw_log__emit3_nonl 0x008ee0e8 : { KEEP(*(.text.fw_log__emit3_nonl)) }
  ASSERT(SIZEOF(.text.fw_log__emit3_nonl) <= 76, "блок fw_log__emit3_nonl не влезает в отведённые ему 76 байт")
  .text.fw_log__commit 0x008ee134 : { KEEP(*(.text.fw_log__commit)) }
  ASSERT(SIZEOF(.text.fw_log__commit) <= 56, "блок fw_log__commit не влезает в отведённые ему 56 байт")
  .text.boot_fill_addr_tables 0x008ee16c : { KEEP(*(.text.boot_fill_addr_tables)) }
  ASSERT(SIZEOF(.text.boot_fill_addr_tables) <= 1376, "блок boot_fill_addr_tables не влезает в отведённые ему 1376 байт")
  .text.l2mgr__mac_bringup 0x008ee6cc : { KEEP(*(.text.l2mgr__mac_bringup)) }
  ASSERT(SIZEOF(.text.l2mgr__mac_bringup) <= 84, "блок l2mgr__mac_bringup не влезает в отведённые ему 84 байт")
  .text.mac_bringup__program_886800 0x008ee720 : { KEEP(*(.text.mac_bringup__program_886800)) }
  ASSERT(SIZEOF(.text.mac_bringup__program_886800) <= 64, "блок mac_bringup__program_886800 не влезает в отведённые ему 64 байт")
  .text.tail_L2MGR__system_state_evt_handler 0x008ee760 : { KEEP(*(.text.tail_L2MGR__system_state_evt_handler)) }
  ASSERT(SIZEOF(.text.tail_L2MGR__system_state_evt_handler) <= 8, "блок tail_L2MGR__system_state_evt_handler не влезает в отведённые ему 8 байт")
  .text.set_reg_88269c 0x008ee768 : { KEEP(*(.text.set_reg_88269c)) }
  ASSERT(SIZEOF(.text.set_reg_88269c) <= 16, "блок set_reg_88269c не влезает в отведённые ему 16 байт")
  .text.set_reg_882680 0x008ee778 : { KEEP(*(.text.set_reg_882680)) }
  ASSERT(SIZEOF(.text.set_reg_882680) <= 16, "блок set_reg_882680 не влезает в отведённые ему 16 байт")
  .text.set_reg_882680_8ee788 0x008ee788 : { KEEP(*(.text.set_reg_882680_8ee788)) }
  ASSERT(SIZEOF(.text.set_reg_882680_8ee788) <= 28, "блок set_reg_882680_8ee788 не влезает в отведённые ему 28 байт")
  .text.set_reg_88269c_8ee7a4 0x008ee7a4 : { KEEP(*(.text.set_reg_88269c_8ee7a4)) }
  ASSERT(SIZEOF(.text.set_reg_88269c_8ee7a4) <= 16, "блок set_reg_88269c_8ee7a4 не влезает в отведённые ему 16 байт")
  .text.set_reg_88269c_8ee7b4 0x008ee7b4 : { KEEP(*(.text.set_reg_88269c_8ee7b4)) }
  ASSERT(SIZEOF(.text.set_reg_88269c_8ee7b4) <= 12, "блок set_reg_88269c_8ee7b4 не влезает в отведённые ему 12 байт")
  .text.set_reg_88269c_8ee7c0 0x008ee7c0 : { KEEP(*(.text.set_reg_88269c_8ee7c0)) }
  ASSERT(SIZEOF(.text.set_reg_88269c_8ee7c0) <= 12, "блок set_reg_88269c_8ee7c0 не влезает в отведённые ему 12 байт")
  .text.mlme_sm__disconnect_log 0x008ee7cc : { KEEP(*(.text.mlme_sm__disconnect_log)) }
  ASSERT(SIZEOF(.text.mlme_sm__disconnect_log) <= 48, "блок mlme_sm__disconnect_log не влезает в отведённые ему 48 байт")
  .text.mlme_sm__send_disassoc 0x008ee7fc : { KEEP(*(.text.mlme_sm__send_disassoc)) }
  ASSERT(SIZEOF(.text.mlme_sm__send_disassoc) <= 148, "блок mlme_sm__send_disassoc не влезает в отведённые ему 148 байт")
  .text.rgf_reg_886a80 0x008ee890 : { KEEP(*(.text.rgf_reg_886a80)) }
  ASSERT(SIZEOF(.text.rgf_reg_886a80) <= 12, "блок rgf_reg_886a80 не влезает в отведённые ему 12 байт")
  .text.tail_low_sme__termination_check 0x008ee89c : { KEEP(*(.text.tail_low_sme__termination_check)) }
  ASSERT(SIZEOF(.text.tail_low_sme__termination_check) <= 12, "блок tail_low_sme__termination_check не влезает в отведённые ему 12 байт")
  .text.mac_bringup__prog_881b00 0x008ee8a8 : { KEEP(*(.text.mac_bringup__prog_881b00)) }
  ASSERT(SIZEOF(.text.mac_bringup__prog_881b00) <= 100, "блок mac_bringup__prog_881b00 не влезает в отведённые ему 100 байт")
  .text.otp__log_params 0x008ee90c : { KEEP(*(.text.otp__log_params)) }
  ASSERT(SIZEOF(.text.otp__log_params) <= 92, "блок otp__log_params не влезает в отведённые ему 92 байт")
  .text.otp__read_counters 0x008ee968 : { KEEP(*(.text.otp__read_counters)) }
  ASSERT(SIZEOF(.text.otp__read_counters) <= 44, "блок otp__read_counters не влезает в отведённые ему 44 байт")
  .text.p2p_cfg 0x008ee994 : { KEEP(*(.text.p2p_cfg)) }
  ASSERT(SIZEOF(.text.p2p_cfg) <= 56, "блок p2p_cfg не влезает в отведённые ему 56 байт")
  .text.mac_parser__configure 0x008ee9cc : { KEEP(*(.text.mac_parser__configure)) }
  ASSERT(SIZEOF(.text.mac_parser__configure) <= 84, "блок mac_parser__configure не влезает в отведённые ему 84 байт")
  .text.frag_8eea20 0x008eea20 : { KEEP(*(.text.frag_8eea20)) }
  ASSERT(SIZEOF(.text.frag_8eea20) <= 4, "блок frag_8eea20 не влезает в отведённые ему 4 байт")
  .text.maintain_sm__on_pause 0x008eea24 : { KEEP(*(.text.maintain_sm__on_pause)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_pause) <= 68, "блок maintain_sm__on_pause не влезает в отведённые ему 68 байт")
  .text.l2mgr__send_pbss_joined_evt 0x008eea68 : { KEEP(*(.text.l2mgr__send_pbss_joined_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_pbss_joined_evt) <= 88, "блок l2mgr__send_pbss_joined_evt не влезает в отведённые ему 88 байт")
  .text.pcie__serdes_init 0x008eeac0 : { KEEP(*(.text.pcie__serdes_init)) }
  ASSERT(SIZEOF(.text.pcie__serdes_init) <= 380, "блок pcie__serdes_init не влезает в отведённые ему 380 байт")
  .text.pcie__ack_882644 0x008eec3c : { KEEP(*(.text.pcie__ack_882644)) }
  ASSERT(SIZEOF(.text.pcie__ack_882644) <= 28, "блок pcie__ack_882644 не влезает в отведённые ему 28 байт")
  .text.pcie__serdes_cfg 0x008eec58 : { KEEP(*(.text.pcie__serdes_cfg)) }
  ASSERT(SIZEOF(.text.pcie__serdes_cfg) <= 112, "блок pcie__serdes_cfg не влезает в отведённые ему 112 байт")
  .text.dbi_write_seq 0x008eecc8 : { KEEP(*(.text.dbi_write_seq)) }
  ASSERT(SIZEOF(.text.dbi_write_seq) <= 368, "блок dbi_write_seq не влезает в отведённые ему 368 байт")
  .text.pcp_bcon_wb 0x008eee38 : { KEEP(*(.text.pcp_bcon_wb)) }
  ASSERT(SIZEOF(.text.pcp_bcon_wb) <= 44, "блок pcp_bcon_wb не влезает в отведённые ему 44 байт")
  .text.pcp_restart 0x008eee64 : { KEEP(*(.text.pcp_restart)) }
  ASSERT(SIZEOF(.text.pcp_restart) <= 92, "блок pcp_restart не влезает в отведённые ему 92 байт")
  .text.l2_mgr__pcp_start 0x008eeec0 : { KEEP(*(.text.l2_mgr__pcp_start)) }
  ASSERT(SIZEOF(.text.l2_mgr__pcp_start) <= 88, "блок l2_mgr__pcp_start не влезает в отведённые ему 88 байт")
  .text.pcp_start 0x008eef18 : { KEEP(*(.text.pcp_start)) }
  ASSERT(SIZEOF(.text.pcp_start) <= 88, "блок pcp_start не влезает в отведённые ему 88 байт")
  .text.l2_mgr__pcp_stop 0x008eef70 : { KEEP(*(.text.l2_mgr__pcp_stop)) }
  ASSERT(SIZEOF(.text.l2_mgr__pcp_stop) <= 164, "блок l2_mgr__pcp_stop не влезает в отведённые ему 164 байт")
  .text.scan_mngr__prob_done 0x008ef034 : { KEEP(*(.text.scan_mngr__prob_done)) }
  ASSERT(SIZEOF(.text.scan_mngr__prob_done) <= 400, "блок scan_mngr__prob_done не влезает в отведённые ему 400 байт")
  .text.scan_mngr__prob_resp_timeout_cb 0x008ef1c4 : { KEEP(*(.text.scan_mngr__prob_resp_timeout_cb)) }
  ASSERT(SIZEOF(.text.scan_mngr__prob_resp_timeout_cb) <= 128, "блок scan_mngr__prob_resp_timeout_cb не влезает в отведённые ему 128 байт")
  .text.find_main_sm__probe_req 0x008ef244 : { KEEP(*(.text.find_main_sm__probe_req)) }
  ASSERT(SIZEOF(.text.find_main_sm__probe_req) <= 520, "блок find_main_sm__probe_req не влезает в отведённые ему 520 байт")
  .text.find_main_sm__probe_req_in_search 0x008ef44c : { KEEP(*(.text.find_main_sm__probe_req_in_search)) }
  ASSERT(SIZEOF(.text.find_main_sm__probe_req_in_search) <= 520, "блок find_main_sm__probe_req_in_search не влезает в отведённые ему 520 байт")
  .text.probe_req_tx_wb_cb 0x008ef654 : { KEEP(*(.text.probe_req_tx_wb_cb)) }
  ASSERT(SIZEOF(.text.probe_req_tx_wb_cb) <= 60, "блок probe_req_tx_wb_cb не влезает в отведённые ему 60 байт")
  .text.frag_8ef690 0x008ef690 : { KEEP(*(.text.frag_8ef690)) }
  ASSERT(SIZEOF(.text.frag_8ef690) <= 4, "блок frag_8ef690 не влезает в отведённые ему 4 байт")
  .text.scan_mngr__probe_resp_ind 0x008ef694 : { KEEP(*(.text.scan_mngr__probe_resp_ind)) }
  ASSERT(SIZEOF(.text.scan_mngr__probe_resp_ind) <= 108, "блок scan_mngr__probe_resp_ind не влезает в отведённые ему 108 байт")
  .text.probe_resp_tx_wb_cb 0x008ef700 : { KEEP(*(.text.probe_resp_tx_wb_cb)) }
  ASSERT(SIZEOF(.text.probe_resp_tx_wb_cb) <= 64, "блок probe_resp_tx_wb_cb не влезает в отведённые ему 64 байт")
  .text.ie__push_wfa_vendor 0x008ef740 : { KEEP(*(.text.ie__push_wfa_vendor)) }
  ASSERT(SIZEOF(.text.ie__push_wfa_vendor) <= 68, "блок ie__push_wfa_vendor не влезает в отведённые ему 68 байт")
  .text.push_cap_info 0x008ef784 : { KEEP(*(.text.push_cap_info)) }
  ASSERT(SIZEOF(.text.push_cap_info) <= 52, "блок push_cap_info не влезает в отведённые ему 52 байт")
  .text.ie__push_edca 0x008ef7b8 : { KEEP(*(.text.ie__push_edca)) }
  ASSERT(SIZEOF(.text.ie__push_edca) <= 32, "блок ie__push_edca не влезает в отведённые ему 32 байт")
  .text.tx_budget__take 0x008ef7d8 : { KEEP(*(.text.tx_budget__take)) }
  ASSERT(SIZEOF(.text.tx_budget__take) <= 44, "блок tx_budget__take не влезает в отведённые ему 44 байт")
  .text.ie__push_qos_capability 0x008ef804 : { KEEP(*(.text.ie__push_qos_capability)) }
  ASSERT(SIZEOF(.text.ie__push_qos_capability) <= 40, "блок ie__push_qos_capability не влезает в отведённые ему 40 байт")
  .text.ie__push_awake_window 0x008ef82c : { KEEP(*(.text.ie__push_awake_window)) }
  ASSERT(SIZEOF(.text.ie__push_awake_window) <= 32, "блок ie__push_awake_window не влезает в отведённые ему 32 байт")
  .text.ie__push_eid190_len4 0x008ef84c : { KEEP(*(.text.ie__push_eid190_len4)) }
  ASSERT(SIZEOF(.text.ie__push_eid190_len4) <= 24, "блок ie__push_eid190_len4 не влезает в отведённые ему 24 байт")
  .text.ie__push_eid151_len10 0x008ef864 : { KEEP(*(.text.ie__push_eid151_len10)) }
  ASSERT(SIZEOF(.text.ie__push_eid151_len10) <= 24, "блок ie__push_eid151_len10 не влезает в отведённые ему 24 байт")
  .text.ie__push_dmg_capabilities 0x008ef87c : { KEEP(*(.text.ie__push_dmg_capabilities)) }
  ASSERT(SIZEOF(.text.ie__push_dmg_capabilities) <= 28, "блок ie__push_dmg_capabilities не влезает в отведённые ему 28 байт")
  .text.ie__push_raw 0x008ef898 : { KEEP(*(.text.ie__push_raw)) }
  ASSERT(SIZEOF(.text.ie__push_raw) <= 68, "блок ie__push_raw не влезает в отведённые ему 68 байт")
  .text.ie__push_ssid 0x008ef8dc : { KEEP(*(.text.ie__push_ssid)) }
  ASSERT(SIZEOF(.text.ie__push_ssid) <= 32, "блок ie__push_ssid не влезает в отведённые ему 32 байт")
  .text.tail_WBE_DRIVER__pxe_isoc_in_dir_bypass 0x008ef8fc : { KEEP(*(.text.tail_WBE_DRIVER__pxe_isoc_in_dir_bypass)) }
  ASSERT(SIZEOF(.text.tail_WBE_DRIVER__pxe_isoc_in_dir_bypass) <= 8, "блок tail_WBE_DRIVER__pxe_isoc_in_dir_bypass не влезает в отведённые ему 8 байт")
  .text.tail_WBE_DRIVER__pxe_isoc_in_dir_bypass_8ef904 0x008ef904 : { KEEP(*(.text.tail_WBE_DRIVER__pxe_isoc_in_dir_bypass_8ef904)) }
  ASSERT(SIZEOF(.text.tail_WBE_DRIVER__pxe_isoc_in_dir_bypass_8ef904) <= 8, "блок tail_WBE_DRIVER__pxe_isoc_in_dir_bypass_8ef904 не влезает в отведённые ему 8 байт")
  .text.wbe_driver__pcie_debug 0x008ef90c : { KEEP(*(.text.wbe_driver__pcie_debug)) }
  ASSERT(SIZEOF(.text.wbe_driver__pcie_debug) <= 368, "блок wbe_driver__pcie_debug не влезает в отведённые ему 368 байт")
  .text.wbe_driver__pcie_debug_isr 0x008efa7c : { KEEP(*(.text.wbe_driver__pcie_debug_isr)) }
  ASSERT(SIZEOF(.text.wbe_driver__pcie_debug_isr) <= 108, "блок wbe_driver__pcie_debug_isr не влезает в отведённые ему 108 байт")
  .text.WBE_DRIVER__pxe_isoc_in_dir_bypass 0x008efae8 : { KEEP(*(.text.WBE_DRIVER__pxe_isoc_in_dir_bypass)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__pxe_isoc_in_dir_bypass) <= 168, "блок WBE_DRIVER__pxe_isoc_in_dir_bypass не влезает в отведённые ему 168 байт")
  .text.lmac_if_send_cmd_0x07 0x008efb90 : { KEEP(*(.text.lmac_if_send_cmd_0x07)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x07) <= 96, "блок lmac_if_send_cmd_0x07 не влезает в отведённые ему 96 байт")
  .text.channels_switch__tune_current 0x008efbf0 : { KEEP(*(.text.channels_switch__tune_current)) }
  ASSERT(SIZEOF(.text.channels_switch__tune_current) <= 28, "блок channels_switch__tune_current не влезает в отведённые ему 28 байт")
  .text.channels_switch_sm__radio_allocated_cb 0x008efc0c : { KEEP(*(.text.channels_switch_sm__radio_allocated_cb)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__radio_allocated_cb) <= 40, "блок channels_switch_sm__radio_allocated_cb не влезает в отведённые ему 40 байт")
  .text.ba_setup_sm__abort 0x008efc34 : { KEEP(*(.text.ba_setup_sm__abort)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__abort) <= 32, "блок ba_setup_sm__abort не влезает в отведённые ему 32 байт")
  .text.frag_8efc54 0x008efc54 : { KEEP(*(.text.frag_8efc54)) }
  ASSERT(SIZEOF(.text.frag_8efc54) <= 4, "блок frag_8efc54 не влезает в отведённые ему 4 байт")
  .text.rf_kill_sm__on_w_disable__disabled 0x008efc58 : { KEEP(*(.text.rf_kill_sm__on_w_disable__disabled)) }
  ASSERT(SIZEOF(.text.rf_kill_sm__on_w_disable__disabled) <= 16, "блок rf_kill_sm__on_w_disable__disabled не влезает в отведённые ему 16 байт")
  .text.rf_kill_sm__on_w_enable__enabled 0x008efc68 : { KEEP(*(.text.rf_kill_sm__on_w_enable__enabled)) }
  ASSERT(SIZEOF(.text.rf_kill_sm__on_w_enable__enabled) <= 16, "блок rf_kill_sm__on_w_enable__enabled не влезает в отведённые ему 16 байт")
  .text.maintain_sm__on_resume_maintain 0x008efc78 : { KEEP(*(.text.maintain_sm__on_resume_maintain)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_resume_maintain) <= 72, "блок maintain_sm__on_resume_maintain не влезает в отведённые ему 72 байт")
  .text.scan_mngr__resume_scan 0x008efcc0 : { KEEP(*(.text.scan_mngr__resume_scan)) }
  ASSERT(SIZEOF(.text.scan_mngr__resume_scan) <= 44, "блок scan_mngr__resume_scan не влезает в отведённые ему 44 байт")
  .text.hwf_rf_check_rf_id 0x008efcec : { KEEP(*(.text.hwf_rf_check_rf_id)) }
  ASSERT(SIZEOF(.text.hwf_rf_check_rf_id) <= 100, "блок hwf_rf_check_rf_id не влезает в отведённые ему 100 байт")
  .text.rgf_reg_882600 0x008efd50 : { KEEP(*(.text.rgf_reg_882600)) }
  ASSERT(SIZEOF(.text.rgf_reg_882600) <= 36, "блок rgf_reg_882600 не влезает в отведённые ему 36 байт")
  .text.discovery__rx_start 0x008efd74 : { KEEP(*(.text.discovery__rx_start)) }
  ASSERT(SIZEOF(.text.discovery__rx_start) <= 56, "блок discovery__rx_start не влезает в отведённые ему 56 байт")
  .text.discovery__rx_stop 0x008efdac : { KEEP(*(.text.discovery__rx_stop)) }
  ASSERT(SIZEOF(.text.discovery__rx_stop) <= 48, "блок discovery__rx_stop не влезает в отведённые ему 48 байт")
  .text.rgf_reg_886800 0x008efddc : { KEEP(*(.text.rgf_reg_886800)) }
  ASSERT(SIZEOF(.text.rgf_reg_886800) <= 52, "блок rgf_reg_886800 не влезает в отведённые ему 52 байт")
  .text.mac_bringup__init_rx_desc 0x008efe10 : { KEEP(*(.text.mac_bringup__init_rx_desc)) }
  ASSERT(SIZEOF(.text.mac_bringup__init_rx_desc) <= 64, "блок mac_bringup__init_rx_desc не влезает в отведённые ему 64 байт")
  .text.bootloader_version__log 0x008efe50 : { KEEP(*(.text.bootloader_version__log)) }
  ASSERT(SIZEOF(.text.bootloader_version__log) <= 72, "блок bootloader_version__log не влезает в отведённые ему 72 байт")
  .text.scan_mngr__save_initial_passive_scan_info 0x008efe98 : { KEEP(*(.text.scan_mngr__save_initial_passive_scan_info)) }
  ASSERT(SIZEOF(.text.scan_mngr__save_initial_passive_scan_info) <= 64, "блок scan_mngr__save_initial_passive_scan_info не влезает в отведённые ему 64 байт")
  .text.l2_mgr__scan_abort 0x008efed8 : { KEEP(*(.text.l2_mgr__scan_abort)) }
  ASSERT(SIZEOF(.text.l2_mgr__scan_abort) <= 124, "блок l2_mgr__scan_abort не влезает в отведённые ему 124 байт")
  .text.scan_abort 0x008eff54 : { KEEP(*(.text.scan_abort)) }
  ASSERT(SIZEOF(.text.scan_abort) <= 40, "блок scan_abort не влезает в отведённые ему 40 байт")
  .text.l2_mgr__scan_complete_handle 0x008eff7c : { KEEP(*(.text.l2_mgr__scan_complete_handle)) }
  ASSERT(SIZEOF(.text.l2_mgr__scan_complete_handle) <= 132, "блок l2_mgr__scan_complete_handle не влезает в отведённые ему 132 байт")
  .text.scan_mngr__scan_done 0x008f0000 : { KEEP(*(.text.scan_mngr__scan_done)) }
  ASSERT(SIZEOF(.text.scan_mngr__scan_done) <= 212, "блок scan_mngr__scan_done не влезает в отведённые ему 212 байт")
  .text.scan_resume 0x008f00d4 : { KEEP(*(.text.scan_resume)) }
  ASSERT(SIZEOF(.text.scan_resume) <= 52, "блок scan_resume не влезает в отведённые ему 52 байт")
  .text.channels_switch_sm__scan_rm_lock_timeout_cb 0x008f0108 : { KEEP(*(.text.channels_switch_sm__scan_rm_lock_timeout_cb)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__scan_rm_lock_timeout_cb) <= 44, "блок channels_switch_sm__scan_rm_lock_timeout_cb не влезает в отведённые ему 44 байт")
  .text.l2_mgr__scan_start_log 0x008f0134 : { KEEP(*(.text.l2_mgr__scan_start_log)) }
  ASSERT(SIZEOF(.text.l2_mgr__scan_start_log) <= 48, "блок l2_mgr__scan_start_log не влезает в отведённые ему 48 байт")
  .text.scan_stop 0x008f0164 : { KEEP(*(.text.scan_stop)) }
  ASSERT(SIZEOF(.text.scan_stop) <= 28, "блок scan_stop не влезает в отведённые ему 28 байт")
  .text.channels_switch_sm__scan_wd_timeout_cb 0x008f0180 : { KEEP(*(.text.channels_switch_sm__scan_wd_timeout_cb)) }
  ASSERT(SIZEOF(.text.channels_switch_sm__scan_wd_timeout_cb) <= 44, "блок channels_switch_sm__scan_wd_timeout_cb не влезает в отведённые ему 44 байт")
  .text.find_mngr__enter_search 0x008f01ac : { KEEP(*(.text.find_mngr__enter_search)) }
  ASSERT(SIZEOF(.text.find_mngr__enter_search) <= 96, "блок find_mngr__enter_search не влезает в отведённые ему 96 байт")
  .text.search_scan_elem_in_list 0x008f020c : { KEEP(*(.text.search_scan_elem_in_list)) }
  ASSERT(SIZEOF(.text.search_scan_elem_in_list) <= 120, "блок search_scan_elem_in_list не влезает в отведённые ему 120 байт")
  .text.l2_mgr__connect_setup 0x008f0284 : { KEEP(*(.text.l2_mgr__connect_setup)) }
  ASSERT(SIZEOF(.text.l2_mgr__connect_setup) <= 80, "блок l2_mgr__connect_setup не влезает в отведённые ему 80 байт")
  .text.bcon_ctrl__prepare_mid 0x008f02d4 : { KEEP(*(.text.bcon_ctrl__prepare_mid)) }
  ASSERT(SIZEOF(.text.bcon_ctrl__prepare_mid) <= 72, "блок bcon_ctrl__prepare_mid не влезает в отведённые ему 72 байт")
  .text.ba_setup_sm__on_tx_permitted 0x008f031c : { KEEP(*(.text.ba_setup_sm__on_tx_permitted)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__on_tx_permitted) <= 32, "блок ba_setup_sm__on_tx_permitted не влезает в отведённые ему 32 байт")
  .text.l2mgr__send_p2p_cfg_done 0x008f033c : { KEEP(*(.text.l2mgr__send_p2p_cfg_done)) }
  ASSERT(SIZEOF(.text.l2mgr__send_p2p_cfg_done) <= 68, "блок l2mgr__send_p2p_cfg_done не влезает в отведённые ему 68 байт")
  .text.l2mgr__send_host_event 0x008f0380 : { KEEP(*(.text.l2mgr__send_host_event)) }
  ASSERT(SIZEOF(.text.l2mgr__send_host_event) <= 304, "блок l2mgr__send_host_event не влезает в отведённые ему 304 байт")
  .text.l2mgr__send_data_port_open_evt 0x008f04b0 : { KEEP(*(.text.l2mgr__send_data_port_open_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_data_port_open_evt) <= 108, "блок l2mgr__send_data_port_open_evt не влезает в отведённые ему 108 байт")
  .text.l2mgr__send_disconnect_evt 0x008f051c : { KEEP(*(.text.l2mgr__send_disconnect_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_disconnect_evt) <= 132, "блок l2mgr__send_disconnect_evt не влезает в отведённые ему 132 байт")
  .text.l2mgr__send_discovery_started 0x008f05a0 : { KEEP(*(.text.l2mgr__send_discovery_started)) }
  ASSERT(SIZEOF(.text.l2mgr__send_discovery_started) <= 48, "блок l2mgr__send_discovery_started не влезает в отведённые ему 48 байт")
  .text.l2mgr__send_discovery_stopped 0x008f05d0 : { KEEP(*(.text.l2mgr__send_discovery_stopped)) }
  ASSERT(SIZEOF(.text.l2mgr__send_discovery_stopped) <= 64, "блок l2mgr__send_discovery_stopped не влезает в отведённые ему 64 байт")
  .text.l2mgr__send_listen_started 0x008f0610 : { KEEP(*(.text.l2mgr__send_listen_started)) }
  ASSERT(SIZEOF(.text.l2mgr__send_listen_started) <= 68, "блок l2mgr__send_listen_started не влезает в отведённые ему 68 байт")
  .text.l2mgr__send_scan_complete_evt 0x008f0654 : { KEEP(*(.text.l2mgr__send_scan_complete_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_scan_complete_evt) <= 204, "блок l2mgr__send_scan_complete_evt не влезает в отведённые ему 204 байт")
  .text.l2mgr__send_pbss_leave_evt 0x008f0720 : { KEEP(*(.text.l2mgr__send_pbss_leave_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_pbss_leave_evt) <= 80, "блок l2mgr__send_pbss_leave_evt не влезает в отведённые ему 80 байт")
  .text.l2_mgr__send_pcp_start_status_evt 0x008f0770 : { KEEP(*(.text.l2_mgr__send_pcp_start_status_evt)) }
  ASSERT(SIZEOF(.text.l2_mgr__send_pcp_start_status_evt) <= 132, "блок l2_mgr__send_pcp_start_status_evt не влезает в отведённые ему 132 байт")
  .text.l2mgr__send_pcp_stopped 0x008f07f4 : { KEEP(*(.text.l2mgr__send_pcp_stopped)) }
  ASSERT(SIZEOF(.text.l2mgr__send_pcp_stopped) <= 56, "блок l2mgr__send_pcp_stopped не влезает в отведённые ему 56 байт")
  .text.scan_mngr__send_prob_req 0x008f082c : { KEEP(*(.text.scan_mngr__send_prob_req)) }
  ASSERT(SIZEOF(.text.scan_mngr__send_prob_req) <= 220, "блок scan_mngr__send_prob_req не влезает в отведённые ему 220 байт")
  .text.tx_probe__send_probe_resp 0x008f0908 : { KEEP(*(.text.tx_probe__send_probe_resp)) }
  ASSERT(SIZEOF(.text.tx_probe__send_probe_resp) <= 120, "блок tx_probe__send_probe_resp не влезает в отведённые ему 120 байт")
  .text.tx_probe__send_scan_complete 0x008f0980 : { KEEP(*(.text.tx_probe__send_scan_complete)) }
  ASSERT(SIZEOF(.text.tx_probe__send_scan_complete) <= 68, "блок tx_probe__send_scan_complete не влезает в отведённые ему 68 байт")
  .text.tx_probe__send_probe_req 0x008f09c4 : { KEEP(*(.text.tx_probe__send_probe_req)) }
  ASSERT(SIZEOF(.text.tx_probe__send_probe_req) <= 136, "блок tx_probe__send_probe_req не влезает в отведённые ему 136 байт")
  .text.l2mgr__send_search_started 0x008f0a4c : { KEEP(*(.text.l2mgr__send_search_started)) }
  ASSERT(SIZEOF(.text.l2mgr__send_search_started) <= 72, "блок l2mgr__send_search_started не влезает в отведённые ему 72 байт")
  .text.send_sw_packet 0x008f0a94 : { KEEP(*(.text.send_sw_packet)) }
  ASSERT(SIZEOF(.text.send_sw_packet) <= 176, "блок send_sw_packet не влезает в отведённые ему 176 байт")
  .text.l2mgr__send_sw_tx_complete 0x008f0b44 : { KEEP(*(.text.l2mgr__send_sw_tx_complete)) }
  ASSERT(SIZEOF(.text.l2mgr__send_sw_tx_complete) <= 72, "блок l2mgr__send_sw_tx_complete не влезает в отведённые ему 72 байт")
  .text.l2mgr__send_vring_cfg_done 0x008f0b8c : { KEEP(*(.text.l2mgr__send_vring_cfg_done)) }
  ASSERT(SIZEOF(.text.l2mgr__send_vring_cfg_done) <= 72, "блок l2mgr__send_vring_cfg_done не влезает в отведённые ему 72 байт")
  .text.l2mgr__send_vring_en_evt 0x008f0bd4 : { KEEP(*(.text.l2mgr__send_vring_en_evt)) }
  ASSERT(SIZEOF(.text.l2mgr__send_vring_en_evt) <= 68, "блок l2mgr__send_vring_en_evt не влезает в отведённые ему 68 байт")
  .text.ring__reset_counters 0x008f0c18 : { KEEP(*(.text.ring__reset_counters)) }
  ASSERT(SIZEOF(.text.ring__reset_counters) <= 24, "блок ring__reset_counters не влезает в отведённые ему 24 байт")
  .text.pcie__set_l1_bit11 0x008f0c30 : { KEEP(*(.text.pcie__set_l1_bit11)) }
  ASSERT(SIZEOF(.text.pcie__set_l1_bit11) <= 16, "блок pcie__set_l1_bit11 не влезает в отведённые ему 16 байт")
  .text.calib_lo_leakage__prepare_ctx 0x008f0c40 : { KEEP(*(.text.calib_lo_leakage__prepare_ctx)) }
  ASSERT(SIZEOF(.text.calib_lo_leakage__prepare_ctx) <= 140, "блок calib_lo_leakage__prepare_ctx не влезает в отведённые ему 140 байт")
  .text.fw_boot__log_versions 0x008f0ccc : { KEEP(*(.text.fw_boot__log_versions)) }
  ASSERT(SIZEOF(.text.fw_boot__log_versions) <= 60, "блок fw_boot__log_versions не влезает в отведённые ему 60 байт")
  .text.ps__post_shallow_sleep_state 0x008f0d08 : { KEEP(*(.text.ps__post_shallow_sleep_state)) }
  ASSERT(SIZEOF(.text.ps__post_shallow_sleep_state) <= 16, "блок ps__post_shallow_sleep_state не влезает в отведённые ему 16 байт")
  .text.scan_mngr__sm_dwelling_ended 0x008f0d18 : { KEEP(*(.text.scan_mngr__sm_dwelling_ended)) }
  ASSERT(SIZEOF(.text.scan_mngr__sm_dwelling_ended) <= 132, "блок scan_mngr__sm_dwelling_ended не влезает в отведённые ему 132 байт")
  .text.scan_mngr__sm_ready_for_dwelling 0x008f0d9c : { KEEP(*(.text.scan_mngr__sm_ready_for_dwelling)) }
  ASSERT(SIZEOF(.text.scan_mngr__sm_ready_for_dwelling) <= 104, "блок scan_mngr__sm_ready_for_dwelling не влезает в отведённые ему 104 байт")
  .text.sort_scan_ch_list 0x008f0e04 : { KEEP(*(.text.sort_scan_ch_list)) }
  ASSERT(SIZEOF(.text.sort_scan_ch_list) <= 144, "блок sort_scan_ch_list не влезает в отведённые ему 144 байт")
  .text.hwd_spi__poll_done 0x008f0e94 : { KEEP(*(.text.hwd_spi__poll_done)) }
  ASSERT(SIZEOF(.text.hwd_spi__poll_done) <= 76, "блок hwd_spi__poll_done не влезает в отведённые ему 76 байт")
  .text.hwd_spi_read 0x008f0ee0 : { KEEP(*(.text.hwd_spi_read)) }
  ASSERT(SIZEOF(.text.hwd_spi_read) <= 376, "блок hwd_spi_read не влезает в отведённые ему 376 байт")
  .text.set_reg_8801a8_x2 0x008f1058 : { KEEP(*(.text.set_reg_8801a8_x2)) }
  ASSERT(SIZEOF(.text.set_reg_8801a8_x2) <= 28, "блок set_reg_8801a8_x2 не влезает в отведённые ему 28 байт")
  .text.lmac_if_send_cmd_0x05_8f1074 0x008f1074 : { KEEP(*(.text.lmac_if_send_cmd_0x05_8f1074)) }
  ASSERT(SIZEOF(.text.lmac_if_send_cmd_0x05_8f1074) <= 100, "блок lmac_if_send_cmd_0x05_8f1074 не влезает в отведённые ему 100 байт")
  .text.conn__teardown_mac_rules 0x008f10d8 : { KEEP(*(.text.conn__teardown_mac_rules)) }
  ASSERT(SIZEOF(.text.conn__teardown_mac_rules) <= 44, "блок conn__teardown_mac_rules не влезает в отведённые ему 44 байт")
  .text.mbox__build_rings_and_pool 0x008f1104 : { KEEP(*(.text.mbox__build_rings_and_pool)) }
  ASSERT(SIZEOF(.text.mbox__build_rings_and_pool) <= 176, "блок mbox__build_rings_and_pool не влезает в отведённые ему 176 байт")
  .text.lmac_if__build_cmd_rings 0x008f11b4 : { KEEP(*(.text.lmac_if__build_cmd_rings)) }
  ASSERT(SIZEOF(.text.lmac_if__build_cmd_rings) <= 204, "блок lmac_if__build_cmd_rings не влезает в отведённые ему 204 байт")
  .text.scan_mngr__start_connection_cb 0x008f1280 : { KEEP(*(.text.scan_mngr__start_connection_cb)) }
  ASSERT(SIZEOF(.text.scan_mngr__start_connection_cb) <= 72, "блок scan_mngr__start_connection_cb не влезает в отведённые ему 72 байт")
  .text.scan_mngr__start_dwell_event_cb 0x008f12c8 : { KEEP(*(.text.scan_mngr__start_dwell_event_cb)) }
  ASSERT(SIZEOF(.text.scan_mngr__start_dwell_event_cb) <= 48, "блок scan_mngr__start_dwell_event_cb не влезает в отведённые ему 48 байт")
  .text.start_find_session 0x008f12f8 : { KEEP(*(.text.start_find_session)) }
  ASSERT(SIZEOF(.text.start_find_session) <= 96, "блок start_find_session не влезает в отведённые ему 96 байт")
  .text.conn__bind_cid_to_lm 0x008f1358 : { KEEP(*(.text.conn__bind_cid_to_lm)) }
  ASSERT(SIZEOF(.text.conn__bind_cid_to_lm) <= 52, "блок conn__bind_cid_to_lm не влезает в отведённые ему 52 байт")
  .text.find_sm__start_listen 0x008f138c : { KEEP(*(.text.find_sm__start_listen)) }
  ASSERT(SIZEOF(.text.find_sm__start_listen) <= 32, "блок find_sm__start_listen не влезает в отведённые ему 32 байт")
  .text.frag_8f13ac 0x008f13ac : { KEEP(*(.text.frag_8f13ac)) }
  ASSERT(SIZEOF(.text.frag_8f13ac) <= 4, "блок frag_8f13ac не влезает в отведённые ему 4 байт")
  .text.maintain_sm__on_start_maintain 0x008f13b0 : { KEEP(*(.text.maintain_sm__on_start_maintain)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_start_maintain) <= 104, "блок maintain_sm__on_start_maintain не влезает в отведённые ему 104 байт")
  .text.frag_8f1418 0x008f1418 : { KEEP(*(.text.frag_8f1418)) }
  ASSERT(SIZEOF(.text.frag_8f1418) <= 4, "блок frag_8f1418 не влезает в отведённые ему 4 байт")
  .text.l2mgr__mac_started_log 0x008f141c : { KEEP(*(.text.l2mgr__mac_started_log)) }
  ASSERT(SIZEOF(.text.l2mgr__mac_started_log) <= 88, "блок l2mgr__mac_started_log не влезает в отведённые ему 88 байт")
  .text.scan_mngr__start_scan 0x008f1474 : { KEEP(*(.text.scan_mngr__start_scan)) }
  ASSERT(SIZEOF(.text.scan_mngr__start_scan) <= 468, "блок scan_mngr__start_scan не влезает в отведённые ему 468 байт")
  .text.find_sm__start_search 0x008f1648 : { KEEP(*(.text.find_sm__start_search)) }
  ASSERT(SIZEOF(.text.find_sm__start_search) <= 84, "блок find_sm__start_search не влезает в отведённые ему 84 байт")
  .text.ba_setup_sm__on_ready_to_run 0x008f169c : { KEEP(*(.text.ba_setup_sm__on_ready_to_run)) }
  ASSERT(SIZEOF(.text.ba_setup_sm__on_ready_to_run) <= 68, "блок ba_setup_sm__on_ready_to_run не влезает в отведённые ему 68 байт")
  .text.maintain_sm__on_stop 0x008f16e0 : { KEEP(*(.text.maintain_sm__on_stop)) }
  ASSERT(SIZEOF(.text.maintain_sm__on_stop) <= 76, "блок maintain_sm__on_stop не влезает в отведённые ему 76 байт")
  .text.frag_8f172c 0x008f172c : { KEEP(*(.text.frag_8f172c)) }
  ASSERT(SIZEOF(.text.frag_8f172c) <= 4, "блок frag_8f172c не влезает в отведённые ему 4 байт")
  .text.find_main_sm__stop 0x008f1730 : { KEEP(*(.text.find_main_sm__stop)) }
  ASSERT(SIZEOF(.text.find_main_sm__stop) <= 96, "блок find_main_sm__stop не влезает в отведённые ему 96 байт")
  .text.scan_mngr__stop_dwelling 0x008f1790 : { KEEP(*(.text.scan_mngr__stop_dwelling)) }
  ASSERT(SIZEOF(.text.scan_mngr__stop_dwelling) <= 40, "блок scan_mngr__stop_dwelling не влезает в отведённые ему 40 байт")
  .text.stop_find_session 0x008f17b8 : { KEEP(*(.text.stop_find_session)) }
  ASSERT(SIZEOF(.text.stop_find_session) <= 32, "блок stop_find_session не влезает в отведённые ему 32 байт")
  .text.WBE_DRIVER__CLOSE 0x008f17d8 : { KEEP(*(.text.WBE_DRIVER__CLOSE)) }
  ASSERT(SIZEOF(.text.WBE_DRIVER__CLOSE) <= 32, "блок WBE_DRIVER__CLOSE не влезает в отведённые ему 32 байт")
  .text.find_main_sm__stop_searching 0x008f17f8 : { KEEP(*(.text.find_main_sm__stop_searching)) }
  ASSERT(SIZEOF(.text.find_main_sm__stop_searching) <= 36, "блок find_main_sm__stop_searching не влезает в отведённые ему 36 байт")
  .text.scan_mngr__stop_sm_event_cb 0x008f181c : { KEEP(*(.text.scan_mngr__stop_sm_event_cb)) }
  ASSERT(SIZEOF(.text.scan_mngr__stop_sm_event_cb) <= 40, "блок scan_mngr__stop_sm_event_cb не влезает в отведённые ему 40 байт")
  .text.sniffer_mode_step 0x008f1844 : { KEEP(*(.text.sniffer_mode_step)) }
  ASSERT(SIZEOF(.text.sniffer_mode_step) <= 136, "блок sniffer_mode_step не влезает в отведённые ему 136 байт")
  .text.disc_sm__sw_data_stopped 0x008f18cc : { KEEP(*(.text.disc_sm__sw_data_stopped)) }
  ASSERT(SIZEOF(.text.disc_sm__sw_data_stopped) <= 60, "блок disc_sm__sw_data_stopped не влезает в отведённые ему 60 байт")
  .text.frag_8f1908 0x008f1908 : { KEEP(*(.text.frag_8f1908)) }
  ASSERT(SIZEOF(.text.frag_8f1908) <= 68, "блок frag_8f1908 не влезает в отведённые ему 68 байт")
  .text.find_main_sm__on_start_listen 0x008f194c : { KEEP(*(.text.find_main_sm__on_start_listen)) }
  ASSERT(SIZEOF(.text.find_main_sm__on_start_listen) <= 24, "блок find_main_sm__on_start_listen не влезает в отведённые ему 24 байт")
  .text.pcie_boot_step_a 0x008f1964 : { KEEP(*(.text.pcie_boot_step_a)) }
  ASSERT(SIZEOF(.text.pcie_boot_step_a) <= 156, "блок pcie_boot_step_a не влезает в отведённые ему 156 байт")
  .text.pcie_boot_step_b 0x008f1a00 : { KEEP(*(.text.pcie_boot_step_b)) }
  ASSERT(SIZEOF(.text.pcie_boot_step_b) <= 156, "блок pcie_boot_step_b не влезает в отведённые ему 156 байт")
  .text.discovery__tsf_wa 0x008f1a9c : { KEEP(*(.text.discovery__tsf_wa)) }
  ASSERT(SIZEOF(.text.discovery__tsf_wa) <= 100, "блок discovery__tsf_wa не влезает в отведённые ему 100 байт")
  .text.mgmt_tx__build_assoc_req 0x008f1b00 : { KEEP(*(.text.mgmt_tx__build_assoc_req)) }
  ASSERT(SIZEOF(.text.mgmt_tx__build_assoc_req) <= 320, "блок mgmt_tx__build_assoc_req не влезает в отведённые ему 320 байт")
  .text.mgmt_tx__build_assoc_resp 0x008f1c40 : { KEEP(*(.text.mgmt_tx__build_assoc_resp)) }
  ASSERT(SIZEOF(.text.mgmt_tx__build_assoc_resp) <= 324, "блок mgmt_tx__build_assoc_resp не влезает в отведённые ему 324 байт")
  .text.tx_mgmt_get_ie 0x008f1d84 : { KEEP(*(.text.tx_mgmt_get_ie)) }
  ASSERT(SIZEOF(.text.tx_mgmt_get_ie) <= 96, "блок tx_mgmt_get_ie не влезает в отведённые ему 96 байт")
  .text.ie__classify_vendor_oui 0x008f1de4 : { KEEP(*(.text.ie__classify_vendor_oui)) }
  ASSERT(SIZEOF(.text.ie__classify_vendor_oui) <= 148, "блок ie__classify_vendor_oui не влезает в отведённые ему 148 байт")
  .text.mgmt_tx__build_probe_req 0x008f1e78 : { KEEP(*(.text.mgmt_tx__build_probe_req)) }
  ASSERT(SIZEOF(.text.mgmt_tx__build_probe_req) <= 216, "блок mgmt_tx__build_probe_req не влезает в отведённые ему 216 байт")
  .text.mgmt_tx__build_probe_resp 0x008f1f50 : { KEEP(*(.text.mgmt_tx__build_probe_resp)) }
  ASSERT(SIZEOF(.text.mgmt_tx__build_probe_resp) <= 292, "блок mgmt_tx__build_probe_resp не влезает в отведённые ему 292 байт")
  .text.tx_queue__config_by_mode 0x008f2074 : { KEEP(*(.text.tx_queue__config_by_mode)) }
  ASSERT(SIZEOF(.text.tx_queue__config_by_mode) <= 648, "блок tx_queue__config_by_mode не влезает в отведённые ему 648 байт")
  .text.tx_queue__config_by_mode_b 0x008f22fc : { KEEP(*(.text.tx_queue__config_by_mode_b)) }
  ASSERT(SIZEOF(.text.tx_queue__config_by_mode_b) <= 376, "блок tx_queue__config_by_mode_b не влезает в отведённые ему 376 байт")
  .text.rf_chain__program_sector_desc 0x008f2474 : { KEEP(*(.text.rf_chain__program_sector_desc)) }
  ASSERT(SIZEOF(.text.rf_chain__program_sector_desc) <= 784, "блок rf_chain__program_sector_desc не влезает в отведённые ему 784 байт")
  .text.rf_chain_dist_config 0x008f2784 : { KEEP(*(.text.rf_chain_dist_config)) }
  ASSERT(SIZEOF(.text.rf_chain_dist_config) <= 220, "блок rf_chain_dist_config не влезает в отведённые ему 220 байт")
  .text.mac_bringup__init_tx_queues 0x008f2860 : { KEEP(*(.text.mac_bringup__init_tx_queues)) }
  ASSERT(SIZEOF(.text.mac_bringup__init_tx_queues) <= 68, "блок mac_bringup__init_tx_queues не влезает в отведённые ему 68 байт")
  .text.set_reg_886a00_x2 0x008f28a4 : { KEEP(*(.text.set_reg_886a00_x2)) }
  ASSERT(SIZEOF(.text.set_reg_886a00_x2) <= 16, "блок set_reg_886a00_x2 не влезает в отведённые ему 16 байт")
  .text.l2mgr__apply_key_to_prings 0x008f28b4 : { KEEP(*(.text.l2mgr__apply_key_to_prings)) }
  ASSERT(SIZEOF(.text.l2mgr__apply_key_to_prings) <= 32, "блок l2mgr__apply_key_to_prings не влезает в отведённые ему 32 байт")
  .text.pcie__clear_cpl_timeout 0x008f28d4 : { KEEP(*(.text.pcie__clear_cpl_timeout)) }
  ASSERT(SIZEOF(.text.pcie__clear_cpl_timeout) <= 36, "блок pcie__clear_cpl_timeout не влезает в отведённые ему 36 байт")
  .text.set_reg_882670_882684 0x008f28f8 : { KEEP(*(.text.set_reg_882670_882684)) }
  ASSERT(SIZEOF(.text.set_reg_882670_882684) <= 24, "блок set_reg_882670_882684 не влезает в отведённые ему 24 байт")
  .text.set_reg_88268c_x2 0x008f2910 : { KEEP(*(.text.set_reg_88268c_x2)) }
  ASSERT(SIZEOF(.text.set_reg_88268c_x2) <= 16, "блок set_reg_88268c_x2 не влезает в отведённые ему 16 байт")
  .text.set_reg_88268c_x2_8f2920 0x008f2920 : { KEEP(*(.text.set_reg_88268c_x2_8f2920)) }
  ASSERT(SIZEOF(.text.set_reg_88268c_x2_8f2920) <= 16, "блок set_reg_88268c_x2_8f2920 не влезает в отведённые ему 16 байт")
  .text.set_reg_88268c_x2_8f2930 0x008f2930 : { KEEP(*(.text.set_reg_88268c_x2_8f2930)) }
  ASSERT(SIZEOF(.text.set_reg_88268c_x2_8f2930) <= 12, "блок set_reg_88268c_x2_8f2930 не влезает в отведённые ему 12 байт")
  .text.stub_ret_8f293c 0x008f293c : { KEEP(*(.text.stub_ret_8f293c)) }
  ASSERT(SIZEOF(.text.stub_ret_8f293c) <= 4, "блок stub_ret_8f293c не влезает в отведённые ему 4 байт")
  .text.rf_kill_sm__on_w_disable__pending_disabled 0x008f2940 : { KEEP(*(.text.rf_kill_sm__on_w_disable__pending_disabled)) }
  ASSERT(SIZEOF(.text.rf_kill_sm__on_w_disable__pending_disabled) <= 8, "блок rf_kill_sm__on_w_disable__pending_disabled не влезает в отведённые ему 8 байт")
  .text.rf_kill__set_flag 0x008f2948 : { KEEP(*(.text.rf_kill__set_flag)) }
  ASSERT(SIZEOF(.text.rf_kill__set_flag) <= 20, "блок rf_kill__set_flag не влезает в отведённые ему 20 байт")
  .text.validate_connect 0x008f295c : { KEEP(*(.text.validate_connect)) }
  ASSERT(SIZEOF(.text.validate_connect) <= 128, "блок validate_connect не влезает в отведённые ему 128 байт")
  .text.l2_mgr__validate_scan 0x008f29dc : { KEEP(*(.text.l2_mgr__validate_scan)) }
  ASSERT(SIZEOF(.text.l2_mgr__validate_scan) <= 240, "блок l2_mgr__validate_scan не влезает в отведённые ему 240 байт")
  .text.wait_for_disconnect 0x008f2acc : { KEEP(*(.text.wait_for_disconnect)) }
  ASSERT(SIZEOF(.text.wait_for_disconnect) <= 108, "блок wait_for_disconnect не влезает в отведённые ему 108 байт")
  .text.l2mgr__setup_bcast_queues 0x008f2b38 : { KEEP(*(.text.l2mgr__setup_bcast_queues)) }
  ASSERT(SIZEOF(.text.l2mgr__setup_bcast_queues) <= 16, "блок l2mgr__setup_bcast_queues не влезает в отведённые ему 16 байт")
  .text.wmi_handler_vring_ba_dis 0x008f2b48 : { KEEP(*(.text.wmi_handler_vring_ba_dis)) }
  ASSERT(SIZEOF(.text.wmi_handler_vring_ba_dis) <= 44, "блок wmi_handler_vring_ba_dis не влезает в отведённые ему 44 байт")
  .text.wmi_handler_vring_ba_en 0x008f2b74 : { KEEP(*(.text.wmi_handler_vring_ba_en)) }
  ASSERT(SIZEOF(.text.wmi_handler_vring_ba_en) <= 56, "блок wmi_handler_vring_ba_en не влезает в отведённые ему 56 байт")
  .text.wmi_handler_bcast_vring_cfg 0x008f2bac : { KEEP(*(.text.wmi_handler_bcast_vring_cfg)) }
  ASSERT(SIZEOF(.text.wmi_handler_bcast_vring_cfg) <= 192, "блок wmi_handler_bcast_vring_cfg не влезает в отведённые ему 192 байт")
  .text.wmi_handler_ese_cfg 0x008f2c6c : { KEEP(*(.text.wmi_handler_ese_cfg)) }
  ASSERT(SIZEOF(.text.wmi_handler_ese_cfg) <= 28, "блок wmi_handler_ese_cfg не влезает в отведённые ему 28 байт")
  .text.wmi_handler_get_pcp_channel 0x008f2c88 : { KEEP(*(.text.wmi_handler_get_pcp_channel)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_pcp_channel) <= 84, "блок wmi_handler_get_pcp_channel не влезает в отведённые ему 84 байт")
  .text.wmi_handler_get_pcp_factor 0x008f2cdc : { KEEP(*(.text.wmi_handler_get_pcp_factor)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_pcp_factor) <= 80, "блок wmi_handler_get_pcp_factor не влезает в отведённые ему 80 байт")
  .text.wmi_handler_get_ssid 0x008f2d2c : { KEEP(*(.text.wmi_handler_get_ssid)) }
  ASSERT(SIZEOF(.text.wmi_handler_get_ssid) <= 72, "блок wmi_handler_get_ssid не влезает в отведённые ему 72 байт")
  .text.l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74 0x008f2d74 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74) <= 148, "блок l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74 не влезает в отведённые ему 148 байт")
  .text.wmi_handler_pmc 0x008f2e08 : { KEEP(*(.text.wmi_handler_pmc)) }
  ASSERT(SIZEOF(.text.wmi_handler_pmc) <= 72, "блок wmi_handler_pmc не влезает в отведённые ему 72 байт")
  .text.wmi_handler_port_allocate 0x008f2e50 : { KEEP(*(.text.wmi_handler_port_allocate)) }
  ASSERT(SIZEOF(.text.wmi_handler_port_allocate) <= 128, "блок wmi_handler_port_allocate не влезает в отведённые ему 128 байт")
  .text.wmi_handler_cfg_rx_chain 0x008f2ed0 : { KEEP(*(.text.wmi_handler_cfg_rx_chain)) }
  ASSERT(SIZEOF(.text.wmi_handler_cfg_rx_chain) <= 864, "блок wmi_handler_cfg_rx_chain не влезает в отведённые ему 864 байт")
  .text.l2mgr__set_app_ie 0x008f3230 : { KEEP(*(.text.l2mgr__set_app_ie)) }
  ASSERT(SIZEOF(.text.l2mgr__set_app_ie) <= 84, "блок l2mgr__set_app_ie не влезает в отведённые ему 84 байт")
  .text.l2mgr__set_mac_address 0x008f3284 : { KEEP(*(.text.l2mgr__set_mac_address)) }
  ASSERT(SIZEOF(.text.l2mgr__set_mac_address) <= 76, "блок l2mgr__set_mac_address не влезает в отведённые ему 76 байт")
  .text.wmi_handler_set_pcp_channel 0x008f32d0 : { KEEP(*(.text.wmi_handler_set_pcp_channel)) }
  ASSERT(SIZEOF(.text.wmi_handler_set_pcp_channel) <= 72, "блок wmi_handler_set_pcp_channel не влезает в отведённые ему 72 байт")
  .text.l2_mgr__wmi_cmd_handler_set_ssid 0x008f3318 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_set_ssid)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_set_ssid) <= 60, "блок l2_mgr__wmi_cmd_handler_set_ssid не влезает в отведённые ему 60 байт")
  .text.l2mgr__start_discovery 0x008f3354 : { KEEP(*(.text.l2mgr__start_discovery)) }
  ASSERT(SIZEOF(.text.l2mgr__start_discovery) <= 32, "блок l2mgr__start_discovery не влезает в отведённые ему 32 байт")
  .text.l2_mgr__wmi_cmd_handler_start_listen_8f3374 0x008f3374 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_start_listen_8f3374)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_start_listen_8f3374) <= 68, "блок l2_mgr__wmi_cmd_handler_start_listen_8f3374 не влезает в отведённые ему 68 байт")
  .text.l2_mgr__wmi_cmd_handler_start_search_8f33b8 0x008f33b8 : { KEEP(*(.text.l2_mgr__wmi_cmd_handler_start_search_8f33b8)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_cmd_handler_start_search_8f33b8) <= 68, "блок l2_mgr__wmi_cmd_handler_start_search_8f33b8 не влезает в отведённые ему 68 байт")
  .text.l2mgr__stop_discovery 0x008f33fc : { KEEP(*(.text.l2mgr__stop_discovery)) }
  ASSERT(SIZEOF(.text.l2mgr__stop_discovery) <= 52, "блок l2mgr__stop_discovery не влезает в отведённые ему 52 байт")
  .text.wmi_handler_sw_tx_req 0x008f3430 : { KEEP(*(.text.wmi_handler_sw_tx_req)) }
  ASSERT(SIZEOF(.text.wmi_handler_sw_tx_req) <= 312, "блок wmi_handler_sw_tx_req не влезает в отведённые ему 312 байт")
  .text.WMI_ADD_CIPHER_KEY_CMD 0x008f3568 : { KEEP(*(.text.WMI_ADD_CIPHER_KEY_CMD)) }
  ASSERT(SIZEOF(.text.WMI_ADD_CIPHER_KEY_CMD) <= 424, "блок WMI_ADD_CIPHER_KEY_CMD не влезает в отведённые ему 424 байт")
  .text.l2_mgr__wmi_scan_cmd 0x008f3710 : { KEEP(*(.text.l2_mgr__wmi_scan_cmd)) }
  ASSERT(SIZEOF(.text.l2_mgr__wmi_scan_cmd) <= 168, "блок l2_mgr__wmi_scan_cmd не влезает в отведённые ему 168 байт")
  .text.encap_trans_type 0x008f37b8 : { KEEP(*(.text.encap_trans_type)) }
  ASSERT(SIZEOF(.text.encap_trans_type) <= 452, "блок encap_trans_type не влезает в отведённые ему 452 байт")
  .text.otp__read_bytes 0x008f397c : { KEEP(*(.text.otp__read_bytes)) }
  ASSERT(SIZEOF(.text.otp__read_bytes) <= 84, "блок otp__read_bytes не влезает в отведённые ему 84 байт")
  .text.xpm_read_cnt 0x008f39d0 : { KEEP(*(.text.xpm_read_cnt)) }
  ASSERT(SIZEOF(.text.xpm_read_cnt) <= 112, "блок xpm_read_cnt не влезает в отведённые ему 112 байт")
  .text.otp__write_bytes 0x008f3a40 : { KEEP(*(.text.otp__write_bytes)) }
  ASSERT(SIZEOF(.text.otp__write_bytes) <= 100, "блок otp__write_bytes не влезает в отведённые ему 100 байт")
  .text.otp__write_word 0x008f3aa4 : { KEEP(*(.text.otp__write_word)) }
  ASSERT(SIZEOF(.text.otp__write_word) <= 92, "блок otp__write_word не влезает в отведённые ему 92 байт")
  .text.marlon_r_if__otp_write 0x008f3b00 : { KEEP(*(.text.marlon_r_if__otp_write)) }
  ASSERT(SIZEOF(.text.marlon_r_if__otp_write) <= 56, "блок marlon_r_if__otp_write не влезает в отведённые ему 56 байт")
  .text.isr_nop_pad 0x008f3b38 : { KEEP(*(.text.isr_nop_pad)) }
  ASSERT(SIZEOF(.text.isr_nop_pad) <= 32, "блок isr_nop_pad не влезает в отведённые ему 32 байт")
  .text.vacated_bss_set_active 0x008c456c : { KEEP(*(.text.vacated_bss_set_active)) }
  .text.vacated_tx_bcon__del_bcon 0x008c7578 : { KEEP(*(.text.vacated_tx_bcon__del_bcon)) }
  .text.vacated_hwd_pcie_l1_enter_isr 0x008ce8d8 : { KEEP(*(.text.vacated_hwd_pcie_l1_enter_isr)) }
  .text.vacated_regulatory_domain__set_country_code 0x008e1670 : { KEEP(*(.text.vacated_regulatory_domain__set_country_code)) }
  .text.vacated_pcp_stop 0x008ef014 : { KEEP(*(.text.vacated_pcp_stop)) }
  /* переписанные на C блоки — в свободный хвост */
  .text.rewritten 0x8f3b58 : {
    KEEP(*(.text.bss_set_active)) KEEP(*(.text.bss_set_active.*))
    KEEP(*(.text.hwd_pcie_l1_enter_isr)) KEEP(*(.text.hwd_pcie_l1_enter_isr.*))
    KEEP(*(.text.pcp_stop)) KEEP(*(.text.pcp_stop.*))
    KEEP(*(.text.regulatory_domain__set_country_code)) KEEP(*(.text.regulatory_domain__set_country_code.*))
    KEEP(*(.text.tx_bcon__del_bcon)) KEEP(*(.text.tx_bcon__del_bcon.*))
    KEEP(*(.text.rw)) KEEP(*(.text.rw.*))
    *(.text .text.*)
    *(EXCLUDE_FILE(*fw_data.o) .rodata EXCLUDE_FILE(*fw_data.o) .rodata.*)
    *(.data .data.*)
    *(.bss .bss.* COMMON)
  }
  .rodata.rewritten : { KEEP(*(.rodata.rw)) KEEP(*(.rodata.rw.*)) }
  ASSERT(. <= 0x00900000, "переписанный код не влезает в свободный хвост")
  .rodata.fw_data 0x00800000 : { KEEP(*(.rodata.fw_data)) }
  PROVIDE(L_8c456c = bss_set_active);
  PROVIDE(L_8c7578 = tx_bcon__del_bcon);
  PROVIDE(L_8ce8d8 = hwd_pcie_l1_enter_isr);
  PROVIDE(L_8e1670 = regulatory_domain__set_country_code);
  PROVIDE(L_8ef014 = pcp_stop);
  /DISCARD/ : { *(.comment) *(.note*) *(.ARC.attributes) }
}
