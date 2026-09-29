/* Размещение сегмента uc_code.  Сгенерировано gen_layout.py. */
SECTIONS
{
  .text.uc_interrupt_vector_00 0x00920000 : { KEEP(*(.text.uc_interrupt_vector_00)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_00) <= 8, "блок uc_interrupt_vector_00 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_01 0x00920008 : { KEEP(*(.text.uc_interrupt_vector_01)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_01) <= 8, "блок uc_interrupt_vector_01 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_02 0x00920010 : { KEEP(*(.text.uc_interrupt_vector_02)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_02) <= 8, "блок uc_interrupt_vector_02 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_03 0x00920018 : { KEEP(*(.text.uc_interrupt_vector_03)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_03) <= 8, "блок uc_interrupt_vector_03 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_04 0x00920020 : { KEEP(*(.text.uc_interrupt_vector_04)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_04) <= 8, "блок uc_interrupt_vector_04 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_05 0x00920028 : { KEEP(*(.text.uc_interrupt_vector_05)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_05) <= 8, "блок uc_interrupt_vector_05 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_06 0x00920030 : { KEEP(*(.text.uc_interrupt_vector_06)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_06) <= 8, "блок uc_interrupt_vector_06 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_07 0x00920038 : { KEEP(*(.text.uc_interrupt_vector_07)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_07) <= 8, "блок uc_interrupt_vector_07 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_08 0x00920040 : { KEEP(*(.text.uc_interrupt_vector_08)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_08) <= 8, "блок uc_interrupt_vector_08 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_09 0x00920048 : { KEEP(*(.text.uc_interrupt_vector_09)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_09) <= 8, "блок uc_interrupt_vector_09 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_10 0x00920050 : { KEEP(*(.text.uc_interrupt_vector_10)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_10) <= 8, "блок uc_interrupt_vector_10 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_11 0x00920058 : { KEEP(*(.text.uc_interrupt_vector_11)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_11) <= 8, "блок uc_interrupt_vector_11 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_12 0x00920060 : { KEEP(*(.text.uc_interrupt_vector_12)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_12) <= 8, "блок uc_interrupt_vector_12 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_13 0x00920068 : { KEEP(*(.text.uc_interrupt_vector_13)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_13) <= 8, "блок uc_interrupt_vector_13 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_14 0x00920070 : { KEEP(*(.text.uc_interrupt_vector_14)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_14) <= 8, "блок uc_interrupt_vector_14 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_15 0x00920078 : { KEEP(*(.text.uc_interrupt_vector_15)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_15) <= 8, "блок uc_interrupt_vector_15 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_16 0x00920080 : { KEEP(*(.text.uc_interrupt_vector_16)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_16) <= 8, "блок uc_interrupt_vector_16 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_17 0x00920088 : { KEEP(*(.text.uc_interrupt_vector_17)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_17) <= 8, "блок uc_interrupt_vector_17 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_18 0x00920090 : { KEEP(*(.text.uc_interrupt_vector_18)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_18) <= 8, "блок uc_interrupt_vector_18 не влезает в отведённые ему 8 байт")
  .text.uc_interrupt_vector_19 0x00920098 : { KEEP(*(.text.uc_interrupt_vector_19)) }
  ASSERT(SIZEOF(.text.uc_interrupt_vector_19) <= 8, "блок uc_interrupt_vector_19 не влезает в отведённые ему 8 байт")
  .text.uc_vector_9200a0 0x009200a0 : { KEEP(*(.text.uc_vector_9200a0)) }
  ASSERT(SIZEOF(.text.uc_vector_9200a0) <= 4, "блок uc_vector_9200a0 не влезает в отведённые ему 4 байт")
  .text.uc_unused_vectors 0x009200a4 : { KEEP(*(.text.uc_unused_vectors)) }
  ASSERT(SIZEOF(.text.uc_unused_vectors) <= 36, "блок uc_unused_vectors не влезает в отведённые ему 36 байт")
  .text.uc_vector_9200c8 0x009200c8 : { KEEP(*(.text.uc_vector_9200c8)) }
  ASSERT(SIZEOF(.text.uc_vector_9200c8) <= 4, "блок uc_vector_9200c8 не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200cc 0x009200cc : { KEEP(*(.text.uc_vector_9200cc)) }
  ASSERT(SIZEOF(.text.uc_vector_9200cc) <= 4, "блок uc_vector_9200cc не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200d0 0x009200d0 : { KEEP(*(.text.uc_vector_9200d0)) }
  ASSERT(SIZEOF(.text.uc_vector_9200d0) <= 4, "блок uc_vector_9200d0 не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200d4 0x009200d4 : { KEEP(*(.text.uc_vector_9200d4)) }
  ASSERT(SIZEOF(.text.uc_vector_9200d4) <= 4, "блок uc_vector_9200d4 не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200d8 0x009200d8 : { KEEP(*(.text.uc_vector_9200d8)) }
  ASSERT(SIZEOF(.text.uc_vector_9200d8) <= 8, "блок uc_vector_9200d8 не влезает в отведённые ему 8 байт")
  .text.uc_vector_9200e0 0x009200e0 : { KEEP(*(.text.uc_vector_9200e0)) }
  ASSERT(SIZEOF(.text.uc_vector_9200e0) <= 4, "блок uc_vector_9200e0 не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200e4 0x009200e4 : { KEEP(*(.text.uc_vector_9200e4)) }
  ASSERT(SIZEOF(.text.uc_vector_9200e4) <= 4, "блок uc_vector_9200e4 не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200e8 0x009200e8 : { KEEP(*(.text.uc_vector_9200e8)) }
  ASSERT(SIZEOF(.text.uc_vector_9200e8) <= 4, "блок uc_vector_9200e8 не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200ec 0x009200ec : { KEEP(*(.text.uc_vector_9200ec)) }
  ASSERT(SIZEOF(.text.uc_vector_9200ec) <= 4, "блок uc_vector_9200ec не влезает в отведённые ему 4 байт")
  .text.uc_vector_9200f0 0x009200f0 : { KEEP(*(.text.uc_vector_9200f0)) }
  ASSERT(SIZEOF(.text.uc_vector_9200f0) <= 4, "блок uc_vector_9200f0 не влезает в отведённые ему 4 байт")
  .text.uc_unused_vectors_9200f4 0x009200f4 : { KEEP(*(.text.uc_unused_vectors_9200f4)) }
  ASSERT(SIZEOF(.text.uc_unused_vectors_9200f4) <= 12, "блок uc_unused_vectors_9200f4 не влезает в отведённые ему 12 байт")
  .text.uc_boot__call_9215b0 0x00920100 : { KEEP(*(.text.uc_boot__call_9215b0)) }
  ASSERT(SIZEOF(.text.uc_boot__call_9215b0) <= 20, "блок uc_boot__call_9215b0 не влезает в отведённые ему 20 байт")
  .text.uc_boot__init_list_80095c 0x00920114 : { KEEP(*(.text.uc_boot__init_list_80095c)) }
  ASSERT(SIZEOF(.text.uc_boot__init_list_80095c) <= 32, "блок uc_boot__init_list_80095c не влезает в отведённые ему 32 байт")
  .text.uc_vector_920134 0x00920134 : { KEEP(*(.text.uc_vector_920134)) }
  ASSERT(SIZEOF(.text.uc_vector_920134) <= 4, "блок uc_vector_920134 не влезает в отведённые ему 4 байт")
  .text.uc_vector_920138 0x00920138 : { KEEP(*(.text.uc_vector_920138)) }
  ASSERT(SIZEOF(.text.uc_vector_920138) <= 4, "блок uc_vector_920138 не влезает в отведённые ему 4 байт")
  .text.uc_vector_92013c 0x0092013c : { KEEP(*(.text.uc_vector_92013c)) }
  ASSERT(SIZEOF(.text.uc_vector_92013c) <= 4, "блок uc_vector_92013c не влезает в отведённые ему 4 байт")
  .text.uc_reset_init 0x00920140 : { KEEP(*(.text.uc_reset_init)) }
  ASSERT(SIZEOF(.text.uc_reset_init) <= 36, "блок uc_reset_init не влезает в отведённые ему 36 байт")
  .text.uc_entry_init 0x00920164 : { KEEP(*(.text.uc_entry_init)) }
  ASSERT(SIZEOF(.text.uc_entry_init) <= 128, "блок uc_entry_init не влезает в отведённые ему 128 байт")
  .text.__st_gp_to_r13_uc 0x009201e4 : { KEEP(*(.text.__st_gp_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_gp_to_r13_uc) <= 4, "блок __st_gp_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r25_to_r13_uc 0x009201e8 : { KEEP(*(.text.__st_r25_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r25_to_r13_uc) <= 4, "блок __st_r25_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r24_to_r13_uc 0x009201ec : { KEEP(*(.text.__st_r24_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r24_to_r13_uc) <= 4, "блок __st_r24_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r23_to_r13_uc 0x009201f0 : { KEEP(*(.text.__st_r23_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r23_to_r13_uc) <= 4, "блок __st_r23_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r22_to_r13_uc 0x009201f4 : { KEEP(*(.text.__st_r22_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r22_to_r13_uc) <= 4, "блок __st_r22_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r21_to_r13_uc 0x009201f8 : { KEEP(*(.text.__st_r21_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r21_to_r13_uc) <= 4, "блок __st_r21_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r20_to_r13_uc 0x009201fc : { KEEP(*(.text.__st_r20_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r20_to_r13_uc) <= 4, "блок __st_r20_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r19_to_r13_uc 0x00920200 : { KEEP(*(.text.__st_r19_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r19_to_r13_uc) <= 4, "блок __st_r19_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r18_to_r13_uc 0x00920204 : { KEEP(*(.text.__st_r18_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r18_to_r13_uc) <= 4, "блок __st_r18_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r17_to_r13_uc 0x00920208 : { KEEP(*(.text.__st_r17_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r17_to_r13_uc) <= 4, "блок __st_r17_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r16_to_r13_uc 0x0092020c : { KEEP(*(.text.__st_r16_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r16_to_r13_uc) <= 4, "блок __st_r16_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r15_to_r13_uc 0x00920210 : { KEEP(*(.text.__st_r15_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r15_to_r13_uc) <= 4, "блок __st_r15_to_r13_uc не влезает в отведённые ему 4 байт")
  .text.__st_r14_to_r13_uc 0x00920214 : { KEEP(*(.text.__st_r14_to_r13_uc)) }
  ASSERT(SIZEOF(.text.__st_r14_to_r13_uc) <= 12, "блок __st_r14_to_r13_uc не влезает в отведённые ему 12 байт")
  .text.stub_ret_920220 0x00920220 : { KEEP(*(.text.stub_ret_920220)) }
  ASSERT(SIZEOF(.text.stub_ret_920220) <= 4, "блок stub_ret_920220 не влезает в отведённые ему 4 байт")
  .text.__ld_gp_to_r13_ret_uc 0x00920224 : { KEEP(*(.text.__ld_gp_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_gp_to_r13_ret_uc) <= 8, "блок __ld_gp_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r25_to_r13_ret_uc 0x0092022c : { KEEP(*(.text.__ld_r25_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r25_to_r13_ret_uc) <= 8, "блок __ld_r25_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r24_to_r13_ret_uc 0x00920234 : { KEEP(*(.text.__ld_r24_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r24_to_r13_ret_uc) <= 8, "блок __ld_r24_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r23_to_r13_ret_uc 0x0092023c : { KEEP(*(.text.__ld_r23_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r23_to_r13_ret_uc) <= 8, "блок __ld_r23_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r22_to_r13_ret_uc 0x00920244 : { KEEP(*(.text.__ld_r22_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r22_to_r13_ret_uc) <= 8, "блок __ld_r22_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r21_to_r13_ret_uc 0x0092024c : { KEEP(*(.text.__ld_r21_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r21_to_r13_ret_uc) <= 8, "блок __ld_r21_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r20_to_r13_ret_uc 0x00920254 : { KEEP(*(.text.__ld_r20_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r20_to_r13_ret_uc) <= 4, "блок __ld_r20_to_r13_ret_uc не влезает в отведённые ему 4 байт")
  .text.tail_ld_regs_uc_920258 0x00920258 : { KEEP(*(.text.tail_ld_regs_uc_920258)) }
  ASSERT(SIZEOF(.text.tail_ld_regs_uc_920258) <= 4, "блок tail_ld_regs_uc_920258 не влезает в отведённые ему 4 байт")
  .text.__ld_r19_to_r13_ret_uc 0x0092025c : { KEEP(*(.text.__ld_r19_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r19_to_r13_ret_uc) <= 4, "блок __ld_r19_to_r13_ret_uc не влезает в отведённые ему 4 байт")
  .text.tail_ld_regs_uc_920260 0x00920260 : { KEEP(*(.text.tail_ld_regs_uc_920260)) }
  ASSERT(SIZEOF(.text.tail_ld_regs_uc_920260) <= 4, "блок tail_ld_regs_uc_920260 не влезает в отведённые ему 4 байт")
  .text.__ld_r18_to_r13_ret_uc 0x00920264 : { KEEP(*(.text.__ld_r18_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r18_to_r13_ret_uc) <= 8, "блок __ld_r18_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r17_to_r13_ret_uc 0x0092026c : { KEEP(*(.text.__ld_r17_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r17_to_r13_ret_uc) <= 4, "блок __ld_r17_to_r13_ret_uc не влезает в отведённые ему 4 байт")
  .text.tail_ld_regs_uc_920270 0x00920270 : { KEEP(*(.text.tail_ld_regs_uc_920270)) }
  ASSERT(SIZEOF(.text.tail_ld_regs_uc_920270) <= 4, "блок tail_ld_regs_uc_920270 не влезает в отведённые ему 4 байт")
  .text.__ld_r16_to_r13_ret_uc 0x00920274 : { KEEP(*(.text.__ld_r16_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r16_to_r13_ret_uc) <= 8, "блок __ld_r16_to_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_r15_to_r13_ret_uc 0x0092027c : { KEEP(*(.text.__ld_r15_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r15_to_r13_ret_uc) <= 4, "блок __ld_r15_to_r13_ret_uc не влезает в отведённые ему 4 байт")
  .text.tail_ld_regs_uc_920280 0x00920280 : { KEEP(*(.text.tail_ld_regs_uc_920280)) }
  ASSERT(SIZEOF(.text.tail_ld_regs_uc_920280) <= 4, "блок tail_ld_regs_uc_920280 не влезает в отведённые ему 4 байт")
  .text.__ld_r14_to_r13_ret_uc 0x00920284 : { KEEP(*(.text.__ld_r14_to_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r14_to_r13_ret_uc) <= 4, "блок __ld_r14_to_r13_ret_uc не влезает в отведённые ему 4 байт")
  .text.tail_ld_regs_uc_920288 0x00920288 : { KEEP(*(.text.tail_ld_regs_uc_920288)) }
  ASSERT(SIZEOF(.text.tail_ld_regs_uc_920288) <= 4, "блок tail_ld_regs_uc_920288 не влезает в отведённые ему 4 байт")
  .text.__ld_r13_ret_uc 0x0092028c : { KEEP(*(.text.__ld_r13_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_r13_ret_uc) <= 8, "блок __ld_r13_ret_uc не влезает в отведённые ему 8 байт")
  .text.__ld_blink_ret_uc 0x00920294 : { KEEP(*(.text.__ld_blink_ret_uc)) }
  ASSERT(SIZEOF(.text.__ld_blink_ret_uc) <= 4, "блок __ld_blink_ret_uc не влезает в отведённые ему 4 байт")
  .text.__ld_regs_tail_uc 0x00920298 : { KEEP(*(.text.__ld_regs_tail_uc)) }
  ASSERT(SIZEOF(.text.__ld_regs_tail_uc) <= 60, "блок __ld_regs_tail_uc не влезает в отведённые ему 60 байт")
  .text.uc_irq_enable 0x009202d4 : { KEEP(*(.text.uc_irq_enable)) }
  ASSERT(SIZEOF(.text.uc_irq_enable) <= 16, "блок uc_irq_enable не влезает в отведённые ему 16 байт")
  .text.uc_irq_enable_l1 0x009202e4 : { KEEP(*(.text.uc_irq_enable_l1)) }
  ASSERT(SIZEOF(.text.uc_irq_enable_l1) <= 16, "блок uc_irq_enable_l1 не влезает в отведённые ему 16 байт")
  .text.uc_status32_set_bit2 0x009202f4 : { KEEP(*(.text.uc_status32_set_bit2)) }
  ASSERT(SIZEOF(.text.uc_status32_set_bit2) <= 8, "блок uc_status32_set_bit2 не влезает в отведённые ему 8 байт")
  .text.stub_ret_9202fc 0x009202fc : { KEEP(*(.text.stub_ret_9202fc)) }
  ASSERT(SIZEOF(.text.stub_ret_9202fc) <= 4, "блок stub_ret_9202fc не влезает в отведённые ему 4 байт")
  .text.uc_flag_stub 0x00920300 : { KEEP(*(.text.uc_flag_stub)) }
  ASSERT(SIZEOF(.text.uc_flag_stub) <= 16, "блок uc_flag_stub не влезает в отведённые ему 16 байт")
  .text.memcpy_uc 0x00920310 : { KEEP(*(.text.memcpy_uc)) }
  ASSERT(SIZEOF(.text.memcpy_uc) <= 176, "блок memcpy_uc не влезает в отведённые ему 176 байт")
  .text.uc_divmod_signed 0x009203c0 : { KEEP(*(.text.uc_divmod_signed)) }
  ASSERT(SIZEOF(.text.uc_divmod_signed) <= 120, "блок uc_divmod_signed не влезает в отведённые ему 120 байт")
  .text.shl64 0x00920438 : { KEEP(*(.text.shl64)) }
  ASSERT(SIZEOF(.text.shl64) <= 44, "блок shl64 не влезает в отведённые ему 44 байт")
  .text.softfloat_int_to_double 0x00920464 : { KEEP(*(.text.softfloat_int_to_double)) }
  ASSERT(SIZEOF(.text.softfloat_int_to_double) <= 20, "блок softfloat_int_to_double не влезает в отведённые ему 20 байт")
  .text.softfloat_u32_to_double 0x00920478 : { KEEP(*(.text.softfloat_u32_to_double)) }
  ASSERT(SIZEOF(.text.softfloat_u32_to_double) <= 52, "блок softfloat_u32_to_double не влезает в отведённые ему 52 байт")
  .text.softfloat_df_mul 0x009204ac : { KEEP(*(.text.softfloat_df_mul)) }
  ASSERT(SIZEOF(.text.softfloat_df_mul) <= 1204, "блок softfloat_df_mul не влезает в отведённые ему 1204 байт")
  .text.softfloat_df_sub 0x00920960 : { KEEP(*(.text.softfloat_df_sub)) }
  ASSERT(SIZEOF(.text.softfloat_df_sub) <= 12, "блок softfloat_df_sub не влезает в отведённые ему 12 байт")
  .text.softfloat_negate_r3 0x0092096c : { KEEP(*(.text.softfloat_negate_r3)) }
  ASSERT(SIZEOF(.text.softfloat_negate_r3) <= 8, "блок softfloat_negate_r3 не влезает в отведённые ему 8 байт")
  .text.softfloat_df_add 0x00920974 : { KEEP(*(.text.softfloat_df_add)) }
  ASSERT(SIZEOF(.text.softfloat_df_add) <= 1888, "блок softfloat_df_add не влезает в отведённые ему 1888 байт")
  .text.softfloat_double_to_short_b 0x009210d4 : { KEEP(*(.text.softfloat_double_to_short_b)) }
  ASSERT(SIZEOF(.text.softfloat_double_to_short_b) <= 16, "блок softfloat_double_to_short_b не влезает в отведённые ему 16 байт")
  .text.softfloat_double_to_short 0x009210e4 : { KEEP(*(.text.softfloat_double_to_short)) }
  ASSERT(SIZEOF(.text.softfloat_double_to_short) <= 116, "блок softfloat_double_to_short не влезает в отведённые ему 116 байт")
  .text.uc_select_m2_or_1 0x00921158 : { KEEP(*(.text.uc_select_m2_or_1)) }
  ASSERT(SIZEOF(.text.uc_select_m2_or_1) <= 16, "блок uc_select_m2_or_1 не влезает в отведённые ему 16 байт")
  .text.uc_ret_minus1 0x00921168 : { KEEP(*(.text.uc_ret_minus1)) }
  ASSERT(SIZEOF(.text.uc_ret_minus1) <= 8, "блок uc_ret_minus1 не влезает в отведённые ему 8 байт")
  .text.uc_isr_instruction_error 0x00921170 : { KEEP(*(.text.uc_isr_instruction_error)) }
  ASSERT(SIZEOF(.text.uc_isr_instruction_error) <= 16, "блок uc_isr_instruction_error не влезает в отведённые ему 16 байт")
  .text.uc_isr_l2_task1 0x00921180 : { KEEP(*(.text.uc_isr_l2_task1)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task1) <= 24, "блок uc_isr_l2_task1 не влезает в отведённые ему 24 байт")
  .text.uc_isr_l2_task1__body 0x00921198 : { KEEP(*(.text.uc_isr_l2_task1__body)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task1__body) <= 108, "блок uc_isr_l2_task1__body не влезает в отведённые ему 108 байт")
  .text.uc_isr_l2_task1__tail 0x00921204 : { KEEP(*(.text.uc_isr_l2_task1__tail)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task1__tail) <= 20, "блок uc_isr_l2_task1__tail не влезает в отведённые ему 20 байт")
  .text.frag_921218 0x00921218 : { KEEP(*(.text.frag_921218)) }
  ASSERT(SIZEOF(.text.frag_921218) <= 4, "блок frag_921218 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec11 0x0092121c : { KEEP(*(.text.uc_isr_vec11)) }
  ASSERT(SIZEOF(.text.uc_isr_vec11) <= 4, "блок uc_isr_vec11 не влезает в отведённые ему 4 байт")
  .text.uc_isr_l1_task2 0x00921220 : { KEEP(*(.text.uc_isr_l1_task2)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task2) <= 156, "блок uc_isr_l1_task2 не влезает в отведённые ему 156 байт")
  .text.uc_isr_vec13 0x009212bc : { KEEP(*(.text.uc_isr_vec13)) }
  ASSERT(SIZEOF(.text.uc_isr_vec13) <= 4, "блок uc_isr_vec13 не влезает в отведённые ему 4 байт")
  .text.uc_isr_l2_task2 0x009212c0 : { KEEP(*(.text.uc_isr_l2_task2)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task2) <= 156, "блок uc_isr_l2_task2 не влезает в отведённые ему 156 байт")
  .text.uc_isr_vec15 0x0092135c : { KEEP(*(.text.uc_isr_vec15)) }
  ASSERT(SIZEOF(.text.uc_isr_vec15) <= 4, "блок uc_isr_vec15 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec16 0x00921360 : { KEEP(*(.text.uc_isr_vec16)) }
  ASSERT(SIZEOF(.text.uc_isr_vec16) <= 4, "блок uc_isr_vec16 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec17 0x00921364 : { KEEP(*(.text.uc_isr_vec17)) }
  ASSERT(SIZEOF(.text.uc_isr_vec17) <= 4, "блок uc_isr_vec17 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec18 0x00921368 : { KEEP(*(.text.uc_isr_vec18)) }
  ASSERT(SIZEOF(.text.uc_isr_vec18) <= 4, "блок uc_isr_vec18 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec04 0x0092136c : { KEEP(*(.text.uc_isr_vec04)) }
  ASSERT(SIZEOF(.text.uc_isr_vec04) <= 4, "блок uc_isr_vec04 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec05 0x00921370 : { KEEP(*(.text.uc_isr_vec05)) }
  ASSERT(SIZEOF(.text.uc_isr_vec05) <= 4, "блок uc_isr_vec05 не влезает в отведённые ему 4 байт")
  .text.uc_isr_l2_task0 0x00921374 : { KEEP(*(.text.uc_isr_l2_task0)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task0) <= 144, "блок uc_isr_l2_task0 не влезает в отведённые ему 144 байт")
  .text.uc_isr_l2_task0__tail 0x00921404 : { KEEP(*(.text.uc_isr_l2_task0__tail)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task0__tail) <= 12, "блок uc_isr_l2_task0__tail не влезает в отведённые ему 12 байт")
  .text.uc_isr_l1_task0 0x00921410 : { KEEP(*(.text.uc_isr_l1_task0)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task0) <= 156, "блок uc_isr_l1_task0 не влезает в отведённые ему 156 байт")
  .text.uc_isr_l1_task1 0x009214ac : { KEEP(*(.text.uc_isr_l1_task1)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task1) <= 152, "блок uc_isr_l1_task1 не влезает в отведённые ему 152 байт")
  .text.uc_isr_l1_task1__tail 0x00921544 : { KEEP(*(.text.uc_isr_l1_task1__tail)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task1__tail) <= 4, "блок uc_isr_l1_task1__tail не влезает в отведённые ему 4 байт")
  .text.uc_isr_memory_error 0x00921548 : { KEEP(*(.text.uc_isr_memory_error)) }
  ASSERT(SIZEOF(.text.uc_isr_memory_error) <= 16, "блок uc_isr_memory_error не влезает в отведённые ему 16 байт")
  .text.uc_isr_memory_error__body 0x00921558 : { KEEP(*(.text.uc_isr_memory_error__body)) }
  ASSERT(SIZEOF(.text.uc_isr_memory_error__body) <= 68, "блок uc_isr_memory_error__body не влезает в отведённые ему 68 байт")
  .text.uc_isr_memory_error__tail 0x0092159c : { KEEP(*(.text.uc_isr_memory_error__tail)) }
  ASSERT(SIZEOF(.text.uc_isr_memory_error__tail) <= 4, "блок uc_isr_memory_error__tail не влезает в отведённые ему 4 байт")
  .text.set_g_80165c 0x009215a0 : { KEEP(*(.text.set_g_80165c)) }
  ASSERT(SIZEOF(.text.set_g_80165c) <= 16, "блок set_g_80165c не влезает в отведённые ему 16 байт")
  .text.uc_deferred__run_all 0x009215b0 : { KEEP(*(.text.uc_deferred__run_all)) }
  ASSERT(SIZEOF(.text.uc_deferred__run_all) <= 44, "блок uc_deferred__run_all не влезает в отведённые ему 44 байт")
  .text.uc_list_800b90__run_head_cb 0x009215dc : { KEEP(*(.text.uc_list_800b90__run_head_cb)) }
  ASSERT(SIZEOF(.text.uc_list_800b90__run_head_cb) <= 32, "блок uc_list_800b90__run_head_cb не влезает в отведённые ему 32 байт")
  .text.uc_list__insert_by_prio 0x009215fc : { KEEP(*(.text.uc_list__insert_by_prio)) }
  ASSERT(SIZEOF(.text.uc_list__insert_by_prio) <= 16, "блок uc_list__insert_by_prio не влезает в отведённые ему 16 байт")
  .text.uc_main_init 0x0092160c : { KEEP(*(.text.uc_main_init)) }
  ASSERT(SIZEOF(.text.uc_main_init) <= 96, "блок uc_main_init не влезает в отведённые ему 96 байт")
  .text.memset0_words_uc 0x0092166c : { KEEP(*(.text.memset0_words_uc)) }
  ASSERT(SIZEOF(.text.memset0_words_uc) <= 68, "блок memset0_words_uc не влезает в отведённые ему 68 байт")
  .text.memset0_words_uc__entries 0x009216b0 : { KEEP(*(.text.memset0_words_uc__entries)) }
  ASSERT(SIZEOF(.text.memset0_words_uc__entries) <= 24, "блок memset0_words_uc__entries не влезает в отведённые ему 24 байт")
  .text.memset0_words_uc__entry_9216c8 0x009216c8 : { KEEP(*(.text.memset0_words_uc__entry_9216c8)) }
  ASSERT(SIZEOF(.text.memset0_words_uc__entry_9216c8) <= 8, "блок memset0_words_uc__entry_9216c8 не влезает в отведённые ему 8 байт")
  .text.memset0_words_uc__body 0x009216d0 : { KEEP(*(.text.memset0_words_uc__body)) }
  ASSERT(SIZEOF(.text.memset0_words_uc__body) <= 44, "блок memset0_words_uc__body не влезает в отведённые ему 44 байт")
  .text.bi_dti__sleep_and_resume 0x009216fc : { KEEP(*(.text.bi_dti__sleep_and_resume)) }
  ASSERT(SIZEOF(.text.bi_dti__sleep_and_resume) <= 68, "блок bi_dti__sleep_and_resume не влезает в отведённые ему 68 байт")
  .text.ucode_cmd__load_table_80208c 0x00921740 : { KEEP(*(.text.ucode_cmd__load_table_80208c)) }
  ASSERT(SIZEOF(.text.ucode_cmd__load_table_80208c) <= 48, "блок ucode_cmd__load_table_80208c не влезает в отведённые ему 48 байт")
  .text.ucode_cmd_0x23_handler 0x00921770 : { KEEP(*(.text.ucode_cmd_0x23_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x23_handler) <= 12, "блок ucode_cmd_0x23_handler не влезает в отведённые ему 12 байт")
  .text.mac__prepare_txrx_window 0x0092177c : { KEEP(*(.text.mac__prepare_txrx_window)) }
  ASSERT(SIZEOF(.text.mac__prepare_txrx_window) <= 376, "блок mac__prepare_txrx_window не влезает в отведённые ему 376 байт")
  .text.bf__enter_mode3 0x009218f4 : { KEEP(*(.text.bf__enter_mode3)) }
  ASSERT(SIZEOF(.text.bf__enter_mode3) <= 28, "блок bf__enter_mode3 не влезает в отведённые ему 28 байт")
  .text.bf_substate__next_step 0x00921910 : { KEEP(*(.text.bf_substate__next_step)) }
  ASSERT(SIZEOF(.text.bf_substate__next_step) <= 32, "блок bf_substate__next_step не влезает в отведённые ему 32 байт")
  .text.basic_if__alloc_evt_slot 0x00921930 : { KEEP(*(.text.basic_if__alloc_evt_slot)) }
  ASSERT(SIZEOF(.text.basic_if__alloc_evt_slot) <= 96, "блок basic_if__alloc_evt_slot не влезает в отведённые ему 96 байт")
  .text.uc_deref_field4_921990 0x00921990 : { KEEP(*(.text.uc_deref_field4_921990)) }
  ASSERT(SIZEOF(.text.uc_deref_field4_921990) <= 8, "блок uc_deref_field4_921990 не влезает в отведённые ему 8 байт")
  .text.uc_field_0x24_is_zero 0x00921998 : { KEEP(*(.text.uc_field_0x24_is_zero)) }
  ASSERT(SIZEOF(.text.uc_field_0x24_is_zero) <= 28, "блок uc_field_0x24_is_zero не влезает в отведённые ему 28 байт")
  .text.uc_irq_set_level 0x009219b4 : { KEEP(*(.text.uc_irq_set_level)) }
  ASSERT(SIZEOF(.text.uc_irq_set_level) <= 20, "блок uc_irq_set_level не влезает в отведённые ему 20 байт")
  .text.shallow_sleep_rfc_step 0x009219c8 : { KEEP(*(.text.shallow_sleep_rfc_step)) }
  ASSERT(SIZEOF(.text.shallow_sleep_rfc_step) <= 128, "блок shallow_sleep_rfc_step не влезает в отведённые ему 128 байт")
  .text.bi_manager_rx_step 0x00921a48 : { KEEP(*(.text.bi_manager_rx_step)) }
  ASSERT(SIZEOF(.text.bi_manager_rx_step) <= 272, "блок bi_manager_rx_step не влезает в отведённые ему 272 байт")
  .text.brp__find_phase_index 0x00921b58 : { KEEP(*(.text.brp__find_phase_index)) }
  ASSERT(SIZEOF(.text.brp__find_phase_index) <= 88, "блок brp__find_phase_index не влезает в отведённые ему 88 байт")
  .text.brp__sum_sector_counts 0x00921bb0 : { KEEP(*(.text.brp__sum_sector_counts)) }
  ASSERT(SIZEOF(.text.brp__sum_sector_counts) <= 124, "блок brp__sum_sector_counts не влезает в отведённые ему 124 байт")
  .text.aw__open_event_mask 0x00921c2c : { KEEP(*(.text.aw__open_event_mask)) }
  ASSERT(SIZEOF(.text.aw__open_event_mask) <= 16, "блок aw__open_event_mask не влезает в отведённые ему 16 байт")
  .text.bi_ap_mon__aw_on_bhi_to_aw 0x00921c3c : { KEEP(*(.text.bi_ap_mon__aw_on_bhi_to_aw)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__aw_on_bhi_to_aw) <= 44, "блок bi_ap_mon__aw_on_bhi_to_aw не влезает в отведённые ему 44 байт")
  .text.epi_921c68 0x00921c68 : { KEEP(*(.text.epi_921c68)) }
  ASSERT(SIZEOF(.text.epi_921c68) <= 4, "блок epi_921c68 не влезает в отведённые ему 4 байт")
  .text.bi_ap_mon__aw_on_bhi_to_dti 0x00921c6c : { KEEP(*(.text.bi_ap_mon__aw_on_bhi_to_dti)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__aw_on_bhi_to_dti) <= 44, "блок bi_ap_mon__aw_on_bhi_to_dti не влезает в отведённые ему 44 байт")
  .text.epi_921c98 0x00921c98 : { KEEP(*(.text.epi_921c98)) }
  ASSERT(SIZEOF(.text.epi_921c98) <= 4, "блок epi_921c98 не влезает в отведённые ему 4 байт")
  .text.bi_ap_mon__aw_on_dti_to_bti 0x00921c9c : { KEEP(*(.text.bi_ap_mon__aw_on_dti_to_bti)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__aw_on_dti_to_bti) <= 72, "блок bi_ap_mon__aw_on_dti_to_bti не влезает в отведённые ему 72 байт")
  .text.epi_921ce4 0x00921ce4 : { KEEP(*(.text.epi_921ce4)) }
  ASSERT(SIZEOF(.text.epi_921ce4) <= 4, "блок epi_921ce4 не влезает в отведённые ему 4 байт")
  .text.bi_window_timing_update 0x00921ce8 : { KEEP(*(.text.bi_window_timing_update)) }
  ASSERT(SIZEOF(.text.bi_window_timing_update) <= 300, "блок bi_window_timing_update не влезает в отведённые ему 300 байт")
  .text.background_task__step 0x00921e14 : { KEEP(*(.text.background_task__step)) }
  ASSERT(SIZEOF(.text.background_task__step) <= 12, "блок background_task__step не влезает в отведённые ему 12 байт")
  .text.uc_restore_status32 0x00921e20 : { KEEP(*(.text.uc_restore_status32)) }
  ASSERT(SIZEOF(.text.uc_restore_status32) <= 12, "блок uc_restore_status32 не влезает в отведённые ему 12 байт")
  .text.background_task__dispatch 0x00921e2c : { KEEP(*(.text.background_task__dispatch)) }
  ASSERT(SIZEOF(.text.background_task__dispatch) <= 300, "блок background_task__dispatch не влезает в отведённые ему 300 байт")
  .text.bf_pending__set_bit 0x00921f58 : { KEEP(*(.text.bf_pending__set_bit)) }
  ASSERT(SIZEOF(.text.bf_pending__set_bit) <= 44, "блок bf_pending__set_bit не влезает в отведённые ему 44 байт")
  .text.rx__set_enable_mask 0x00921f84 : { KEEP(*(.text.rx__set_enable_mask)) }
  ASSERT(SIZEOF(.text.rx__set_enable_mask) <= 44, "блок rx__set_enable_mask не влезает в отведённые ему 44 байт")
  .text.rw_g_800630_921fb0 0x00921fb0 : { KEEP(*(.text.rw_g_800630_921fb0)) }
  ASSERT(SIZEOF(.text.rw_g_800630_921fb0) <= 16, "блок rw_g_800630_921fb0 не влезает в отведённые ему 16 байт")
  .text.mac_counter__program_3009 0x00921fc0 : { KEEP(*(.text.mac_counter__program_3009)) }
  ASSERT(SIZEOF(.text.mac_counter__program_3009) <= 204, "блок mac_counter__program_3009 не влезает в отведённые ему 204 байт")
  .text.bf_sm__clear_pending 0x0092208c : { KEEP(*(.text.bf_sm__clear_pending)) }
  ASSERT(SIZEOF(.text.bf_sm__clear_pending) <= 24, "блок bf_sm__clear_pending не влезает в отведённые ему 24 байт")
  .text.bf_sm__check_request_timeout 0x009220a4 : { KEEP(*(.text.bf_sm__check_request_timeout)) }
  ASSERT(SIZEOF(.text.bf_sm__check_request_timeout) <= 120, "блок bf_sm__check_request_timeout не влезает в отведённые ему 120 байт")
  .text.bf_clear_all_sta 0x0092211c : { KEEP(*(.text.bf_clear_all_sta)) }
  ASSERT(SIZEOF(.text.bf_clear_all_sta) <= 136, "блок bf_clear_all_sta не влезает в отведённые ему 136 байт")
  .text.bf__reset_rx_counters 0x009221a4 : { KEEP(*(.text.bf__reset_rx_counters)) }
  ASSERT(SIZEOF(.text.bf__reset_rx_counters) <= 24, "блок bf__reset_rx_counters не влезает в отведённые ему 24 байт")
  .text.bf_sm__reset_sta_rate 0x009221bc : { KEEP(*(.text.bf_sm__reset_sta_rate)) }
  ASSERT(SIZEOF(.text.bf_sm__reset_sta_rate) <= 60, "блок bf_sm__reset_sta_rate не влезает в отведённые ему 60 байт")
  .text.bf_sm__step_by_state 0x009221f8 : { KEEP(*(.text.bf_sm__step_by_state)) }
  ASSERT(SIZEOF(.text.bf_sm__step_by_state) <= 112, "блок bf_sm__step_by_state не влезает в отведённые ему 112 байт")
  .text.ucode_cmd_trigger_bf 0x00922268 : { KEEP(*(.text.ucode_cmd_trigger_bf)) }
  ASSERT(SIZEOF(.text.ucode_cmd_trigger_bf) <= 56, "блок ucode_cmd_trigger_bf не влезает в отведённые ему 56 байт")
  .text.bi_mode__reset_bf_state 0x009222a0 : { KEEP(*(.text.bi_mode__reset_bf_state)) }
  ASSERT(SIZEOF(.text.bi_mode__reset_bf_state) <= 44, "блок bi_mode__reset_bf_state не влезает в отведённые ему 44 байт")
  .text.bf_sm__trigger 0x009222cc : { KEEP(*(.text.bf_sm__trigger)) }
  ASSERT(SIZEOF(.text.bf_sm__trigger) <= 232, "блок bf_sm__trigger не влезает в отведённые ему 232 байт")
  .text.bf_sm__pop_request_fifo 0x009223b4 : { KEEP(*(.text.bf_sm__pop_request_fifo)) }
  ASSERT(SIZEOF(.text.bf_sm__pop_request_fifo) <= 148, "блок bf_sm__pop_request_fifo не влезает в отведённые ему 148 байт")
  .text.bf_sm__mark_sta_active 0x00922448 : { KEEP(*(.text.bf_sm__mark_sta_active)) }
  ASSERT(SIZEOF(.text.bf_sm__mark_sta_active) <= 96, "блок bf_sm__mark_sta_active не влезает в отведённые ему 96 байт")
  .text.mem_8571dc__or_bit 0x009224a8 : { KEEP(*(.text.mem_8571dc__or_bit)) }
  ASSERT(SIZEOF(.text.mem_8571dc__or_bit) <= 28, "блок mem_8571dc__or_bit не влезает в отведённые ему 28 байт")
  .text.bf_sm__release_sta 0x009224c4 : { KEEP(*(.text.bf_sm__release_sta)) }
  ASSERT(SIZEOF(.text.bf_sm__release_sta) <= 60, "блок bf_sm__release_sta не влезает в отведённые ему 60 байт")
  .text.bf_sm__check_sta_timeout 0x00922500 : { KEEP(*(.text.bf_sm__check_sta_timeout)) }
  ASSERT(SIZEOF(.text.bf_sm__check_sta_timeout) <= 96, "блок bf_sm__check_sta_timeout не влезает в отведённые ему 96 байт")
  .text.bf_sm__start_request 0x00922560 : { KEEP(*(.text.bf_sm__start_request)) }
  ASSERT(SIZEOF(.text.bf_sm__start_request) <= 140, "блок bf_sm__start_request не влезает в отведённые ему 140 байт")
  .text.bf_sm__background_step 0x009225ec : { KEEP(*(.text.bf_sm__background_step)) }
  ASSERT(SIZEOF(.text.bf_sm__background_step) <= 104, "блок bf_sm__background_step не влезает в отведённые ему 104 байт")
  .text.bf_sm__substate_advance 0x00922654 : { KEEP(*(.text.bf_sm__substate_advance)) }
  ASSERT(SIZEOF(.text.bf_sm__substate_advance) <= 172, "блок bf_sm__substate_advance не влезает в отведённые ему 172 байт")
  .text.bf_sm__assert_and_clear 0x00922700 : { KEEP(*(.text.bf_sm__assert_and_clear)) }
  ASSERT(SIZEOF(.text.bf_sm__assert_and_clear) <= 24, "блок bf_sm__assert_and_clear не влезает в отведённые ему 24 байт")
  .text.bf_sm__state_failure_path 0x00922718 : { KEEP(*(.text.bf_sm__state_failure_path)) }
  ASSERT(SIZEOF(.text.bf_sm__state_failure_path) <= 48, "блок bf_sm__state_failure_path не влезает в отведённые ему 48 байт")
  .text.bf_sm__process_request_fifo 0x00922748 : { KEEP(*(.text.bf_sm__process_request_fifo)) }
  ASSERT(SIZEOF(.text.bf_sm__process_request_fifo) <= 264, "блок bf_sm__process_request_fifo не влезает в отведённые ему 264 байт")
  .text.bf_substate__dispatch_by_state 0x00922850 : { KEEP(*(.text.bf_substate__dispatch_by_state)) }
  ASSERT(SIZEOF(.text.bf_substate__dispatch_by_state) <= 276, "блок bf_substate__dispatch_by_state не влезает в отведённые ему 276 байт")
  .text.bf_sm__post_and_dispatch 0x00922964 : { KEEP(*(.text.bf_sm__post_and_dispatch)) }
  ASSERT(SIZEOF(.text.bf_sm__post_and_dispatch) <= 12, "блок bf_sm__post_and_dispatch не влезает в отведённые ему 12 байт")
  .text.ucode_cmd_config_lmac_bf_sm 0x00922970 : { KEEP(*(.text.ucode_cmd_config_lmac_bf_sm)) }
  ASSERT(SIZEOF(.text.ucode_cmd_config_lmac_bf_sm) <= 84, "блок ucode_cmd_config_lmac_bf_sm не влезает в отведённые ему 84 байт")
  .text.bf_sm__clear_sta 0x009229c4 : { KEEP(*(.text.bf_sm__clear_sta)) }
  ASSERT(SIZEOF(.text.bf_sm__clear_sta) <= 76, "блок bf_sm__clear_sta не влезает в отведённые ему 76 байт")
  .text.rx_funcs__record_level_800fa0 0x00922a10 : { KEEP(*(.text.rx_funcs__record_level_800fa0)) }
  ASSERT(SIZEOF(.text.rx_funcs__record_level_800fa0) <= 36, "блок rx_funcs__record_level_800fa0 не влезает в отведённые ему 36 байт")
  .text.bi_manager_step_a 0x00922a34 : { KEEP(*(.text.bi_manager_step_a)) }
  ASSERT(SIZEOF(.text.bi_manager_step_a) <= 200, "блок bi_manager_step_a не влезает в отведённые ему 200 байт")
  .text.bi_manager_step_b 0x00922afc : { KEEP(*(.text.bi_manager_step_b)) }
  ASSERT(SIZEOF(.text.bi_manager_step_b) <= 136, "блок bi_manager_step_b не влезает в отведённые ему 136 байт")
  .text.bi_timing_snapshot_b 0x00922b84 : { KEEP(*(.text.bi_timing_snapshot_b)) }
  ASSERT(SIZEOF(.text.bi_timing_snapshot_b) <= 260, "блок bi_timing_snapshot_b не влезает в отведённые ему 260 байт")
  .text.bf_sm__substate_result_by_slot 0x00922c88 : { KEEP(*(.text.bf_sm__substate_result_by_slot)) }
  ASSERT(SIZEOF(.text.bf_sm__substate_result_by_slot) <= 72, "блок bf_sm__substate_result_by_slot не влезает в отведённые ему 72 байт")
  .text.bf_substate__brp_mode_by_slot 0x00922cd0 : { KEEP(*(.text.bf_substate__brp_mode_by_slot)) }
  ASSERT(SIZEOF(.text.bf_substate__brp_mode_by_slot) <= 56, "блок bf_substate__brp_mode_by_slot не влезает в отведённые ему 56 байт")
  .text.mac_mode_brp_step 0x00922d08 : { KEEP(*(.text.mac_mode_brp_step)) }
  ASSERT(SIZEOF(.text.mac_mode_brp_step) <= 240, "блок mac_mode_brp_step не влезает в отведённые ему 240 байт")
  .text.brp__mode_step 0x00922df8 : { KEEP(*(.text.brp__mode_step)) }
  ASSERT(SIZEOF(.text.brp__mode_step) <= 124, "блок brp__mode_step не влезает в отведённые ему 124 байт")
  .text.mac_mode__wait_ppdu_and_kick 0x00922e74 : { KEEP(*(.text.mac_mode__wait_ppdu_and_kick)) }
  ASSERT(SIZEOF(.text.mac_mode__wait_ppdu_and_kick) <= 84, "блок mac_mode__wait_ppdu_and_kick не влезает в отведённые ему 84 байт")
  .text.mac_mode_step_b 0x00922ec8 : { KEEP(*(.text.mac_mode_step_b)) }
  ASSERT(SIZEOF(.text.mac_mode_step_b) <= 152, "блок mac_mode_step_b не влезает в отведённые ему 152 байт")
  .text.mac_mode_program_a 0x00922f60 : { KEEP(*(.text.mac_mode_program_a)) }
  ASSERT(SIZEOF(.text.mac_mode_program_a) <= 840, "блок mac_mode_program_a не влезает в отведённые ему 840 байт")
  .text.brp_copy_step 0x009232a8 : { KEEP(*(.text.brp_copy_step)) }
  ASSERT(SIZEOF(.text.brp_copy_step) <= 224, "блок brp_copy_step не влезает в отведённые ему 224 байт")
  .text.bf_sm__advance_if_slot33 0x00923388 : { KEEP(*(.text.bf_sm__advance_if_slot33)) }
  ASSERT(SIZEOF(.text.bf_sm__advance_if_slot33) <= 40, "блок bf_sm__advance_if_slot33 не влезает в отведённые ему 40 байт")
  .text.bf_sm__post_slot_result 0x009233b0 : { KEEP(*(.text.bf_sm__post_slot_result)) }
  ASSERT(SIZEOF(.text.bf_sm__post_slot_result) <= 80, "блок bf_sm__post_slot_result не влезает в отведённые ему 80 байт")
  .text.brp_flow_step 0x00923400 : { KEEP(*(.text.brp_flow_step)) }
  ASSERT(SIZEOF(.text.brp_flow_step) <= 412, "блок brp_flow_step не влезает в отведённые ему 412 байт")
  .text.mac_mode__wait_ppdu_and_kick_c 0x0092359c : { KEEP(*(.text.mac_mode__wait_ppdu_and_kick_c)) }
  ASSERT(SIZEOF(.text.mac_mode__wait_ppdu_and_kick_c) <= 84, "блок mac_mode__wait_ppdu_and_kick_c не влезает в отведённые ему 84 байт")
  .text.brp__rx_chain_from_r38 0x009235f0 : { KEEP(*(.text.brp__rx_chain_from_r38)) }
  ASSERT(SIZEOF(.text.brp__rx_chain_from_r38) <= 56, "блок brp__rx_chain_from_r38 не влезает в отведённые ему 56 байт")
  .text.mac_mode_program_b 0x00923628 : { KEEP(*(.text.mac_mode_program_b)) }
  ASSERT(SIZEOF(.text.mac_mode_program_b) <= 584, "блок mac_mode_program_b не влезает в отведённые ему 584 байт")
  .text.brp_step_b 0x00923870 : { KEEP(*(.text.brp_step_b)) }
  ASSERT(SIZEOF(.text.brp_step_b) <= 192, "блок brp_step_b не влезает в отведённые ему 192 байт")
  .text.brp__program_and_measure 0x00923930 : { KEEP(*(.text.brp__program_and_measure)) }
  ASSERT(SIZEOF(.text.brp__program_and_measure) <= 592, "блок brp__program_and_measure не влезает в отведённые ему 592 байт")
  .text.bi_ap_mon__bti_on_aw_to_dti 0x00923b80 : { KEEP(*(.text.bi_ap_mon__bti_on_aw_to_dti)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__bti_on_aw_to_dti) <= 40, "блок bi_ap_mon__bti_on_aw_to_dti не влезает в отведённые ему 40 байт")
  .text.bti_worker_bi2_step 0x00923ba8 : { KEEP(*(.text.bti_worker_bi2_step)) }
  ASSERT(SIZEOF(.text.bti_worker_bi2_step) <= 204, "блок bti_worker_bi2_step не влезает в отведённые ему 204 байт")
  .text.bti_transmitter_bi2_flow 0x00923c74 : { KEEP(*(.text.bti_transmitter_bi2_flow)) }
  ASSERT(SIZEOF(.text.bti_transmitter_bi2_flow) <= 324, "блок bti_transmitter_bi2_flow не влезает в отведённые ему 324 байт")
  .text.bti__request_bf_metric 0x00923db8 : { KEEP(*(.text.bti__request_bf_metric)) }
  ASSERT(SIZEOF(.text.bti__request_bf_metric) <= 28, "блок bti__request_bf_metric не влезает в отведённые ему 28 байт")
  .text.bti_bi2__gp2_end_flag 0x00923dd4 : { KEEP(*(.text.bti_bi2__gp2_end_flag)) }
  ASSERT(SIZEOF(.text.bti_bi2__gp2_end_flag) <= 12, "блок bti_bi2__gp2_end_flag не влезает в отведённые ему 12 байт")
  .text.bti_worker__bti_transmitter_beacon_sweep_flow 0x00923de0 : { KEEP(*(.text.bti_worker__bti_transmitter_beacon_sweep_flow)) }
  ASSERT(SIZEOF(.text.bti_worker__bti_transmitter_beacon_sweep_flow) <= 1564, "блок bti_worker__bti_transmitter_beacon_sweep_flow не влезает в отведённые ему 1564 байт")
  .text.direct_tx__init_rx_desc 0x009243fc : { KEEP(*(.text.direct_tx__init_rx_desc)) }
  ASSERT(SIZEOF(.text.direct_tx__init_rx_desc) <= 56, "блок direct_tx__init_rx_desc не влезает в отведённые ему 56 байт")
  .text.calc_awake_tsf 0x00924434 : { KEEP(*(.text.calc_awake_tsf)) }
  ASSERT(SIZEOF(.text.calc_awake_tsf) <= 272, "блок calc_awake_tsf не влезает в отведённые ему 272 байт")
  .text.bi__tsf_delta64 0x00924544 : { KEEP(*(.text.bi__tsf_delta64)) }
  ASSERT(SIZEOF(.text.bi__tsf_delta64) <= 36, "блок bi__tsf_delta64 не влезает в отведённые ему 36 байт")
  .text.uc_tsf_elapsed 0x00924568 : { KEEP(*(.text.uc_tsf_elapsed)) }
  ASSERT(SIZEOF(.text.uc_tsf_elapsed) <= 16, "блок uc_tsf_elapsed не влезает в отведённые ему 16 байт")
  .text.cf_end__tx_flow 0x00924578 : { KEEP(*(.text.cf_end__tx_flow)) }
  ASSERT(SIZEOF(.text.cf_end__tx_flow) <= 584, "блок cf_end__tx_flow не влезает в отведённые ему 584 байт")
  .text.tx_mtp__open_window 0x009247c0 : { KEEP(*(.text.tx_mtp__open_window)) }
  ASSERT(SIZEOF(.text.tx_mtp__open_window) <= 128, "блок tx_mtp__open_window не влезает в отведённые ему 128 байт")
  .text.mac__program_4f_52 0x00924840 : { KEEP(*(.text.mac__program_4f_52)) }
  ASSERT(SIZEOF(.text.mac__program_4f_52) <= 64, "блок mac__program_4f_52 не влезает в отведённые ему 64 байт")
  .text.aw__fold_peer_masks 0x00924880 : { KEEP(*(.text.aw__fold_peer_masks)) }
  ASSERT(SIZEOF(.text.aw__fold_peer_masks) <= 104, "блок aw__fold_peer_masks не влезает в отведённые ему 104 байт")
  .text.rx__switch_to_rx_mode 0x009248e8 : { KEEP(*(.text.rx__switch_to_rx_mode)) }
  ASSERT(SIZEOF(.text.rx__switch_to_rx_mode) <= 80, "блок rx__switch_to_rx_mode не влезает в отведённые ему 80 байт")
  .text.brp__flow_main 0x00924938 : { KEEP(*(.text.brp__flow_main)) }
  ASSERT(SIZEOF(.text.brp__flow_main) <= 1152, "блок brp__flow_main не влезает в отведённые ему 1152 байт")
  .text.tx__pick_slot_for_peer 0x00924db8 : { KEEP(*(.text.tx__pick_slot_for_peer)) }
  ASSERT(SIZEOF(.text.tx__pick_slot_for_peer) <= 180, "блок tx__pick_slot_for_peer не влезает в отведённые ему 180 байт")
  .text.direct_tx__issue_cmd_33 0x00924e6c : { KEEP(*(.text.direct_tx__issue_cmd_33)) }
  ASSERT(SIZEOF(.text.direct_tx__issue_cmd_33) <= 60, "блок direct_tx__issue_cmd_33 не влезает в отведённые ему 60 байт")
  .text.direct_tx__program_cmd34 0x00924ea8 : { KEEP(*(.text.direct_tx__program_cmd34)) }
  ASSERT(SIZEOF(.text.direct_tx__program_cmd34) <= 76, "блок direct_tx__program_cmd34 не влезает в отведённые ему 76 байт")
  .text.direct_tx__push_payload 0x00924ef4 : { KEEP(*(.text.direct_tx__push_payload)) }
  ASSERT(SIZEOF(.text.direct_tx__push_payload) <= 136, "блок direct_tx__push_payload не влезает в отведённые ему 136 байт")
  .text.uc_wait_direct_tx_ready 0x00924f7c : { KEEP(*(.text.uc_wait_direct_tx_ready)) }
  ASSERT(SIZEOF(.text.uc_wait_direct_tx_ready) <= 60, "блок uc_wait_direct_tx_ready не влезает в отведённые ему 60 байт")
  .text.bf__clear_pending_and_notify 0x00924fb8 : { KEEP(*(.text.bf__clear_pending_and_notify)) }
  ASSERT(SIZEOF(.text.bf__clear_pending_and_notify) <= 24, "блок bf__clear_pending_and_notify не влезает в отведённые ему 24 байт")
  .text.bf__abort_to_state11 0x00924fd0 : { KEEP(*(.text.bf__abort_to_state11)) }
  ASSERT(SIZEOF(.text.bf__abort_to_state11) <= 24, "блок bf__abort_to_state11 не влезает в отведённые ему 24 байт")
  .text.sxd_hal__select_qset_group 0x00924fe8 : { KEEP(*(.text.sxd_hal__select_qset_group)) }
  ASSERT(SIZEOF(.text.sxd_hal__select_qset_group) <= 192, "блок sxd_hal__select_qset_group не влезает в отведённые ему 192 байт")
  .text.sxd_hal__mac_select_indexed 0x009250a8 : { KEEP(*(.text.sxd_hal__mac_select_indexed)) }
  ASSERT(SIZEOF(.text.sxd_hal__mac_select_indexed) <= 56, "блок sxd_hal__mac_select_indexed не влезает в отведённые ему 56 байт")
  .text.brp__program_mac_sequence 0x009250e0 : { KEEP(*(.text.brp__program_mac_sequence)) }
  ASSERT(SIZEOF(.text.brp__program_mac_sequence) <= 64, "блок brp__program_mac_sequence не влезает в отведённые ему 64 байт")
  .text.disable_tsf_event 0x00925120 : { KEEP(*(.text.disable_tsf_event)) }
  ASSERT(SIZEOF(.text.disable_tsf_event) <= 100, "блок disable_tsf_event не влезает в отведённые ему 100 байт")
  .text.pm__wake_sequence 0x00925184 : { KEEP(*(.text.pm__wake_sequence)) }
  ASSERT(SIZEOF(.text.pm__wake_sequence) <= 40, "блок pm__wake_sequence не влезает в отведённые ему 40 байт")
  .text.uc_dbg__emit_marker 0x009251ac : { KEEP(*(.text.uc_dbg__emit_marker)) }
  ASSERT(SIZEOF(.text.uc_dbg__emit_marker) <= 40, "блок uc_dbg__emit_marker не влезает в отведённые ему 40 байт")
  .text.aw__foreach_awake_peer 0x009251d4 : { KEEP(*(.text.aw__foreach_awake_peer)) }
  ASSERT(SIZEOF(.text.aw__foreach_awake_peer) <= 52, "блок aw__foreach_awake_peer не влезает в отведённые ему 52 байт")
  .text.tail_perform_shallow_sleep 0x00925208 : { KEEP(*(.text.tail_perform_shallow_sleep)) }
  ASSERT(SIZEOF(.text.tail_perform_shallow_sleep) <= 12, "блок tail_perform_shallow_sleep не влезает в отведённые ему 12 байт")
  .text.basic_sm__assert_bad_event_uc 0x00925214 : { KEEP(*(.text.basic_sm__assert_bad_event_uc)) }
  ASSERT(SIZEOF(.text.basic_sm__assert_bad_event_uc) <= 24, "блок basic_sm__assert_bad_event_uc не влезает в отведённые ему 24 байт")
  .text.uc_sysassert__idle_hist 0x0092522c : { KEEP(*(.text.uc_sysassert__idle_hist)) }
  ASSERT(SIZEOF(.text.uc_sysassert__idle_hist) <= 796, "блок uc_sysassert__idle_hist не влезает в отведённые ему 796 байт")
  .text.uc_sysassert 0x00925548 : { KEEP(*(.text.uc_sysassert)) }
  ASSERT(SIZEOF(.text.uc_sysassert) <= 904, "блок uc_sysassert не влезает в отведённые ему 904 байт")
  .text.brp__apply_slot_mcs 0x009258d0 : { KEEP(*(.text.brp__apply_slot_mcs)) }
  ASSERT(SIZEOF(.text.brp__apply_slot_mcs) <= 36, "блок brp__apply_slot_mcs не влезает в отведённые ему 36 байт")
  .text.uc_mailbox__advance 0x009258f4 : { KEEP(*(.text.uc_mailbox__advance)) }
  ASSERT(SIZEOF(.text.uc_mailbox__advance) <= 204, "блок uc_mailbox__advance не влезает в отведённые ему 204 байт")
  .text.tail_basic_if__alloc_evt_slot 0x009259c0 : { KEEP(*(.text.tail_basic_if__alloc_evt_slot)) }
  ASSERT(SIZEOF(.text.tail_basic_if__alloc_evt_slot) <= 12, "блок tail_basic_if__alloc_evt_slot не влезает в отведённые ему 12 байт")
  .text.set_reg_886ddc 0x009259cc : { KEEP(*(.text.set_reg_886ddc)) }
  ASSERT(SIZEOF(.text.set_reg_886ddc) <= 12, "блок set_reg_886ddc не влезает в отведённые ему 12 байт")
  .text.ucode_cmd__echo 0x009259d8 : { KEEP(*(.text.ucode_cmd__echo)) }
  ASSERT(SIZEOF(.text.ucode_cmd__echo) <= 36, "блок ucode_cmd__echo не влезает в отведённые ему 36 байт")
  .text.set_reg_886ddc_9259fc 0x009259fc : { KEEP(*(.text.set_reg_886ddc_9259fc)) }
  ASSERT(SIZEOF(.text.set_reg_886ddc_9259fc) <= 12, "блок set_reg_886ddc_9259fc не влезает в отведённые ему 12 байт")
  .text.l1_task__kick_and_dispatch 0x00925a08 : { KEEP(*(.text.l1_task__kick_and_dispatch)) }
  ASSERT(SIZEOF(.text.l1_task__kick_and_dispatch) <= 72, "блок l1_task__kick_and_dispatch не влезает в отведённые ему 72 байт")
  .text.mac_mode__switch_sequence 0x00925a50 : { KEEP(*(.text.mac_mode__switch_sequence)) }
  ASSERT(SIZEOF(.text.mac_mode__switch_sequence) <= 228, "блок mac_mode__switch_sequence не влезает в отведённые ему 228 байт")
  .text.set_reg_886d80_925b34 0x00925b34 : { KEEP(*(.text.set_reg_886d80_925b34)) }
  ASSERT(SIZEOF(.text.set_reg_886d80_925b34) <= 20, "блок set_reg_886d80_925b34 не влезает в отведённые ему 20 байт")
  .text.set_reg_886d80_925b48 0x00925b48 : { KEEP(*(.text.set_reg_886d80_925b48)) }
  ASSERT(SIZEOF(.text.set_reg_886d80_925b48) <= 20, "блок set_reg_886d80_925b48 не влезает в отведённые ему 20 байт")
  .text.uc_send_evt__ucode_ready 0x00925b5c : { KEEP(*(.text.uc_send_evt__ucode_ready)) }
  ASSERT(SIZEOF(.text.uc_send_evt__ucode_ready) <= 40, "блок uc_send_evt__ucode_ready не влезает в отведённые ему 40 байт")
  .text.uc_send_evt__mac_monitor 0x00925b84 : { KEEP(*(.text.uc_send_evt__mac_monitor)) }
  ASSERT(SIZEOF(.text.uc_send_evt__mac_monitor) <= 32, "блок uc_send_evt__mac_monitor не влезает в отведённые ему 32 байт")
  .text.uc_send_evt__ps_awake_peer 0x00925ba4 : { KEEP(*(.text.uc_send_evt__ps_awake_peer)) }
  ASSERT(SIZEOF(.text.uc_send_evt__ps_awake_peer) <= 44, "блок uc_send_evt__ps_awake_peer не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__bf_done 0x00925bd0 : { KEEP(*(.text.uc_send_evt__bf_done)) }
  ASSERT(SIZEOF(.text.uc_send_evt__bf_done) <= 68, "блок uc_send_evt__bf_done не влезает в отведённые ему 68 байт")
  .text.uc_send_evt__get_rf_sector_done 0x00925c14 : { KEEP(*(.text.uc_send_evt__get_rf_sector_done)) }
  ASSERT(SIZEOF(.text.uc_send_evt__get_rf_sector_done) <= 44, "блок uc_send_evt__get_rf_sector_done не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__link_lost 0x00925c40 : { KEEP(*(.text.uc_send_evt__link_lost)) }
  ASSERT(SIZEOF(.text.uc_send_evt__link_lost) <= 44, "блок uc_send_evt__link_lost не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__new_link 0x00925c6c : { KEEP(*(.text.uc_send_evt__new_link)) }
  ASSERT(SIZEOF(.text.uc_send_evt__new_link) <= 68, "блок uc_send_evt__new_link не влезает в отведённые ему 68 байт")
  .text.uc_send_evt__rs_done 0x00925cb0 : { KEEP(*(.text.uc_send_evt__rs_done)) }
  ASSERT(SIZEOF(.text.uc_send_evt__rs_done) <= 44, "блок uc_send_evt__rs_done не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__rs_started 0x00925cdc : { KEEP(*(.text.uc_send_evt__rs_started)) }
  ASSERT(SIZEOF(.text.uc_send_evt__rs_started) <= 32, "блок uc_send_evt__rs_started не влезает в отведённые ему 32 байт")
  .text.uc_send_evt__set_rf_sector_done 0x00925cfc : { KEEP(*(.text.uc_send_evt__set_rf_sector_done)) }
  ASSERT(SIZEOF(.text.uc_send_evt__set_rf_sector_done) <= 44, "блок uc_send_evt__set_rf_sector_done не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__ps_shallow_sleep_ntf 0x00925d28 : { KEEP(*(.text.uc_send_evt__ps_shallow_sleep_ntf)) }
  ASSERT(SIZEOF(.text.uc_send_evt__ps_shallow_sleep_ntf) <= 44, "блок uc_send_evt__ps_shallow_sleep_ntf не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__sta_update_field_rsp 0x00925d54 : { KEEP(*(.text.uc_send_evt__sta_update_field_rsp)) }
  ASSERT(SIZEOF(.text.uc_send_evt__sta_update_field_rsp) <= 44, "блок uc_send_evt__sta_update_field_rsp не влезает в отведённые ему 44 байт")
  .text.uc_send_evt__ps_wake_pcie 0x00925d80 : { KEEP(*(.text.uc_send_evt__ps_wake_pcie)) }
  ASSERT(SIZEOF(.text.uc_send_evt__ps_wake_pcie) <= 40, "блок uc_send_evt__ps_wake_pcie не влезает в отведённые ему 40 байт")
  .text.uc_send_evt_typed 0x00925da8 : { KEEP(*(.text.uc_send_evt_typed)) }
  ASSERT(SIZEOF(.text.uc_send_evt_typed) <= 48, "блок uc_send_evt_typed не влезает в отведённые ему 48 байт")
  .text.uc_send_event 0x00925dd8 : { KEEP(*(.text.uc_send_event)) }
  ASSERT(SIZEOF(.text.uc_send_event) <= 152, "блок uc_send_event не влезает в отведённые ему 152 байт")
  .text.brp__slot_has_peer_bit 0x00925e70 : { KEEP(*(.text.brp__slot_has_peer_bit)) }
  ASSERT(SIZEOF(.text.brp__slot_has_peer_bit) <= 52, "блок brp__slot_has_peer_bit не влезает в отведённые ему 52 байт")
  .text.aw_worker__collect_awake_peers 0x00925ea4 : { KEEP(*(.text.aw_worker__collect_awake_peers)) }
  ASSERT(SIZEOF(.text.aw_worker__collect_awake_peers) <= 704, "блок aw_worker__collect_awake_peers не влезает в отведённые ему 704 байт")
  .text.uc_get_half_0x10 0x00926164 : { KEEP(*(.text.uc_get_half_0x10)) }
  ASSERT(SIZEOF(.text.uc_get_half_0x10) <= 8, "блок uc_get_half_0x10 не влезает в отведённые ему 8 байт")
  .text.get_tx_eligibility 0x0092616c : { KEEP(*(.text.get_tx_eligibility)) }
  ASSERT(SIZEOF(.text.get_tx_eligibility) <= 372, "блок get_tx_eligibility не влезает в отведённые ему 372 байт")
  .text.bi_manager__eval_bcon_slot 0x009262e0 : { KEEP(*(.text.bi_manager__eval_bcon_slot)) }
  ASSERT(SIZEOF(.text.bi_manager__eval_bcon_slot) <= 116, "блок bi_manager__eval_bcon_slot не влезает в отведённые ему 116 байт")
  .text.tx__take_eligibility_slot 0x00926354 : { KEEP(*(.text.tx__take_eligibility_slot)) }
  ASSERT(SIZEOF(.text.tx__take_eligibility_slot) <= 64, "блок tx__take_eligibility_slot не влезает в отведённые ему 64 байт")
  .text.uc_deref_field4_926394 0x00926394 : { KEEP(*(.text.uc_deref_field4_926394)) }
  ASSERT(SIZEOF(.text.uc_deref_field4_926394) <= 8, "блок uc_deref_field4_926394 не влезает в отведённые ему 8 байт")
  .text.get_selected_rf_sector_index_cmd_handler 0x0092639c : { KEEP(*(.text.get_selected_rf_sector_index_cmd_handler)) }
  ASSERT(SIZEOF(.text.get_selected_rf_sector_index_cmd_handler) <= 180, "блок get_selected_rf_sector_index_cmd_handler не влезает в отведённые ему 180 байт")
  .text.txss__duration_by_index 0x00926450 : { KEEP(*(.text.txss__duration_by_index)) }
  ASSERT(SIZEOF(.text.txss__duration_by_index) <= 64, "блок txss__duration_by_index не влезает в отведённые ему 64 байт")
  .text.bi_ap_mon__window_code 0x00926490 : { KEEP(*(.text.bi_ap_mon__window_code)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__window_code) <= 96, "блок bi_ap_mon__window_code не влезает в отведённые ему 96 байт")
  .text.get_tx_eligibility__precheck 0x009264f0 : { KEEP(*(.text.get_tx_eligibility__precheck)) }
  ASSERT(SIZEOF(.text.get_tx_eligibility__precheck) <= 112, "блок get_tx_eligibility__precheck не влезает в отведённые ему 112 байт")
  .text.mac__set_duration_us 0x00926560 : { KEEP(*(.text.mac__set_duration_us)) }
  ASSERT(SIZEOF(.text.mac__set_duration_us) <= 92, "блок mac__set_duration_us не влезает в отведённые ему 92 байт")
  .text.ps_awake_peer__send_full 0x009265bc : { KEEP(*(.text.ps_awake_peer__send_full)) }
  ASSERT(SIZEOF(.text.ps_awake_peer__send_full) <= 76, "блок ps_awake_peer__send_full не влезает в отведённые ему 76 байт")
  .text.rx_funcs__identify_peer 0x00926608 : { KEEP(*(.text.rx_funcs__identify_peer)) }
  ASSERT(SIZEOF(.text.rx_funcs__identify_peer) <= 568, "блок rx_funcs__identify_peer не влезает в отведённые ему 568 байт")
  .text.bf__trigger_if_pending 0x00926840 : { KEEP(*(.text.bf__trigger_if_pending)) }
  ASSERT(SIZEOF(.text.bf__trigger_if_pending) <= 24, "блок bf__trigger_if_pending не влезает в отведённые ему 24 байт")
  .text.bi_manager__enter_dti 0x00926858 : { KEEP(*(.text.bi_manager__enter_dti)) }
  ASSERT(SIZEOF(.text.bi_manager__enter_dti) <= 160, "блок bi_manager__enter_dti не влезает в отведённые ему 160 байт")
  .text.ps_awake_peer__send_clear_peer 0x009268f8 : { KEEP(*(.text.ps_awake_peer__send_clear_peer)) }
  ASSERT(SIZEOF(.text.ps_awake_peer__send_clear_peer) <= 60, "блок ps_awake_peer__send_clear_peer не влезает в отведённые ему 60 байт")
  .text.power_manager__maybe_wake_pcie 0x00926934 : { KEEP(*(.text.power_manager__maybe_wake_pcie)) }
  ASSERT(SIZEOF(.text.power_manager__maybe_wake_pcie) <= 80, "блок power_manager__maybe_wake_pcie не влезает в отведённые ему 80 байт")
  .text.l1_bi_trigger_step 0x00926984 : { KEEP(*(.text.l1_bi_trigger_step)) }
  ASSERT(SIZEOF(.text.l1_bi_trigger_step) <= 140, "блок l1_bi_trigger_step не влезает в отведённые ему 140 байт")
  .text.hwd_abif__rgf_88b000 0x00926a10 : { KEEP(*(.text.hwd_abif__rgf_88b000)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88b000) <= 72, "блок hwd_abif__rgf_88b000 не влезает в отведённые ему 72 байт")
  .text.hwd_abif__rgf_88a000 0x00926a58 : { KEEP(*(.text.hwd_abif__rgf_88a000)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_88a000) <= 120, "блок hwd_abif__rgf_88a000 не влезает в отведённые ему 120 байт")
  .text.hwd_abif__rgf_880800_926ad0 0x00926ad0 : { KEEP(*(.text.hwd_abif__rgf_880800_926ad0)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_880800_926ad0) <= 48, "блок hwd_abif__rgf_880800_926ad0 не влезает в отведённые ему 48 байт")
  .text.hwd_abif__rgf_880800_926b00 0x00926b00 : { KEEP(*(.text.hwd_abif__rgf_880800_926b00)) }
  ASSERT(SIZEOF(.text.hwd_abif__rgf_880800_926b00) <= 96, "блок hwd_abif__rgf_880800_926b00 не влезает в отведённые ему 96 байт")
  .text.rgf_reg_880800 0x00926b60 : { KEEP(*(.text.rgf_reg_880800)) }
  ASSERT(SIZEOF(.text.rgf_reg_880800) <= 48, "блок rgf_reg_880800 не влезает в отведённые ему 48 байт")
  .text.get_reg_881c84 0x00926b90 : { KEEP(*(.text.get_reg_881c84)) }
  ASSERT(SIZEOF(.text.get_reg_881c84) <= 12, "блок get_reg_881c84 не влезает в отведённые ему 12 байт")
  .text.nav__read_hw_duration_flag 0x00926b9c : { KEEP(*(.text.nav__read_hw_duration_flag)) }
  ASSERT(SIZEOF(.text.nav__read_hw_duration_flag) <= 36, "блок nav__read_hw_duration_flag не влезает в отведённые ему 36 байт")
  .text.hwd_dma__set_mode_map 0x00926bc0 : { KEEP(*(.text.hwd_dma__set_mode_map)) }
  ASSERT(SIZEOF(.text.hwd_dma__set_mode_map) <= 148, "блок hwd_dma__set_mode_map не влезает в отведённые ему 148 байт")
  .text.rgf_reg_881800 0x00926c54 : { KEEP(*(.text.rgf_reg_881800)) }
  ASSERT(SIZEOF(.text.rgf_reg_881800) <= 20, "блок rgf_reg_881800 не влезает в отведённые ему 20 байт")
  .text.dma_mac__cfg_880c14 0x00926c68 : { KEEP(*(.text.dma_mac__cfg_880c14)) }
  ASSERT(SIZEOF(.text.dma_mac__cfg_880c14) <= 104, "блок dma_mac__cfg_880c14 не влезает в отведённые ему 104 байт")
  .text.set_reg_886f84_x3 0x00926cd0 : { KEEP(*(.text.set_reg_886f84_x3)) }
  ASSERT(SIZEOF(.text.set_reg_886f84_x3) <= 24, "блок set_reg_886f84_x3 не влезает в отведённые ему 24 байт")
  .text.get_reg_88c120 0x00926ce8 : { KEEP(*(.text.get_reg_88c120)) }
  ASSERT(SIZEOF(.text.get_reg_88c120) <= 16, "блок get_reg_88c120 не влезает в отведённые ему 16 байт")
  .text.set_reg_88606c 0x00926cf8 : { KEEP(*(.text.set_reg_88606c)) }
  ASSERT(SIZEOF(.text.set_reg_88606c) <= 16, "блок set_reg_88606c не влезает в отведённые ему 16 байт")
  .text.mac__load_tx_vector 0x00926d08 : { KEEP(*(.text.mac__load_tx_vector)) }
  ASSERT(SIZEOF(.text.mac__load_tx_vector) <= 44, "блок mac__load_tx_vector не влезает в отведённые ему 44 байт")
  .text.hwd_mac__set_mode_map 0x00926d34 : { KEEP(*(.text.hwd_mac__set_mode_map)) }
  ASSERT(SIZEOF(.text.hwd_mac__set_mode_map) <= 156, "блок hwd_mac__set_mode_map не влезает в отведённые ему 156 байт")
  .text.hwd_mac__apply_timing_entry 0x00926dd0 : { KEEP(*(.text.hwd_mac__apply_timing_entry)) }
  ASSERT(SIZEOF(.text.hwd_mac__apply_timing_entry) <= 148, "блок hwd_mac__apply_timing_entry не влезает в отведённые ему 148 байт")
  .text.set_reg_886dc8 0x00926e64 : { KEEP(*(.text.set_reg_886dc8)) }
  ASSERT(SIZEOF(.text.set_reg_886dc8) <= 24, "блок set_reg_886dc8 не влезает в отведённые ему 24 байт")
  .text.set_reg_886dc8_926e7c 0x00926e7c : { KEEP(*(.text.set_reg_886dc8_926e7c)) }
  ASSERT(SIZEOF(.text.set_reg_886dc8_926e7c) <= 16, "блок set_reg_886dc8_926e7c не влезает в отведённые ему 16 байт")
  .text.dma_mac__cfg_880c28 0x00926e8c : { KEEP(*(.text.dma_mac__cfg_880c28)) }
  ASSERT(SIZEOF(.text.dma_mac__cfg_880c28) <= 104, "блок dma_mac__cfg_880c28 не влезает в отведённые ему 104 байт")
  .text.hwd_phy_init__2 0x00926ef4 : { KEEP(*(.text.hwd_phy_init__2)) }
  ASSERT(SIZEOF(.text.hwd_phy_init__2) <= 208, "блок hwd_phy_init__2 не влезает в отведённые ему 208 байт")
  .text.hwd_phy__rgf_881000 0x00926fc4 : { KEEP(*(.text.hwd_phy__rgf_881000)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_881000) <= 80, "блок hwd_phy__rgf_881000 не влезает в отведённые ему 80 байт")
  .text.hwd_phy__set_881000 0x00927014 : { KEEP(*(.text.hwd_phy__set_881000)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_881000) <= 136, "блок hwd_phy__set_881000 не влезает в отведённые ему 136 байт")
  .text.uc_hwd_phy_pwr 0x0092709c : { KEEP(*(.text.uc_hwd_phy_pwr)) }
  ASSERT(SIZEOF(.text.uc_hwd_phy_pwr) <= 436, "блок uc_hwd_phy_pwr не влезает в отведённые ему 436 байт")
  .text.dma_mac__cfg_880c2c 0x00927250 : { KEEP(*(.text.dma_mac__cfg_880c2c)) }
  ASSERT(SIZEOF(.text.dma_mac__cfg_880c2c) <= 104, "блок dma_mac__cfg_880c2c не влезает в отведённые ему 104 байт")
  .text.hwd_phy__rgf_883000_9272b8 0x009272b8 : { KEEP(*(.text.hwd_phy__rgf_883000_9272b8)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_9272b8) <= 68, "блок hwd_phy__rgf_883000_9272b8 не влезает в отведённые ему 68 байт")
  .text.hwd_phy__rgf_884000 0x009272fc : { KEEP(*(.text.hwd_phy__rgf_884000)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_884000) <= 68, "блок hwd_phy__rgf_884000 не влезает в отведённые ему 68 байт")
  .text.hwd_phy__set_mode_uc 0x00927340 : { KEEP(*(.text.hwd_phy__set_mode_uc)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_mode_uc) <= 304, "блок hwd_phy__set_mode_uc не влезает в отведённые ему 304 байт")
  .text.hwd_phy__get_883830 0x00927470 : { KEEP(*(.text.hwd_phy__get_883830)) }
  ASSERT(SIZEOF(.text.hwd_phy__get_883830) <= 16, "блок hwd_phy__get_883830 не влезает в отведённые ему 16 байт")
  .text.set_reg_883150 0x00927480 : { KEEP(*(.text.set_reg_883150)) }
  ASSERT(SIZEOF(.text.set_reg_883150) <= 12, "блок set_reg_883150 не влезает в отведённые ему 12 байт")
  .text.hwd_phy__set_883000_92748c 0x0092748c : { KEEP(*(.text.hwd_phy__set_883000_92748c)) }
  ASSERT(SIZEOF(.text.hwd_phy__set_883000_92748c) <= 16, "блок hwd_phy__set_883000_92748c не влезает в отведённые ему 16 байт")
  .text.hwd_phy__rgf_883000_92749c 0x0092749c : { KEEP(*(.text.hwd_phy__rgf_883000_92749c)) }
  ASSERT(SIZEOF(.text.hwd_phy__rgf_883000_92749c) <= 72, "блок hwd_phy__rgf_883000_92749c не влезает в отведённые ему 72 байт")
  .text.set_reg_884804 0x009274e4 : { KEEP(*(.text.set_reg_884804)) }
  ASSERT(SIZEOF(.text.set_reg_884804) <= 12, "блок set_reg_884804 не влезает в отведённые ему 12 байт")
  .text.set_reg_884060 0x009274f0 : { KEEP(*(.text.set_reg_884060)) }
  ASSERT(SIZEOF(.text.set_reg_884060) <= 12, "блок set_reg_884060 не влезает в отведённые ему 12 байт")
  .text.tail_uc_hwd_rfc_write_core 0x009274fc : { KEEP(*(.text.tail_uc_hwd_rfc_write_core)) }
  ASSERT(SIZEOF(.text.tail_uc_hwd_rfc_write_core) <= 12, "блок tail_uc_hwd_rfc_write_core не влезает в отведённые ему 12 байт")
  .text.rgf_reg_889000 0x00927508 : { KEEP(*(.text.rgf_reg_889000)) }
  ASSERT(SIZEOF(.text.rgf_reg_889000) <= 92, "блок rgf_reg_889000 не влезает в отведённые ему 92 байт")
  .text.uc_hwd_rfc_write_core 0x00927564 : { KEEP(*(.text.uc_hwd_rfc_write_core)) }
  ASSERT(SIZEOF(.text.uc_hwd_rfc_write_core) <= 960, "блок uc_hwd_rfc_write_core не влезает в отведённые ему 960 байт")
  .text.stub_ret_927924 0x00927924 : { KEEP(*(.text.stub_ret_927924)) }
  ASSERT(SIZEOF(.text.stub_ret_927924) <= 8, "блок stub_ret_927924 не влезает в отведённые ему 8 байт")
  .text.set_reg_88000c 0x0092792c : { KEEP(*(.text.set_reg_88000c)) }
  ASSERT(SIZEOF(.text.set_reg_88000c) <= 12, "блок set_reg_88000c не влезает в отведённые ему 12 байт")
  .text.set_reg_880010 0x00927938 : { KEEP(*(.text.set_reg_880010)) }
  ASSERT(SIZEOF(.text.set_reg_880010) <= 12, "блок set_reg_880010 не влезает в отведённые ему 12 байт")
  .text.hw_modes_mac__switch_core 0x00927944 : { KEEP(*(.text.hw_modes_mac__switch_core)) }
  ASSERT(SIZEOF(.text.hw_modes_mac__switch_core) <= 540, "блок hw_modes_mac__switch_core не влезает в отведённые ему 540 байт")
  .text.dma_mac_setup_step 0x00927b60 : { KEEP(*(.text.dma_mac_setup_step)) }
  ASSERT(SIZEOF(.text.dma_mac_setup_step) <= 448, "блок dma_mac_setup_step не влезает в отведённые ему 448 байт")
  .text.dma_mac_setup_wrap 0x00927d20 : { KEEP(*(.text.dma_mac_setup_wrap)) }
  ASSERT(SIZEOF(.text.dma_mac_setup_wrap) <= 176, "блок dma_mac_setup_wrap не влезает в отведённые ему 176 байт")
  .text.dma_mac_substep 0x00927dd0 : { KEEP(*(.text.dma_mac_substep)) }
  ASSERT(SIZEOF(.text.dma_mac_substep) <= 156, "блок dma_mac_substep не влезает в отведённые ему 156 байт")
  .text.uc_mailbox__next_slot 0x00927e6c : { KEEP(*(.text.uc_mailbox__next_slot)) }
  ASSERT(SIZEOF(.text.uc_mailbox__next_slot) <= 84, "блок uc_mailbox__next_slot не влезает в отведённые ему 84 байт")
  .text.tail_bi_ap_mon__init 0x00927ec0 : { KEEP(*(.text.tail_bi_ap_mon__init)) }
  ASSERT(SIZEOF(.text.tail_bi_ap_mon__init) <= 12, "блок tail_bi_ap_mon__init не влезает в отведённые ему 12 байт")
  .text.bi_mode__build_schedule 0x00927ecc : { KEEP(*(.text.bi_mode__build_schedule)) }
  ASSERT(SIZEOF(.text.bi_mode__build_schedule) <= 52, "блок bi_mode__build_schedule не влезает в отведённые ему 52 байт")
  .text.bi_build_schedule_tables 0x00927f00 : { KEEP(*(.text.bi_build_schedule_tables)) }
  ASSERT(SIZEOF(.text.bi_build_schedule_tables) <= 408, "блок bi_build_schedule_tables не влезает в отведённые ему 408 байт")
  .text.uc_ring__init_desc 0x00928098 : { KEEP(*(.text.uc_ring__init_desc)) }
  ASSERT(SIZEOF(.text.uc_ring__init_desc) <= 28, "блок uc_ring__init_desc не влезает в отведённые ему 28 байт")
  .text.rw_g_801e82 0x009280b4 : { KEEP(*(.text.rw_g_801e82)) }
  ASSERT(SIZEOF(.text.rw_g_801e82) <= 16, "блок rw_g_801e82 не влезает в отведённые ему 16 байт")
  .text.bi_ctx__reset 0x009280c4 : { KEEP(*(.text.bi_ctx__reset)) }
  ASSERT(SIZEOF(.text.bi_ctx__reset) <= 108, "блок bi_ctx__reset не влезает в отведённые ему 108 байт")
  .text.bi_ap_mon__init 0x00928130 : { KEEP(*(.text.bi_ap_mon__init)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__init) <= 68, "блок bi_ap_mon__init не влезает в отведённые ему 68 байт")
  .text.uc_basic_sm__setup 0x00928174 : { KEEP(*(.text.uc_basic_sm__setup)) }
  ASSERT(SIZEOF(.text.uc_basic_sm__setup) <= 32, "блок uc_basic_sm__setup не влезает в отведённые ему 32 байт")
  .text.bi_mode__set_1000_units165 0x00928194 : { KEEP(*(.text.bi_mode__set_1000_units165)) }
  ASSERT(SIZEOF(.text.bi_mode__set_1000_units165) <= 12, "блок bi_mode__set_1000_units165 не влезает в отведённые ему 12 байт")
  .text.bf_sm__state_action 0x009281a0 : { KEEP(*(.text.bf_sm__state_action)) }
  ASSERT(SIZEOF(.text.bf_sm__state_action) <= 108, "блок bf_sm__state_action не влезает в отведённые ему 108 байт")
  .text.bi_cfg__fill_slot_desc 0x0092820c : { KEEP(*(.text.bi_cfg__fill_slot_desc)) }
  ASSERT(SIZEOF(.text.bi_cfg__fill_slot_desc) <= 32, "блок bi_cfg__fill_slot_desc не влезает в отведённые ему 32 байт")
  .text.brp__reset_db 0x0092822c : { KEEP(*(.text.brp__reset_db)) }
  ASSERT(SIZEOF(.text.brp__reset_db) <= 132, "блок brp__reset_db не влезает в отведённые ему 132 байт")
  .text.brp__reset_db_b 0x009282b0 : { KEEP(*(.text.brp__reset_db_b)) }
  ASSERT(SIZEOF(.text.brp__reset_db_b) <= 88, "блок brp__reset_db_b не влезает в отведённые ему 88 байт")
  .text.mac__program_qset_slots 0x00928308 : { KEEP(*(.text.mac__program_qset_slots)) }
  ASSERT(SIZEOF(.text.mac__program_qset_slots) <= 100, "блок mac__program_qset_slots не влезает в отведённые ему 100 байт")
  .text.set_g_801b18_x4 0x0092836c : { KEEP(*(.text.set_g_801b18_x4)) }
  ASSERT(SIZEOF(.text.set_g_801b18_x4) <= 20, "блок set_g_801b18_x4 не влезает в отведённые ему 20 байт")
  .text.bf_sm__reset_slot_table 0x00928380 : { KEEP(*(.text.bf_sm__reset_slot_table)) }
  ASSERT(SIZEOF(.text.bf_sm__reset_slot_table) <= 56, "блок bf_sm__reset_slot_table не влезает в отведённые ему 56 байт")
  .text.ucode_cmd__reset_queue_state 0x009283b8 : { KEEP(*(.text.ucode_cmd__reset_queue_state)) }
  ASSERT(SIZEOF(.text.ucode_cmd__reset_queue_state) <= 16, "блок ucode_cmd__reset_queue_state не влезает в отведённые ему 16 байт")
  .text.bf_state__set 0x009283c8 : { KEEP(*(.text.bf_state__set)) }
  ASSERT(SIZEOF(.text.bf_state__set) <= 20, "блок bf_state__set не влезает в отведённые ему 20 байт")
  .text.bf__abort_unexpected 0x009283dc : { KEEP(*(.text.bf__abort_unexpected)) }
  ASSERT(SIZEOF(.text.bf__abort_unexpected) <= 344, "блок bf__abort_unexpected не влезает в отведённые ему 344 байт")
  .text.bi_manager__l1_rx_entry 0x00928534 : { KEEP(*(.text.bi_manager__l1_rx_entry)) }
  ASSERT(SIZEOF(.text.bi_manager__l1_rx_entry) <= 84, "блок bi_manager__l1_rx_entry не влезает в отведённые ему 84 байт")
  .text.bi_manager__start_tx_or_initiator 0x00928588 : { KEEP(*(.text.bi_manager__start_tx_or_initiator)) }
  ASSERT(SIZEOF(.text.bi_manager__start_tx_or_initiator) <= 76, "блок bi_manager__start_tx_or_initiator не влезает в отведённые ему 76 байт")
  .text.bi_manager__rx_bi_flow 0x009285d4 : { KEEP(*(.text.bi_manager__rx_bi_flow)) }
  ASSERT(SIZEOF(.text.bi_manager__rx_bi_flow) <= 348, "блок bi_manager__rx_bi_flow не влезает в отведённые ему 348 байт")
  .text.bi_manager__run_rx_flow_by_kind 0x00928730 : { KEEP(*(.text.bi_manager__run_rx_flow_by_kind)) }
  ASSERT(SIZEOF(.text.bi_manager__run_rx_flow_by_kind) <= 104, "блок bi_manager__run_rx_flow_by_kind не влезает в отведённые ему 104 байт")
  .text.bi_manager__rx_flow_kind0 0x00928798 : { KEEP(*(.text.bi_manager__rx_flow_kind0)) }
  ASSERT(SIZEOF(.text.bi_manager__rx_flow_kind0) <= 4, "блок bi_manager__rx_flow_kind0 не влезает в отведённые ему 4 байт")
  .text.bi_manager__rx_flow_kind1 0x0092879c : { KEEP(*(.text.bi_manager__rx_flow_kind1)) }
  ASSERT(SIZEOF(.text.bi_manager__rx_flow_kind1) <= 76, "блок bi_manager__rx_flow_kind1 не влезает в отведённые ему 76 байт")
  .text.bi_manager__rx_flow_kind2 0x009287e8 : { KEEP(*(.text.bi_manager__rx_flow_kind2)) }
  ASSERT(SIZEOF(.text.bi_manager__rx_flow_kind2) <= 4, "блок bi_manager__rx_flow_kind2 не влезает в отведённые ему 4 байт")
  .text.basic_sm__dispatch_loop 0x009287ec : { KEEP(*(.text.basic_sm__dispatch_loop)) }
  ASSERT(SIZEOF(.text.basic_sm__dispatch_loop) <= 268, "блок basic_sm__dispatch_loop не влезает в отведённые ему 268 байт")
  .text.basic_sm__step_once 0x009288f8 : { KEEP(*(.text.basic_sm__step_once)) }
  ASSERT(SIZEOF(.text.basic_sm__step_once) <= 80, "блок basic_sm__step_once не влезает в отведённые ему 80 байт")
  .text.bi_manager__l1_entry_b 0x00928948 : { KEEP(*(.text.bi_manager__l1_entry_b)) }
  ASSERT(SIZEOF(.text.bi_manager__l1_entry_b) <= 84, "блок bi_manager__l1_entry_b не влезает в отведённые ему 84 байт")
  .text.tail_ps_awake_peer__build_evt 0x0092899c : { KEEP(*(.text.tail_ps_awake_peer__build_evt)) }
  ASSERT(SIZEOF(.text.tail_ps_awake_peer__build_evt) <= 4, "блок tail_ps_awake_peer__build_evt не влезает в отведённые ему 4 байт")
  .text.bi_manager__on_aw 0x009289a0 : { KEEP(*(.text.bi_manager__on_aw)) }
  ASSERT(SIZEOF(.text.bi_manager__on_aw) <= 68, "блок bi_manager__on_aw не влезает в отведённые ему 68 байт")
  .text.bi_manager__kind_switch 0x009289e4 : { KEEP(*(.text.bi_manager__kind_switch)) }
  ASSERT(SIZEOF(.text.bi_manager__kind_switch) <= 104, "блок bi_manager__kind_switch не влезает в отведённые ему 104 байт")
  .text.epi_928a4c 0x00928a4c : { KEEP(*(.text.epi_928a4c)) }
  ASSERT(SIZEOF(.text.epi_928a4c) <= 12, "блок epi_928a4c не влезает в отведённые ему 12 байт")
  .text.bi_manager__on_dti 0x00928a58 : { KEEP(*(.text.bi_manager__on_dti)) }
  ASSERT(SIZEOF(.text.bi_manager__on_dti) <= 64, "блок bi_manager__on_dti не влезает в отведённые ему 64 байт")
  .text.tail_bi_manager__on_dti 0x00928a98 : { KEEP(*(.text.tail_bi_manager__on_dti)) }
  ASSERT(SIZEOF(.text.tail_bi_manager__on_dti) <= 4, "блок tail_bi_manager__on_dti не влезает в отведённые ему 4 байт")
  .text.uc_isr_l1_task3 0x00928a9c : { KEEP(*(.text.uc_isr_l1_task3)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task3) <= 72, "блок uc_isr_l1_task3 не влезает в отведённые ему 72 байт")
  .text.uc_isr_l1_task3__body 0x00928ae4 : { KEEP(*(.text.uc_isr_l1_task3__body)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task3__body) <= 80, "блок uc_isr_l1_task3__body не влезает в отведённые ему 80 байт")
  .text.uc_isr_l1_task3__tail 0x00928b34 : { KEEP(*(.text.uc_isr_l1_task3__tail)) }
  ASSERT(SIZEOF(.text.uc_isr_l1_task3__tail) <= 4, "блок uc_isr_l1_task3__tail не влезает в отведённые ему 4 байт")
  .text.uc_isr_l2_task3 0x00928b38 : { KEEP(*(.text.uc_isr_l2_task3)) }
  ASSERT(SIZEOF(.text.uc_isr_l2_task3) <= 156, "блок uc_isr_l2_task3 не влезает в отведённые ему 156 байт")
  .text.rx_funcs__set_rx_off 0x00928bd4 : { KEEP(*(.text.rx_funcs__set_rx_off)) }
  ASSERT(SIZEOF(.text.rx_funcs__set_rx_off) <= 196, "блок rx_funcs__set_rx_off не влезает в отведённые ему 196 байт")
  .text.set_bit_80067c 0x00928c98 : { KEEP(*(.text.set_bit_80067c)) }
  ASSERT(SIZEOF(.text.set_bit_80067c) <= 16, "блок set_bit_80067c не влезает в отведённые ему 16 байт")
  .text.set_g_80067c 0x00928ca8 : { KEEP(*(.text.set_g_80067c)) }
  ASSERT(SIZEOF(.text.set_g_80067c) <= 12, "блок set_g_80067c не влезает в отведённые ему 12 байт")
  .text.mid_vring_mask_update 0x00928cb4 : { KEEP(*(.text.mid_vring_mask_update)) }
  ASSERT(SIZEOF(.text.mid_vring_mask_update) <= 116, "блок mid_vring_mask_update не влезает в отведённые ему 116 байт")
  .text.uc_res_vote__acquire 0x00928d28 : { KEEP(*(.text.uc_res_vote__acquire)) }
  ASSERT(SIZEOF(.text.uc_res_vote__acquire) <= 80, "блок uc_res_vote__acquire не влезает в отведённые ему 80 байт")
  .text.set_reg_886f00_928d78 0x00928d78 : { KEEP(*(.text.set_reg_886f00_928d78)) }
  ASSERT(SIZEOF(.text.set_reg_886f00_928d78) <= 28, "блок set_reg_886f00_928d78 не влезает в отведённые ему 28 байт")
  .text.rf_sector__clear_sta_bit 0x00928d94 : { KEEP(*(.text.rf_sector__clear_sta_bit)) }
  ASSERT(SIZEOF(.text.rf_sector__clear_sta_bit) <= 96, "блок rf_sector__clear_sta_bit не влезает в отведённые ему 96 байт")
  .text.uc_res_vote__release 0x00928df4 : { KEEP(*(.text.uc_res_vote__release)) }
  ASSERT(SIZEOF(.text.uc_res_vote__release) <= 68, "блок uc_res_vote__release не влезает в отведённые ему 68 байт")
  .text.mac__enable_qset_bit7 0x00928e38 : { KEEP(*(.text.mac__enable_qset_bit7)) }
  ASSERT(SIZEOF(.text.mac__enable_qset_bit7) <= 36, "блок mac__enable_qset_bit7 не влезает в отведённые ему 36 байт")
  .text.get_g_800674 0x00928e5c : { KEEP(*(.text.get_g_800674)) }
  ASSERT(SIZEOF(.text.get_g_800674) <= 12, "блок get_g_800674 не влезает в отведённые ему 12 байт")
  .text.internal_tx__pending_sm 0x00928e68 : { KEEP(*(.text.internal_tx__pending_sm)) }
  ASSERT(SIZEOF(.text.internal_tx__pending_sm) <= 196, "блок internal_tx__pending_sm не влезает в отведённые ему 196 байт")
  .text.uc_res_886f00__acquire 0x00928f2c : { KEEP(*(.text.uc_res_886f00__acquire)) }
  ASSERT(SIZEOF(.text.uc_res_886f00__acquire) <= 64, "блок uc_res_886f00__acquire не влезает в отведённые ему 64 байт")
  .text.uc_pending__clear_bit 0x00928f6c : { KEEP(*(.text.uc_pending__clear_bit)) }
  ASSERT(SIZEOF(.text.uc_pending__clear_bit) <= 52, "блок uc_pending__clear_bit не влезает в отведённые ему 52 байт")
  .text.get_g_804010 0x00928fa0 : { KEEP(*(.text.get_g_804010)) }
  ASSERT(SIZEOF(.text.get_g_804010) <= 28, "блок get_g_804010 не влезает в отведённые ему 28 байт")
  .text.frag_928fbc 0x00928fbc : { KEEP(*(.text.frag_928fbc)) }
  ASSERT(SIZEOF(.text.frag_928fbc) <= 4, "блок frag_928fbc не влезает в отведённые ему 4 байт")
  .text.uc_indirect_is_zero 0x00928fc0 : { KEEP(*(.text.uc_indirect_is_zero)) }
  ASSERT(SIZEOF(.text.uc_indirect_is_zero) <= 16, "блок uc_indirect_is_zero не влезает в отведённые ему 16 байт")
  .text.internal_tx__peer_pending 0x00928fd0 : { KEEP(*(.text.internal_tx__peer_pending)) }
  ASSERT(SIZEOF(.text.internal_tx__peer_pending) <= 52, "блок internal_tx__peer_pending не влезает в отведённые ему 52 байт")
  .text.mailbox__free_space 0x00929004 : { KEEP(*(.text.mailbox__free_space)) }
  ASSERT(SIZEOF(.text.mailbox__free_space) <= 28, "блок mailbox__free_space не влезает в отведённые ему 28 байт")
  .text.bti_bi2__gp0_end_flag 0x00929020 : { KEEP(*(.text.bti_bi2__gp0_end_flag)) }
  ASSERT(SIZEOF(.text.bti_bi2__gp0_end_flag) <= 12, "блок bti_bi2__gp0_end_flag не влезает в отведённые ему 12 байт")
  .text.direct_tx__build_desc 0x0092902c : { KEEP(*(.text.direct_tx__build_desc)) }
  ASSERT(SIZEOF(.text.direct_tx__build_desc) <= 136, "блок direct_tx__build_desc не влезает в отведённые ему 136 байт")
  .text.mac__set_channel_word 0x009290b4 : { KEEP(*(.text.mac__set_channel_word)) }
  ASSERT(SIZEOF(.text.mac__set_channel_word) <= 88, "блок mac__set_channel_word не влезает в отведённые ему 88 байт")
  .text.mac_mode_kick 0x0092910c : { KEEP(*(.text.mac_mode_kick)) }
  ASSERT(SIZEOF(.text.mac_mode_kick) <= 132, "блок mac_mode_kick не влезает в отведённые ему 132 байт")
  .text.mac_mode_program_c 0x00929190 : { KEEP(*(.text.mac_mode_program_c)) }
  ASSERT(SIZEOF(.text.mac_mode_program_c) <= 760, "блок mac_mode_program_c не влезает в отведённые ему 760 байт")
  .text.direct_tx_step 0x00929488 : { KEEP(*(.text.direct_tx_step)) }
  ASSERT(SIZEOF(.text.direct_tx_step) <= 452, "блок direct_tx_step не влезает в отведённые ему 452 байт")
  .text.mac_mode__wait_ppdu_and_kick_e 0x0092964c : { KEEP(*(.text.mac_mode__wait_ppdu_and_kick_e)) }
  ASSERT(SIZEOF(.text.mac_mode__wait_ppdu_and_kick_e) <= 116, "блок mac_mode__wait_ppdu_and_kick_e не влезает в отведённые ему 116 байт")
  .text.ucode_cmd_keep_alive_trigger 0x009296c0 : { KEEP(*(.text.ucode_cmd_keep_alive_trigger)) }
  ASSERT(SIZEOF(.text.ucode_cmd_keep_alive_trigger) <= 8, "блок ucode_cmd_keep_alive_trigger не влезает в отведённые ему 8 байт")
  .text.mac__program_rf_mode 0x009296c8 : { KEEP(*(.text.mac__program_rf_mode)) }
  ASSERT(SIZEOF(.text.mac__program_rf_mode) <= 112, "блок mac__program_rf_mode не влезает в отведённые ему 112 байт")
  .text.l1_task__entry 0x00929738 : { KEEP(*(.text.l1_task__entry)) }
  ASSERT(SIZEOF(.text.l1_task__entry) <= 572, "блок l1_task__entry не влезает в отведённые ему 572 байт")
  .text.l2_task__report_error_bits 0x00929974 : { KEEP(*(.text.l2_task__report_error_bits)) }
  ASSERT(SIZEOF(.text.l2_task__report_error_bits) <= 600, "блок l2_task__report_error_bits не влезает в отведённые ему 600 байт")
  .text.l2_task__kick_mac_events 0x00929bcc : { KEEP(*(.text.l2_task__kick_mac_events)) }
  ASSERT(SIZEOF(.text.l2_task__kick_mac_events) <= 48, "блок l2_task__kick_mac_events не влезает в отведённые ему 48 байт")
  .text.l2_task__run 0x00929bfc : { KEEP(*(.text.l2_task__run)) }
  ASSERT(SIZEOF(.text.l2_task__run) <= 712, "блок l2_task__run не влезает в отведённые ему 712 байт")
  .text.l2_task__entry 0x00929ec4 : { KEEP(*(.text.l2_task__entry)) }
  ASSERT(SIZEOF(.text.l2_task__entry) <= 36, "блок l2_task__entry не влезает в отведённые ему 36 байт")
  .text.bit_scan_msb 0x00929ee8 : { KEEP(*(.text.bit_scan_msb)) }
  ASSERT(SIZEOF(.text.bit_scan_msb) <= 108, "блок bit_scan_msb не влезает в отведённые ему 108 байт")
  .text.mailbox_debug_dump__2 0x00929f54 : { KEEP(*(.text.mailbox_debug_dump__2)) }
  ASSERT(SIZEOF(.text.mailbox_debug_dump__2) <= 368, "блок mailbox_debug_dump__2 не влезает в отведённые ему 368 байт")
  .text.rx_flow__phy_override 0x0092a0c4 : { KEEP(*(.text.rx_flow__phy_override)) }
  ASSERT(SIZEOF(.text.rx_flow__phy_override) <= 416, "блок rx_flow__phy_override не влезает в отведённые ему 416 байт")
  .text.memset_uc 0x0092a264 : { KEEP(*(.text.memset_uc)) }
  ASSERT(SIZEOF(.text.memset_uc) <= 76, "блок memset_uc не влезает в отведённые ему 76 байт")
  .text.uc_mailbox__dispatch_one 0x0092a2b0 : { KEEP(*(.text.uc_mailbox__dispatch_one)) }
  ASSERT(SIZEOF(.text.uc_mailbox__dispatch_one) <= 36, "блок uc_mailbox__dispatch_one не влезает в отведённые ему 36 байт")
  .text.mac__program_tx_beacon 0x0092a2d4 : { KEEP(*(.text.mac__program_tx_beacon)) }
  ASSERT(SIZEOF(.text.mac__program_tx_beacon) <= 68, "блок mac__program_tx_beacon не влезает в отведённые ему 68 байт")
  .text.mac__program_tx_with_rate 0x0092a318 : { KEEP(*(.text.mac__program_tx_with_rate)) }
  ASSERT(SIZEOF(.text.mac__program_tx_with_rate) <= 84, "блок mac__program_tx_with_rate не влезает в отведённые ему 84 байт")
  .text.mac__program_tx_with_qid 0x0092a36c : { KEEP(*(.text.mac__program_tx_with_qid)) }
  ASSERT(SIZEOF(.text.mac__program_tx_with_qid) <= 84, "блок mac__program_tx_with_qid не влезает в отведённые ему 84 байт")
  .text.mac__program_tx_common 0x0092a3c0 : { KEEP(*(.text.mac__program_tx_common)) }
  ASSERT(SIZEOF(.text.mac__program_tx_common) <= 68, "блок mac__program_tx_common не влезает в отведённые ему 68 байт")
  .text.mtp_service__dispatch 0x0092a404 : { KEEP(*(.text.mtp_service__dispatch)) }
  ASSERT(SIZEOF(.text.mtp_service__dispatch) <= 236, "блок mtp_service__dispatch не влезает в отведённые ему 236 байт")
  .text.mac__program_tx_result_ctx 0x0092a4f0 : { KEEP(*(.text.mac__program_tx_result_ctx)) }
  ASSERT(SIZEOF(.text.mac__program_tx_result_ctx) <= 104, "блок mac__program_tx_result_ctx не влезает в отведённые ему 104 байт")
  .text.grant_detect_step 0x0092a558 : { KEEP(*(.text.grant_detect_step)) }
  ASSERT(SIZEOF(.text.grant_detect_step) <= 148, "блок grant_detect_step не влезает в отведённые ему 148 байт")
  .text.rw_g_800994 0x0092a5ec : { KEEP(*(.text.rw_g_800994)) }
  ASSERT(SIZEOF(.text.rw_g_800994) <= 28, "блок rw_g_800994 не влезает в отведённые ему 28 байт")
  .text.bi__remaining_time_us 0x0092a608 : { KEEP(*(.text.bi__remaining_time_us)) }
  ASSERT(SIZEOF(.text.bi__remaining_time_us) <= 40, "блок bi__remaining_time_us не влезает в отведённые ему 40 байт")
  .text.pm__event_mask_save_all_on 0x0092a630 : { KEEP(*(.text.pm__event_mask_save_all_on)) }
  ASSERT(SIZEOF(.text.pm__event_mask_save_all_on) <= 80, "блок pm__event_mask_save_all_on не влезает в отведённые ему 80 байт")
  .text.set_g_800994 0x0092a680 : { KEEP(*(.text.set_g_800994)) }
  ASSERT(SIZEOF(.text.set_g_800994) <= 28, "блок set_g_800994 не влезает в отведённые ему 28 байт")
  .text.pm__event_mask_restore 0x0092a69c : { KEEP(*(.text.pm__event_mask_restore)) }
  ASSERT(SIZEOF(.text.pm__event_mask_restore) <= 88, "блок pm__event_mask_restore не влезает в отведённые ему 88 байт")
  .text.nav_db__update 0x0092a6f4 : { KEEP(*(.text.nav_db__update)) }
  ASSERT(SIZEOF(.text.nav_db__update) <= 560, "блок nav_db__update не влезает в отведённые ему 560 байт")
  .text.bf_sm_step 0x0092a924 : { KEEP(*(.text.bf_sm_step)) }
  ASSERT(SIZEOF(.text.bf_sm_step) <= 208, "блок bf_sm_step не влезает в отведённые ему 208 байт")
  .text.mac_mode__switch_core_and_rf 0x0092a9f4 : { KEEP(*(.text.mac_mode__switch_core_and_rf)) }
  ASSERT(SIZEOF(.text.mac_mode__switch_core_and_rf) <= 136, "блок mac_mode__switch_core_and_rf не влезает в отведённые ему 136 байт")
  .text.rx_funcs__on_rx_type_0x14 0x0092aa7c : { KEEP(*(.text.rx_funcs__on_rx_type_0x14)) }
  ASSERT(SIZEOF(.text.rx_funcs__on_rx_type_0x14) <= 160, "блок rx_funcs__on_rx_type_0x14 не влезает в отведённые ему 160 байт")
  .text.brp__build_tx_params 0x0092ab1c : { KEEP(*(.text.brp__build_tx_params)) }
  ASSERT(SIZEOF(.text.brp__build_tx_params) <= 144, "блок brp__build_tx_params не влезает в отведённые ему 144 байт")
  .text.mac_mode__wait_ppdu_and_kick_b 0x0092abac : { KEEP(*(.text.mac_mode__wait_ppdu_and_kick_b)) }
  ASSERT(SIZEOF(.text.mac_mode__wait_ppdu_and_kick_b) <= 92, "блок mac_mode__wait_ppdu_and_kick_b не влезает в отведённые ему 92 байт")
  .text.mac_mode__wait_ppdu_and_kick_d 0x0092ac08 : { KEEP(*(.text.mac_mode__wait_ppdu_and_kick_d)) }
  ASSERT(SIZEOF(.text.mac_mode__wait_ppdu_and_kick_d) <= 88, "блок mac_mode__wait_ppdu_and_kick_d не влезает в отведённые ему 88 байт")
  .text.perform_bti_pm_cfg 0x0092ac60 : { KEEP(*(.text.perform_bti_pm_cfg)) }
  ASSERT(SIZEOF(.text.perform_bti_pm_cfg) <= 312, "блок perform_bti_pm_cfg не влезает в отведённые ему 312 байт")
  .text.power_manager__decide_shallow_sleep 0x0092ad98 : { KEEP(*(.text.power_manager__decide_shallow_sleep)) }
  ASSERT(SIZEOF(.text.power_manager__decide_shallow_sleep) <= 436, "блок power_manager__decide_shallow_sleep не влезает в отведённые ему 436 байт")
  .text.perform_shallow_sleep 0x0092af4c : { KEEP(*(.text.perform_shallow_sleep)) }
  ASSERT(SIZEOF(.text.perform_shallow_sleep) <= 592, "блок perform_shallow_sleep не влезает в отведённые ему 592 байт")
  .text.ucode_cmd_phy_ina_det_cfg 0x0092b19c : { KEEP(*(.text.ucode_cmd_phy_ina_det_cfg)) }
  ASSERT(SIZEOF(.text.ucode_cmd_phy_ina_det_cfg) <= 16, "блок ucode_cmd_phy_ina_det_cfg не влезает в отведённые ему 16 байт")
  .text.get_g_800724 0x0092b1ac : { KEEP(*(.text.get_g_800724)) }
  ASSERT(SIZEOF(.text.get_g_800724) <= 28, "блок get_g_800724 не влезает в отведённые ему 28 байт")
  .text.power_manager__scale_counters_ms 0x0092b1c8 : { KEEP(*(.text.power_manager__scale_counters_ms)) }
  ASSERT(SIZEOF(.text.power_manager__scale_counters_ms) <= 40, "блок power_manager__scale_counters_ms не влезает в отведённые ему 40 байт")
  .text.power_manager__update_deltas 0x0092b1f0 : { KEEP(*(.text.power_manager__update_deltas)) }
  ASSERT(SIZEOF(.text.power_manager__update_deltas) <= 28, "блок power_manager__update_deltas не влезает в отведённые ему 28 байт")
  .text.power_manager__snapshot_marks 0x0092b20c : { KEEP(*(.text.power_manager__snapshot_marks)) }
  ASSERT(SIZEOF(.text.power_manager__snapshot_marks) <= 20, "блок power_manager__snapshot_marks не влезает в отведённые ему 20 байт")
  .text.power_manager__tick_if_elapsed 0x0092b220 : { KEEP(*(.text.power_manager__tick_if_elapsed)) }
  ASSERT(SIZEOF(.text.power_manager__tick_if_elapsed) <= 48, "блок power_manager__tick_if_elapsed не влезает в отведённые ему 48 байт")
  .text.ucode_cmd_0x1b_handler 0x0092b250 : { KEEP(*(.text.ucode_cmd_0x1b_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x1b_handler) <= 44, "блок ucode_cmd_0x1b_handler не влезает в отведённые ему 44 байт")
  .text.cf_end__pulse_883150 0x0092b27c : { KEEP(*(.text.cf_end__pulse_883150)) }
  ASSERT(SIZEOF(.text.cf_end__pulse_883150) <= 24, "блок cf_end__pulse_883150 не влезает в отведённые ему 24 байт")
  .text.list_800b90__insert_sorted 0x0092b294 : { KEEP(*(.text.list_800b90__insert_sorted)) }
  ASSERT(SIZEOF(.text.list_800b90__insert_sorted) <= 64, "блок list_800b90__insert_sorted не влезает в отведённые ему 64 байт")
  .text.get_g_800ebc 0x0092b2d4 : { KEEP(*(.text.get_g_800ebc)) }
  ASSERT(SIZEOF(.text.get_g_800ebc) <= 12, "блок get_g_800ebc не влезает в отведённые ему 12 байт")
  .text.bi_ap_mon__trigger_tail 0x0092b2e0 : { KEEP(*(.text.bi_ap_mon__trigger_tail)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__trigger_tail) <= 12, "блок bi_ap_mon__trigger_tail не влезает в отведённые ему 12 байт")
  .text.tail_bi_manager__enter_dti 0x0092b2ec : { KEEP(*(.text.tail_bi_manager__enter_dti)) }
  ASSERT(SIZEOF(.text.tail_bi_manager__enter_dti) <= 4, "блок tail_bi_manager__enter_dti не влезает в отведённые ему 4 байт")
  .text.bi_manager__assert_line42 0x0092b2f0 : { KEEP(*(.text.bi_manager__assert_line42)) }
  ASSERT(SIZEOF(.text.bi_manager__assert_line42) <= 20, "блок bi_manager__assert_line42 не влезает в отведённые ему 20 байт")
  .text.stub_ret_92b304 0x0092b304 : { KEEP(*(.text.stub_ret_92b304)) }
  ASSERT(SIZEOF(.text.stub_ret_92b304) <= 4, "блок stub_ret_92b304 не влезает в отведённые ему 4 байт")
  .text.psc_pending_agreement_cmd 0x0092b308 : { KEEP(*(.text.psc_pending_agreement_cmd)) }
  ASSERT(SIZEOF(.text.psc_pending_agreement_cmd) <= 220, "блок psc_pending_agreement_cmd не влезает в отведённые ему 220 байт")
  .text.brp__count_active_sectors 0x0092b3e4 : { KEEP(*(.text.brp__count_active_sectors)) }
  ASSERT(SIZEOF(.text.brp__count_active_sectors) <= 96, "блок brp__count_active_sectors не влезает в отведённые ему 96 байт")
  .text.mac_mode__send_direct_frame 0x0092b444 : { KEEP(*(.text.mac_mode__send_direct_frame)) }
  ASSERT(SIZEOF(.text.mac_mode__send_direct_frame) <= 112, "блок mac_mode__send_direct_frame не влезает в отведённые ему 112 байт")
  .text.queue_sel__get_qset4 0x0092b4b4 : { KEEP(*(.text.queue_sel__get_qset4)) }
  ASSERT(SIZEOF(.text.queue_sel__get_qset4) <= 96, "блок queue_sel__get_qset4 не влезает в отведённые ему 96 байт")
  .text.mac__reset_event_engines 0x0092b514 : { KEEP(*(.text.mac__reset_event_engines)) }
  ASSERT(SIZEOF(.text.mac__reset_event_engines) <= 120, "блок mac__reset_event_engines не влезает в отведённые ему 120 байт")
  .text.bf_gpc__program_mac_by_mode_b 0x0092b58c : { KEEP(*(.text.bf_gpc__program_mac_by_mode_b)) }
  ASSERT(SIZEOF(.text.bf_gpc__program_mac_by_mode_b) <= 176, "блок bf_gpc__program_mac_by_mode_b не влезает в отведённые ему 176 байт")
  .text.bf__trigger_for_mid 0x0092b63c : { KEEP(*(.text.bf__trigger_for_mid)) }
  ASSERT(SIZEOF(.text.bf__trigger_for_mid) <= 44, "блок bf__trigger_for_mid не влезает в отведённые ему 44 байт")
  .text.set_g_800fa8_minus20 0x0092b668 : { KEEP(*(.text.set_g_800fa8_minus20)) }
  ASSERT(SIZEOF(.text.set_g_800fa8_minus20) <= 16, "блок set_g_800fa8_minus20 не влезает в отведённые ему 16 байт")
  .text.bf__clear_sta_bit_state34 0x0092b678 : { KEEP(*(.text.bf__clear_sta_bit_state34)) }
  ASSERT(SIZEOF(.text.bf__clear_sta_bit_state34) <= 36, "блок bf__clear_sta_bit_state34 не влезает в отведённые ему 36 байт")
  .text.rw_g_801038 0x0092b69c : { KEEP(*(.text.rw_g_801038)) }
  ASSERT(SIZEOF(.text.rw_g_801038) <= 12, "блок rw_g_801038 не влезает в отведённые ему 12 байт")
  .text.mac__program_886e0c_20b 0x0092b6a8 : { KEEP(*(.text.mac__program_886e0c_20b)) }
  ASSERT(SIZEOF(.text.mac__program_886e0c_20b) <= 284, "блок mac__program_886e0c_20b не влезает в отведённые ему 284 байт")
  .text.rx__mac_prepare 0x0092b7c4 : { KEEP(*(.text.rx__mac_prepare)) }
  ASSERT(SIZEOF(.text.rx__mac_prepare) <= 52, "блок rx__mac_prepare не влезает в отведённые ему 52 байт")
  .text.uc_sysassert__emit_mac_trace 0x0092b7f8 : { KEEP(*(.text.uc_sysassert__emit_mac_trace)) }
  ASSERT(SIZEOF(.text.uc_sysassert__emit_mac_trace) <= 48, "блок uc_sysassert__emit_mac_trace не влезает в отведённые ему 48 байт")
  .text.ucode_cmd__apply_mac_cfg 0x0092b828 : { KEEP(*(.text.ucode_cmd__apply_mac_cfg)) }
  ASSERT(SIZEOF(.text.ucode_cmd__apply_mac_cfg) <= 32, "блок ucode_cmd__apply_mac_cfg не влезает в отведённые ему 32 байт")
  .text.mac_mode__switch_after_ppdu 0x0092b848 : { KEEP(*(.text.mac_mode__switch_after_ppdu)) }
  ASSERT(SIZEOF(.text.mac_mode__switch_after_ppdu) <= 192, "блок mac_mode__switch_after_ppdu не влезает в отведённые ему 192 байт")
  .text.mac__replicate_bit_mask 0x0092b908 : { KEEP(*(.text.mac__replicate_bit_mask)) }
  ASSERT(SIZEOF(.text.mac__replicate_bit_mask) <= 44, "блок mac__replicate_bit_mask не влезает в отведённые ему 44 байт")
  .text.mac__set_rf_chain_state 0x0092b934 : { KEEP(*(.text.mac__set_rf_chain_state)) }
  ASSERT(SIZEOF(.text.mac__set_rf_chain_state) <= 132, "блок mac__set_rf_chain_state не влезает в отведённые ему 132 байт")
  .text.set_g_8005bc_x2 0x0092b9b8 : { KEEP(*(.text.set_g_8005bc_x2)) }
  ASSERT(SIZEOF(.text.set_g_8005bc_x2) <= 24, "блок set_g_8005bc_x2 не влезает в отведённые ему 24 байт")
  .text.rfc_ctrl__switch 0x0092b9d0 : { KEEP(*(.text.rfc_ctrl__switch)) }
  ASSERT(SIZEOF(.text.rfc_ctrl__switch) <= 252, "блок rfc_ctrl__switch не влезает в отведённые ему 252 байт")
  .text.mac__build_qset_mask 0x0092bacc : { KEEP(*(.text.mac__build_qset_mask)) }
  ASSERT(SIZEOF(.text.mac__build_qset_mask) <= 96, "блок mac__build_qset_mask не влезает в отведённые ему 96 байт")
  .text.mac__build_tx_common_params 0x0092bb2c : { KEEP(*(.text.mac__build_tx_common_params)) }
  ASSERT(SIZEOF(.text.mac__build_tx_common_params) <= 180, "блок mac__build_tx_common_params не влезает в отведённые ему 180 байт")
  .text.rfc__issue_cmd_10 0x0092bbe0 : { KEEP(*(.text.rfc__issue_cmd_10)) }
  ASSERT(SIZEOF(.text.rfc__issue_cmd_10) <= 96, "блок rfc__issue_cmd_10 не влезает в отведённые ему 96 байт")
  .text.rfc__issue_cmd_20 0x0092bc40 : { KEEP(*(.text.rfc__issue_cmd_20)) }
  ASSERT(SIZEOF(.text.rfc__issue_cmd_20) <= 108, "блок rfc__issue_cmd_20 не влезает в отведённые ему 108 байт")
  .text.brp__write_reg_pair 0x0092bcac : { KEEP(*(.text.brp__write_reg_pair)) }
  ASSERT(SIZEOF(.text.brp__write_reg_pair) <= 148, "блок brp__write_reg_pair не влезает в отведённые ему 148 байт")
  .text.uc_queue__dispatch_and_commit 0x0092bd40 : { KEEP(*(.text.uc_queue__dispatch_and_commit)) }
  ASSERT(SIZEOF(.text.uc_queue__dispatch_and_commit) <= 64, "блок uc_queue__dispatch_and_commit не влезает в отведённые ему 64 байт")
  .text.rate_search__reset_sta 0x0092bd80 : { KEEP(*(.text.rate_search__reset_sta)) }
  ASSERT(SIZEOF(.text.rate_search__reset_sta) <= 72, "блок rate_search__reset_sta не влезает в отведённые ему 72 байт")
  .text.tx_flow_substep 0x0092bdc8 : { KEEP(*(.text.tx_flow_substep)) }
  ASSERT(SIZEOF(.text.tx_flow_substep) <= 260, "блок tx_flow_substep не влезает в отведённые ему 260 байт")
  .text.ucode_cmd__rs_enable 0x0092becc : { KEEP(*(.text.ucode_cmd__rs_enable)) }
  ASSERT(SIZEOF(.text.ucode_cmd__rs_enable) <= 336, "блок ucode_cmd__rs_enable не влезает в отведённые ему 336 байт")
  .text.tx_initiator__reset_slot_counters 0x0092c01c : { KEEP(*(.text.tx_initiator__reset_slot_counters)) }
  ASSERT(SIZEOF(.text.tx_initiator__reset_slot_counters) <= 24, "блок tx_initiator__reset_slot_counters не влезает в отведённые ему 24 байт")
  .text.rate_search__commit_mcs 0x0092c034 : { KEEP(*(.text.rate_search__commit_mcs)) }
  ASSERT(SIZEOF(.text.rate_search__commit_mcs) <= 40, "блок rate_search__commit_mcs не влезает в отведённые ему 40 байт")
  .text.rate_search__step 0x0092c05c : { KEEP(*(.text.rate_search__step)) }
  ASSERT(SIZEOF(.text.rate_search__step) <= 300, "блок rate_search__step не влезает в отведённые ему 300 байт")
  .text.ucode_cmd_0x30_handler 0x0092c188 : { KEEP(*(.text.ucode_cmd_0x30_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x30_handler) <= 64, "блок ucode_cmd_0x30_handler не влезает в отведённые ему 64 байт")
  .text.rate_search__current_mcs_b 0x0092c1c8 : { KEEP(*(.text.rate_search__current_mcs_b)) }
  ASSERT(SIZEOF(.text.rate_search__current_mcs_b) <= 36, "блок rate_search__current_mcs_b не влезает в отведённые ему 36 байт")
  .text.tbl_801754__byte_by_index 0x0092c1ec : { KEEP(*(.text.tbl_801754__byte_by_index)) }
  ASSERT(SIZEOF(.text.tbl_801754__byte_by_index) <= 16, "блок tbl_801754__byte_by_index не влезает в отведённые ему 16 байт")
  .text.rate_search__build_mcs_mask 0x0092c1fc : { KEEP(*(.text.rate_search__build_mcs_mask)) }
  ASSERT(SIZEOF(.text.rate_search__build_mcs_mask) <= 124, "блок rate_search__build_mcs_mask не влезает в отведённые ему 124 байт")
  .text.rate_search__current_mcs 0x0092c278 : { KEEP(*(.text.rate_search__current_mcs)) }
  ASSERT(SIZEOF(.text.rate_search__current_mcs) <= 36, "блок rate_search__current_mcs не влезает в отведённые ему 36 байт")
  .text.rate_search__reset_stats 0x0092c29c : { KEEP(*(.text.rate_search__reset_stats)) }
  ASSERT(SIZEOF(.text.rate_search__reset_stats) <= 112, "блок rate_search__reset_stats не влезает в отведённые ему 112 байт")
  .text.get_g_80051c 0x0092c30c : { KEEP(*(.text.get_g_80051c)) }
  ASSERT(SIZEOF(.text.get_g_80051c) <= 20, "блок get_g_80051c не влезает в отведённые ему 20 байт")
  .text.tbl_8018b5__byte_by_index 0x0092c320 : { KEEP(*(.text.tbl_8018b5__byte_by_index)) }
  ASSERT(SIZEOF(.text.tbl_8018b5__byte_by_index) <= 16, "блок tbl_8018b5__byte_by_index не влезает в отведённые ему 16 байт")
  .text.rate_search__apply_mcs 0x0092c330 : { KEEP(*(.text.rate_search__apply_mcs)) }
  ASSERT(SIZEOF(.text.rate_search__apply_mcs) <= 28, "блок rate_search__apply_mcs не влезает в отведённые ему 28 байт")
  .text.rate_search__start_for_sta 0x0092c34c : { KEEP(*(.text.rate_search__start_for_sta)) }
  ASSERT(SIZEOF(.text.rate_search__start_for_sta) <= 232, "блок rate_search__start_for_sta не влезает в отведённые ему 232 байт")
  .text.ucode_cmd_0x12_handler 0x0092c434 : { KEEP(*(.text.ucode_cmd_0x12_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x12_handler) <= 24, "блок ucode_cmd_0x12_handler не влезает в отведённые ему 24 байт")
  .text.rate_search__pick_tx_params 0x0092c44c : { KEEP(*(.text.rate_search__pick_tx_params)) }
  ASSERT(SIZEOF(.text.rate_search__pick_tx_params) <= 108, "блок rate_search__pick_tx_params не влезает в отведённые ему 108 байт")
  .text.bap_q_avail__check 0x0092c4b8 : { KEEP(*(.text.bap_q_avail__check)) }
  ASSERT(SIZEOF(.text.bap_q_avail__check) <= 112, "блок bap_q_avail__check не влезает в отведённые ему 112 байт")
  .text.abft__program_ssw_tx 0x0092c528 : { KEEP(*(.text.abft__program_ssw_tx)) }
  ASSERT(SIZEOF(.text.abft__program_ssw_tx) <= 108, "блок abft__program_ssw_tx не влезает в отведённые ему 108 байт")
  .text.abft_responder_worker 0x0092c594 : { KEEP(*(.text.abft_responder_worker)) }
  ASSERT(SIZEOF(.text.abft_responder_worker) <= 636, "блок abft_responder_worker не влезает в отведённые ему 636 байт")
  .text.abft__arm_response_window 0x0092c810 : { KEEP(*(.text.abft__arm_response_window)) }
  ASSERT(SIZEOF(.text.abft__arm_response_window) <= 52, "блок abft__arm_response_window не влезает в отведённые ему 52 байт")
  .text.abft_responder_substep 0x0092c844 : { KEEP(*(.text.abft_responder_substep)) }
  ASSERT(SIZEOF(.text.abft_responder_substep) <= 292, "блок abft_responder_substep не влезает в отведённые ему 292 байт")
  .text.bti_tx__program_bi2_regs 0x0092c968 : { KEEP(*(.text.bti_tx__program_bi2_regs)) }
  ASSERT(SIZEOF(.text.bti_tx__program_bi2_regs) <= 72, "блок bti_tx__program_bi2_regs не влезает в отведённые ему 72 байт")
  .text.bf_gpc__program_mac_by_mode 0x0092c9b0 : { KEEP(*(.text.bf_gpc__program_mac_by_mode)) }
  ASSERT(SIZEOF(.text.bf_gpc__program_mac_by_mode) <= 140, "блок bf_gpc__program_mac_by_mode не влезает в отведённые ему 140 байт")
  .text.abft_responder__tx_ssw 0x0092ca3c : { KEEP(*(.text.abft_responder__tx_ssw)) }
  ASSERT(SIZEOF(.text.abft_responder__tx_ssw) <= 976, "блок abft_responder__tx_ssw не влезает в отведённые ему 976 байт")
  .text.l1_task__check_pending 0x0092ce0c : { KEEP(*(.text.l1_task__check_pending)) }
  ASSERT(SIZEOF(.text.l1_task__check_pending) <= 96, "блок l1_task__check_pending не влезает в отведённые ему 96 байт")
  .text.rx_flow__latch_phy_883830 0x0092ce6c : { KEEP(*(.text.rx_flow__latch_phy_883830)) }
  ASSERT(SIZEOF(.text.rx_flow__latch_phy_883830) <= 36, "блок rx_flow__latch_phy_883830 не влезает в отведённые ему 36 байт")
  .text.rw_g_801b08 0x0092ce90 : { KEEP(*(.text.rw_g_801b08)) }
  ASSERT(SIZEOF(.text.rw_g_801b08) <= 12, "блок rw_g_801b08 не влезает в отведённые ему 12 байт")
  .text.rx_flow__run 0x0092ce9c : { KEEP(*(.text.rx_flow__run)) }
  ASSERT(SIZEOF(.text.rx_flow__run) <= 2212, "блок rx_flow__run не влезает в отведённые ему 2212 байт")
  .text.rx_funcs__handle_ppdu_report 0x0092d740 : { KEEP(*(.text.rx_funcs__handle_ppdu_report)) }
  ASSERT(SIZEOF(.text.rx_funcs__handle_ppdu_report) <= 1028, "блок rx_funcs__handle_ppdu_report не влезает в отведённые ему 1028 байт")
  .text.rx_flow_step 0x0092db44 : { KEEP(*(.text.rx_flow_step)) }
  ASSERT(SIZEOF(.text.rx_flow_step) <= 804, "блок rx_flow_step не влезает в отведённые ему 804 байт")
  .text.rx_flow__handle_frame 0x0092de68 : { KEEP(*(.text.rx_flow__handle_frame)) }
  ASSERT(SIZEOF(.text.rx_flow__handle_frame) <= 2416, "блок rx_flow__handle_frame не влезает в отведённые ему 2416 байт")
  .text.rx_flow__post_rx_act1 0x0092e7d8 : { KEEP(*(.text.rx_flow__post_rx_act1)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_act1) <= 196, "блок rx_flow__post_rx_act1 не влезает в отведённые ему 196 байт")
  .text.rx_flow__post_rx_act2 0x0092e89c : { KEEP(*(.text.rx_flow__post_rx_act2)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_act2) <= 180, "блок rx_flow__post_rx_act2 не влезает в отведённые ему 180 байт")
  .text.rx_flow__post_rx_act3 0x0092e950 : { KEEP(*(.text.rx_flow__post_rx_act3)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_act3) <= 216, "блок rx_flow__post_rx_act3 не влезает в отведённые ему 216 байт")
  .text.rx_flow__post_rx_act7 0x0092ea28 : { KEEP(*(.text.rx_flow__post_rx_act7)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_act7) <= 20, "блок rx_flow__post_rx_act7 не влезает в отведённые ему 20 байт")
  .text.rx_flow__post_rx_act9 0x0092ea3c : { KEEP(*(.text.rx_flow__post_rx_act9)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_act9) <= 20, "блок rx_flow__post_rx_act9 не влезает в отведённые ему 20 байт")
  .text.rx_flow__post_rx_act8 0x0092ea50 : { KEEP(*(.text.rx_flow__post_rx_act8)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_act8) <= 20, "блок rx_flow__post_rx_act8 не влезает в отведённые ему 20 байт")
  .text.rx_flow__post_rx_unsupported 0x0092ea64 : { KEEP(*(.text.rx_flow__post_rx_unsupported)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_unsupported) <= 20, "блок rx_flow__post_rx_unsupported не влезает в отведённые ему 20 байт")
  .text.rx_flow__post_rx_tail 0x0092ea78 : { KEEP(*(.text.rx_flow__post_rx_tail)) }
  ASSERT(SIZEOF(.text.rx_flow__post_rx_tail) <= 72, "блок rx_flow__post_rx_tail не влезает в отведённые ему 72 байт")
  .text.rx_flow__grant_detected 0x0092eac0 : { KEEP(*(.text.rx_flow__grant_detected)) }
  ASSERT(SIZEOF(.text.rx_flow__grant_detected) <= 904, "блок rx_flow__grant_detected не влезает в отведённые ему 904 байт")
  .text.rx_flow__lookup_mcs_ctx 0x0092ee48 : { KEEP(*(.text.rx_flow__lookup_mcs_ctx)) }
  ASSERT(SIZEOF(.text.rx_flow__lookup_mcs_ctx) <= 52, "блок rx_flow__lookup_mcs_ctx не влезает в отведённые ему 52 байт")
  .text.rx_flow__decide_imm_ack 0x0092ee7c : { KEEP(*(.text.rx_flow__decide_imm_ack)) }
  ASSERT(SIZEOF(.text.rx_flow__decide_imm_ack) <= 196, "блок rx_flow__decide_imm_ack не влезает в отведённые ему 196 байт")
  .text.rx_flow__check_status 0x0092ef40 : { KEEP(*(.text.rx_flow__check_status)) }
  ASSERT(SIZEOF(.text.rx_flow__check_status) <= 364, "блок rx_flow__check_status не влезает в отведённые ему 364 байт")
  .text.rx_flow__bump_stat_and_kick 0x0092f0ac : { KEEP(*(.text.rx_flow__bump_stat_and_kick)) }
  ASSERT(SIZEOF(.text.rx_flow__bump_stat_and_kick) <= 64, "блок rx_flow__bump_stat_and_kick не влезает в отведённые ему 64 байт")
  .text.rx_flow__check_ppdu_and_ctx 0x0092f0ec : { KEEP(*(.text.rx_flow__check_ppdu_and_ctx)) }
  ASSERT(SIZEOF(.text.rx_flow__check_ppdu_and_ctx) <= 64, "блок rx_flow__check_ppdu_and_ctx не влезает в отведённые ему 64 байт")
  .text.rx_rfc_step 0x0092f12c : { KEEP(*(.text.rx_rfc_step)) }
  ASSERT(SIZEOF(.text.rx_rfc_step) <= 340, "блок rx_rfc_step не влезает в отведённые ему 340 байт")
  .text.rx_funcs__rx_flow 0x0092f280 : { KEEP(*(.text.rx_funcs__rx_flow)) }
  ASSERT(SIZEOF(.text.rx_funcs__rx_flow) <= 2208, "блок rx_funcs__rx_flow не влезает в отведённые ему 2208 байт")
  .text.rx_nav_bi_step 0x0092fb20 : { KEEP(*(.text.rx_nav_bi_step)) }
  ASSERT(SIZEOF(.text.rx_nav_bi_step) <= 236, "блок rx_nav_bi_step не влезает в отведённые ему 236 байт")
  .text.rx_funcs_step 0x0092fc0c : { KEEP(*(.text.rx_funcs_step)) }
  ASSERT(SIZEOF(.text.rx_funcs_step) <= 304, "блок rx_funcs_step не влезает в отведённые ему 304 байт")
  .text.rx_nav_update 0x0092fd3c : { KEEP(*(.text.rx_nav_update)) }
  ASSERT(SIZEOF(.text.rx_nav_update) <= 432, "блок rx_nav_update не влезает в отведённые ему 432 байт")
  .text.ps_awake_peer__build_evt 0x0092feec : { KEEP(*(.text.ps_awake_peer__build_evt)) }
  ASSERT(SIZEOF(.text.ps_awake_peer__build_evt) <= 260, "блок ps_awake_peer__build_evt не влезает в отведённые ему 260 байт")
  .text.ps__program_awake_peers_mask 0x0092fff0 : { KEEP(*(.text.ps__program_awake_peers_mask)) }
  ASSERT(SIZEOF(.text.ps__program_awake_peers_mask) <= 168, "блок ps__program_awake_peers_mask не влезает в отведённые ему 168 байт")
  .text.ps__notify_awake_peers 0x00930098 : { KEEP(*(.text.ps__notify_awake_peers)) }
  ASSERT(SIZEOF(.text.ps__notify_awake_peers) <= 124, "блок ps__notify_awake_peers не влезает в отведённые ему 124 байт")
  .text.rf_sector__find_by_id 0x00930114 : { KEEP(*(.text.rf_sector__find_by_id)) }
  ASSERT(SIZEOF(.text.rf_sector__find_by_id) <= 60, "блок rf_sector__find_by_id не влезает в отведённые ему 60 байт")
  .text.basic_if__post_to_fw_mailbox 0x00930150 : { KEEP(*(.text.basic_if__post_to_fw_mailbox)) }
  ASSERT(SIZEOF(.text.basic_if__post_to_fw_mailbox) <= 324, "блок basic_if__post_to_fw_mailbox не влезает в отведённые ему 324 байт")
  .text.ucode_cmd_0x11_handler 0x00930294 : { KEEP(*(.text.ucode_cmd_0x11_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x11_handler) <= 16, "блок ucode_cmd_0x11_handler не влезает в отведённые ему 16 байт")
  .text.power_mngr_peer_update 0x009302a4 : { KEEP(*(.text.power_mngr_peer_update)) }
  ASSERT(SIZEOF(.text.power_mngr_peer_update) <= 380, "блок power_mngr_peer_update не влезает в отведённые ему 380 байт")
  .text.aw_ie__copy_to_bcon 0x00930420 : { KEEP(*(.text.aw_ie__copy_to_bcon)) }
  ASSERT(SIZEOF(.text.aw_ie__copy_to_bcon) <= 104, "блок aw_ie__copy_to_bcon не влезает в отведённые ему 104 байт")
  .text.aw__set_tbtt_offset 0x00930488 : { KEEP(*(.text.aw__set_tbtt_offset)) }
  ASSERT(SIZEOF(.text.aw__set_tbtt_offset) <= 12, "блок aw__set_tbtt_offset не влезает в отведённые ему 12 байт")
  .text.mac__program_deadline_slack 0x00930494 : { KEEP(*(.text.mac__program_deadline_slack)) }
  ASSERT(SIZEOF(.text.mac__program_deadline_slack) <= 40, "блок mac__program_deadline_slack не влезает в отведённые ему 40 байт")
  .text.set_reg_886d20_x2 0x009304bc : { KEEP(*(.text.set_reg_886d20_x2)) }
  ASSERT(SIZEOF(.text.set_reg_886d20_x2) <= 12, "блок set_reg_886d20_x2 не влезает в отведённые ему 12 байт")
  .text.bi_ap_mon_if__trigger 0x009304c8 : { KEEP(*(.text.bi_ap_mon_if__trigger)) }
  ASSERT(SIZEOF(.text.bi_ap_mon_if__trigger) <= 80, "блок bi_ap_mon_if__trigger не влезает в отведённые ему 80 байт")
  .text.epi_930518 0x00930518 : { KEEP(*(.text.epi_930518)) }
  ASSERT(SIZEOF(.text.epi_930518) <= 12, "блок epi_930518 не влезает в отведённые ему 12 байт")
  .text.bi_ap_mon_if__trigger_bhi_to_dti 0x00930524 : { KEEP(*(.text.bi_ap_mon_if__trigger_bhi_to_dti)) }
  ASSERT(SIZEOF(.text.bi_ap_mon_if__trigger_bhi_to_dti) <= 36, "блок bi_ap_mon_if__trigger_bhi_to_dti не влезает в отведённые ему 36 байт")
  .text.bi_ap_mon_if__trigger_bti_to_abft 0x00930548 : { KEEP(*(.text.bi_ap_mon_if__trigger_bti_to_abft)) }
  ASSERT(SIZEOF(.text.bi_ap_mon_if__trigger_bti_to_abft) <= 28, "блок bi_ap_mon_if__trigger_bti_to_abft не влезает в отведённые ему 28 байт")
  .text.bi_ap_mon_if__trigger_bhi 0x00930564 : { KEEP(*(.text.bi_ap_mon_if__trigger_bhi)) }
  ASSERT(SIZEOF(.text.bi_ap_mon_if__trigger_bhi) <= 64, "блок bi_ap_mon_if__trigger_bhi не влезает в отведённые ему 64 байт")
  .text.bi_ap_mon_if__trigger_aw_to_dti 0x009305a4 : { KEEP(*(.text.bi_ap_mon_if__trigger_aw_to_dti)) }
  ASSERT(SIZEOF(.text.bi_ap_mon_if__trigger_aw_to_dti) <= 24, "блок bi_ap_mon_if__trigger_aw_to_dti не влезает в отведённые ему 24 байт")
  .text.bi_ap_mon_if__trigger_dti_to_bti 0x009305bc : { KEEP(*(.text.bi_ap_mon_if__trigger_dti_to_bti)) }
  ASSERT(SIZEOF(.text.bi_ap_mon_if__trigger_dti_to_bti) <= 76, "блок bi_ap_mon_if__trigger_dti_to_bti не влезает в отведённые ему 76 байт")
  .text.sxd_hal__write_qset_field 0x00930608 : { KEEP(*(.text.sxd_hal__write_qset_field)) }
  ASSERT(SIZEOF(.text.sxd_hal__write_qset_field) <= 164, "блок sxd_hal__write_qset_field не влезает в отведённые ему 164 байт")
  .text.sxd_hal__mac_write_indexed 0x009306ac : { KEEP(*(.text.sxd_hal__mac_write_indexed)) }
  ASSERT(SIZEOF(.text.sxd_hal__mac_write_indexed) <= 192, "блок sxd_hal__mac_write_indexed не влезает в отведённые ему 192 байт")
  .text.stub_ret_93076c 0x0093076c : { KEEP(*(.text.stub_ret_93076c)) }
  ASSERT(SIZEOF(.text.stub_ret_93076c) <= 4, "блок stub_ret_93076c не влезает в отведённые ему 4 байт")
  .text.aw__set_new_tbtt 0x00930770 : { KEEP(*(.text.aw__set_new_tbtt)) }
  ASSERT(SIZEOF(.text.aw__set_new_tbtt) <= 508, "блок aw__set_new_tbtt не влезает в отведённые ему 508 байт")
  .text.aw__compute_next_tbtt 0x0093096c : { KEEP(*(.text.aw__compute_next_tbtt)) }
  ASSERT(SIZEOF(.text.aw__compute_next_tbtt) <= 212, "блок aw__compute_next_tbtt не влезает в отведённые ему 212 байт")
  .text.set_selected_rf_sector_index_cmd_handler 0x00930a40 : { KEEP(*(.text.set_selected_rf_sector_index_cmd_handler)) }
  ASSERT(SIZEOF(.text.set_selected_rf_sector_index_cmd_handler) <= 200, "блок set_selected_rf_sector_index_cmd_handler не влезает в отведённые ему 200 байт")
  .text.aw_tbtt_set_step 0x00930b08 : { KEEP(*(.text.aw_tbtt_set_step)) }
  ASSERT(SIZEOF(.text.aw_tbtt_set_step) <= 228, "блок aw_tbtt_set_step не влезает в отведённые ему 228 байт")
  .text.traffic_deferral__clear_node 0x00930bec : { KEEP(*(.text.traffic_deferral__clear_node)) }
  ASSERT(SIZEOF(.text.traffic_deferral__clear_node) <= 16, "блок traffic_deferral__clear_node не влезает в отведённые ему 16 байт")
  .text.traffic_deferral__is_enabled 0x00930bfc : { KEEP(*(.text.traffic_deferral__is_enabled)) }
  ASSERT(SIZEOF(.text.traffic_deferral__is_enabled) <= 44, "блок traffic_deferral__is_enabled не влезает в отведённые ему 44 байт")
  .text.uc_read_tsf64 0x00930cb0 : { KEEP(*(.text.uc_read_tsf64)) }
  ASSERT(SIZEOF(.text.uc_read_tsf64) <= 124, "блок uc_read_tsf64 не влезает в отведённые ему 124 байт")
  .text.brp__write_pair_b 0x00930d2c : { KEEP(*(.text.brp__write_pair_b)) }
  ASSERT(SIZEOF(.text.brp__write_pair_b) <= 64, "блок brp__write_pair_b не влезает в отведённые ему 64 байт")
  .text.brp__write_pair_0x504 0x00930d6c : { KEEP(*(.text.brp__write_pair_0x504)) }
  ASSERT(SIZEOF(.text.brp__write_pair_0x504) <= 88, "блок brp__write_pair_0x504 не влезает в отведённые ему 88 байт")
  .text.bf_substate__set 0x00930dc4 : { KEEP(*(.text.bf_substate__set)) }
  ASSERT(SIZEOF(.text.bf_substate__set) <= 16, "блок bf_substate__set не влезает в отведённые ему 16 байт")
  .text.ucode_cmd_0x16_handler 0x00930dd4 : { KEEP(*(.text.ucode_cmd_0x16_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x16_handler) <= 16, "блок ucode_cmd_0x16_handler не влезает в отведённые ему 16 байт")
  .text.tail_bcon_sweep_step_b 0x00930de4 : { KEEP(*(.text.tail_bcon_sweep_step_b)) }
  ASSERT(SIZEOF(.text.tail_bcon_sweep_step_b) <= 8, "блок tail_bcon_sweep_step_b не влезает в отведённые ему 8 байт")
  .text.bcon_sweep_step_b 0x00930dec : { KEEP(*(.text.bcon_sweep_step_b)) }
  ASSERT(SIZEOF(.text.bcon_sweep_step_b) <= 168, "блок bcon_sweep_step_b не влезает в отведённые ему 168 байт")
  .text.bcon_sweep__next_sector 0x00930e94 : { KEEP(*(.text.bcon_sweep__next_sector)) }
  ASSERT(SIZEOF(.text.bcon_sweep__next_sector) <= 160, "блок bcon_sweep__next_sector не влезает в отведённые ему 160 байт")
  .text.get_g_80087c 0x00930f34 : { KEEP(*(.text.get_g_80087c)) }
  ASSERT(SIZEOF(.text.get_g_80087c) <= 16, "блок get_g_80087c не влезает в отведённые ему 16 байт")
  .text.txss_copy_step 0x00930f44 : { KEEP(*(.text.txss_copy_step)) }
  ASSERT(SIZEOF(.text.txss_copy_step) <= 128, "блок txss_copy_step не влезает в отведённые ему 128 байт")
  .text.uc_mailbox__init_rings 0x00930fc4 : { KEEP(*(.text.uc_mailbox__init_rings)) }
  ASSERT(SIZEOF(.text.uc_mailbox__init_rings) <= 80, "блок uc_mailbox__init_rings не влезает в отведённые ему 80 байт")
  .text.bi_ap_mon__bti_to_abft 0x00931014 : { KEEP(*(.text.bi_ap_mon__bti_to_abft)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__bti_to_abft) <= 60, "блок bi_ap_mon__bti_to_abft не влезает в отведённые ему 60 байт")
  .text.bi_dti__kick_worker 0x00931050 : { KEEP(*(.text.bi_dti__kick_worker)) }
  ASSERT(SIZEOF(.text.bi_dti__kick_worker) <= 40, "блок bi_dti__kick_worker не влезает в отведённые ему 40 байт")
  .text.bi_ap_mon__aw_event 0x00931078 : { KEEP(*(.text.bi_ap_mon__aw_event)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__aw_event) <= 152, "блок bi_ap_mon__aw_event не влезает в отведённые ему 152 байт")
  .text.aw_worker__begin_window 0x00931110 : { KEEP(*(.text.aw_worker__begin_window)) }
  ASSERT(SIZEOF(.text.aw_worker__begin_window) <= 68, "блок aw_worker__begin_window не влезает в отведённые ему 68 байт")
  .text.bi_ap_mon__bti_event 0x00931154 : { KEEP(*(.text.bi_ap_mon__bti_event)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__bti_event) <= 80, "блок bi_ap_mon__bti_event не влезает в отведённые ему 80 байт")
  .text.bi_ap_mon__dti_event 0x00931270 : { KEEP(*(.text.bi_ap_mon__dti_event)) }
  ASSERT(SIZEOF(.text.bi_ap_mon__dti_event) <= 152, "блок bi_ap_mon__dti_event не влезает в отведённые ему 152 байт")
  .text.bi_dti__wake_and_evaluate_sleep 0x00931308 : { KEEP(*(.text.bi_dti__wake_and_evaluate_sleep)) }
  ASSERT(SIZEOF(.text.bi_dti__wake_and_evaluate_sleep) <= 48, "блок bi_dti__wake_and_evaluate_sleep не влезает в отведённые ему 48 байт")
  .text.mac__select_sector_and_wait_a 0x00931338 : { KEEP(*(.text.mac__select_sector_and_wait_a)) }
  ASSERT(SIZEOF(.text.mac__select_sector_and_wait_a) <= 68, "блок mac__select_sector_and_wait_a не влезает в отведённые ему 68 байт")
  .text.rx__send_response_frame 0x0093137c : { KEEP(*(.text.rx__send_response_frame)) }
  ASSERT(SIZEOF(.text.rx__send_response_frame) <= 108, "блок rx__send_response_frame не влезает в отведённые ему 108 байт")
  .text.rx_flow__send_imm_response 0x009313e8 : { KEEP(*(.text.rx_flow__send_imm_response)) }
  ASSERT(SIZEOF(.text.rx_flow__send_imm_response) <= 76, "блок rx_flow__send_imm_response не влезает в отведённые ему 76 байт")
  .text.direct_tx_rx_step 0x00931434 : { KEEP(*(.text.direct_tx_rx_step)) }
  ASSERT(SIZEOF(.text.direct_tx_rx_step) <= 132, "блок direct_tx_rx_step не влезает в отведённые ему 132 байт")
  .text.bi_mode_init_substep 0x009314b8 : { KEEP(*(.text.bi_mode_init_substep)) }
  ASSERT(SIZEOF(.text.bi_mode_init_substep) <= 264, "блок bi_mode_init_substep не влезает в отведённые ему 264 байт")
  .text.bi_mode__unmask_all_events 0x009315c0 : { KEEP(*(.text.bi_mode__unmask_all_events)) }
  ASSERT(SIZEOF(.text.bi_mode__unmask_all_events) <= 40, "блок bi_mode__unmask_all_events не влезает в отведённые ему 40 байт")
  .text.uc_read_tsf_lo 0x009315e8 : { KEEP(*(.text.uc_read_tsf_lo)) }
  ASSERT(SIZEOF(.text.uc_read_tsf_lo) <= 36, "блок uc_read_tsf_lo не влезает в отведённые ему 36 байт")
  .text.mac_sxd__program_886d88_and_cmd_1e 0x0093160c : { KEEP(*(.text.mac_sxd__program_886d88_and_cmd_1e)) }
  ASSERT(SIZEOF(.text.mac_sxd__program_886d88_and_cmd_1e) <= 52, "блок mac_sxd__program_886d88_and_cmd_1e не влезает в отведённые ему 52 байт")
  .text.mac__cmd_29000001 0x00931640 : { KEEP(*(.text.mac__cmd_29000001)) }
  ASSERT(SIZEOF(.text.mac__cmd_29000001) <= 36, "блок mac__cmd_29000001 не влезает в отведённые ему 36 байт")
  .text.mac__select_sector_and_wait_b 0x00931664 : { KEEP(*(.text.mac__select_sector_and_wait_b)) }
  ASSERT(SIZEOF(.text.mac__select_sector_and_wait_b) <= 68, "блок mac__select_sector_and_wait_b не влезает в отведённые ему 68 байт")
  .text.tail_uc_wait_two_events 0x009316a8 : { KEEP(*(.text.tail_uc_wait_two_events)) }
  ASSERT(SIZEOF(.text.tail_uc_wait_two_events) <= 12, "блок tail_uc_wait_two_events не влезает в отведённые ему 12 байт")
  .text.uc_wait_two_events 0x009316b4 : { KEEP(*(.text.uc_wait_two_events)) }
  ASSERT(SIZEOF(.text.uc_wait_two_events) <= 104, "блок uc_wait_two_events не влезает в отведённые ему 104 байт")
  .text.bi_mode_init_sequence 0x0093171c : { KEEP(*(.text.bi_mode_init_sequence)) }
  ASSERT(SIZEOF(.text.bi_mode_init_sequence) <= 212, "блок bi_mode_init_sequence не влезает в отведённые ему 212 байт")
  .text.uc_spin_until_event4 0x009317f0 : { KEEP(*(.text.uc_spin_until_event4)) }
  ASSERT(SIZEOF(.text.uc_spin_until_event4) <= 12, "блок uc_spin_until_event4 не влезает в отведённые ему 12 байт")
  .text.uc_spin_until_event 0x009317fc : { KEEP(*(.text.uc_spin_until_event)) }
  ASSERT(SIZEOF(.text.uc_spin_until_event) <= 12, "блок uc_spin_until_event не влезает в отведённые ему 12 байт")
  .text.uc_wait_event_busy 0x00931808 : { KEEP(*(.text.uc_wait_event_busy)) }
  ASSERT(SIZEOF(.text.uc_wait_event_busy) <= 116, "блок uc_wait_event_busy не влезает в отведённые ему 116 байт")
  .text.uc_sleep_until_event 0x0093187c : { KEEP(*(.text.uc_sleep_until_event)) }
  ASSERT(SIZEOF(.text.uc_sleep_until_event) <= 120, "блок uc_sleep_until_event не влезает в отведённые ему 120 байт")
  .text.uc_wait_event1_or_event4 0x009318f4 : { KEEP(*(.text.uc_wait_event1_or_event4)) }
  ASSERT(SIZEOF(.text.uc_wait_event1_or_event4) <= 140, "блок uc_wait_event1_or_event4 не влезает в отведённые ему 140 байт")
  .text.mac__select_all_sectors_and_wait 0x00931980 : { KEEP(*(.text.mac__select_all_sectors_and_wait)) }
  ASSERT(SIZEOF(.text.mac__select_all_sectors_and_wait) <= 60, "блок mac__select_all_sectors_and_wait не влезает в отведённые ему 60 байт")
  .text.mac__set_phy_mode 0x009319bc : { KEEP(*(.text.mac__set_phy_mode)) }
  ASSERT(SIZEOF(.text.mac__set_phy_mode) <= 44, "блок mac__set_phy_mode не влезает в отведённые ему 44 байт")
  .text.txrx_api_step_c 0x009319e8 : { KEEP(*(.text.txrx_api_step_c)) }
  ASSERT(SIZEOF(.text.txrx_api_step_c) <= 144, "блок txrx_api_step_c не влезает в отведённые ему 144 байт")
  .text.bi_tx__check_idle_and_start 0x00931a78 : { KEEP(*(.text.bi_tx__check_idle_and_start)) }
  ASSERT(SIZEOF(.text.bi_tx__check_idle_and_start) <= 116, "блок bi_tx__check_idle_and_start не влезает в отведённые ему 116 байт")
  .text.bi_tx__program_initiator 0x00931aec : { KEEP(*(.text.bi_tx__program_initiator)) }
  ASSERT(SIZEOF(.text.bi_tx__program_initiator) <= 172, "блок bi_tx__program_initiator не влезает в отведённые ему 172 байт")
  .text.bi_mode__program_mac_timing 0x00931b98 : { KEEP(*(.text.bi_mode__program_mac_timing)) }
  ASSERT(SIZEOF(.text.bi_mode__program_mac_timing) <= 56, "блок bi_mode__program_mac_timing не влезает в отведённые ему 56 байт")
  .text.ifs_cfg__program_from_hw_cfg 0x00931bd0 : { KEEP(*(.text.ifs_cfg__program_from_hw_cfg)) }
  ASSERT(SIZEOF(.text.ifs_cfg__program_from_hw_cfg) <= 148, "блок ifs_cfg__program_from_hw_cfg не влезает в отведённые ему 148 байт")
  .text.uc_read_bi_sync 0x00931c64 : { KEEP(*(.text.uc_read_bi_sync)) }
  ASSERT(SIZEOF(.text.uc_read_bi_sync) <= 52, "блок uc_read_bi_sync не влезает в отведённые ему 52 байт")
  .text.us_from_ticks165 0x00931c98 : { KEEP(*(.text.us_from_ticks165)) }
  ASSERT(SIZEOF(.text.us_from_ticks165) <= 20, "блок us_from_ticks165 не влезает в отведённые ему 20 байт")
  .text.mac__program_886f70_from_tbl 0x00931cac : { KEEP(*(.text.mac__program_886f70_from_tbl)) }
  ASSERT(SIZEOF(.text.mac__program_886f70_from_tbl) <= 60, "блок mac__program_886f70_from_tbl не влезает в отведённые ему 60 байт")
  .text.txrx_api_cmd_step 0x00931ce8 : { KEEP(*(.text.txrx_api_cmd_step)) }
  ASSERT(SIZEOF(.text.txrx_api_cmd_step) <= 228, "блок txrx_api_cmd_step не влезает в отведённые ему 228 байт")
  .text.sxd_hal__wait_slot2_busy2 0x00931dcc : { KEEP(*(.text.sxd_hal__wait_slot2_busy2)) }
  ASSERT(SIZEOF(.text.sxd_hal__wait_slot2_busy2) <= 168, "блок sxd_hal__wait_slot2_busy2 не влезает в отведённые ему 168 байт")
  .text.sxd_hal__wait_slot2_busy 0x00931e74 : { KEEP(*(.text.sxd_hal__wait_slot2_busy)) }
  ASSERT(SIZEOF(.text.sxd_hal__wait_slot2_busy) <= 132, "блок sxd_hal__wait_slot2_busy не влезает в отведённые ему 132 байт")
  .text.uc_sta_trace__push_record 0x00931ef8 : { KEEP(*(.text.uc_sta_trace__push_record)) }
  ASSERT(SIZEOF(.text.uc_sta_trace__push_record) <= 92, "блок uc_sta_trace__push_record не влезает в отведённые ему 92 байт")
  .text.uc_sta_ctx__reset 0x00931f54 : { KEEP(*(.text.uc_sta_ctx__reset)) }
  ASSERT(SIZEOF(.text.uc_sta_ctx__reset) <= 56, "блок uc_sta_ctx__reset не влезает в отведённые ему 56 байт")
  .text.bti__bi2_event_step 0x00931f8c : { KEEP(*(.text.bti__bi2_event_step)) }
  ASSERT(SIZEOF(.text.bti__bi2_event_step) <= 1108, "блок bti__bi2_event_step не влезает в отведённые ему 1108 байт")
  .text.uc_timer__start 0x009323e0 : { KEEP(*(.text.uc_timer__start)) }
  ASSERT(SIZEOF(.text.uc_timer__start) <= 168, "блок uc_timer__start не влезает в отведённые ему 168 байт")
  .text.traffic_deferral_cfg_cmd_handler 0x00932488 : { KEEP(*(.text.traffic_deferral_cfg_cmd_handler)) }
  ASSERT(SIZEOF(.text.traffic_deferral_cfg_cmd_handler) <= 128, "блок traffic_deferral_cfg_cmd_handler не влезает в отведённые ему 128 байт")
  .text.uc_bi_counter_in_window 0x00932508 : { KEEP(*(.text.uc_bi_counter_in_window)) }
  ASSERT(SIZEOF(.text.uc_bi_counter_in_window) <= 100, "блок uc_bi_counter_in_window не влезает в отведённые ему 100 байт")
  .text.get_reg_886d64_93256c 0x0093256c : { KEEP(*(.text.get_reg_886d64_93256c)) }
  ASSERT(SIZEOF(.text.get_reg_886d64_93256c) <= 16, "блок get_reg_886d64_93256c не влезает в отведённые ему 16 байт")
  .text.mac__read_pair64_consistent 0x0093257c : { KEEP(*(.text.mac__read_pair64_consistent)) }
  ASSERT(SIZEOF(.text.mac__read_pair64_consistent) <= 48, "блок mac__read_pair64_consistent не влезает в отведённые ему 48 байт")
  .text.aw__compute_tbtt_from_hw 0x009325ac : { KEEP(*(.text.aw__compute_tbtt_from_hw)) }
  ASSERT(SIZEOF(.text.aw__compute_tbtt_from_hw) <= 56, "блок aw__compute_tbtt_from_hw не влезает в отведённые ему 56 байт")
  .text.uc_sysassert__snapshot_mac 0x009325e4 : { KEEP(*(.text.uc_sysassert__snapshot_mac)) }
  ASSERT(SIZEOF(.text.uc_sysassert__snapshot_mac) <= 48, "блок uc_sysassert__snapshot_mac не влезает в отведённые ему 48 байт")
  .text.mac__rx_off_seq 0x00932614 : { KEEP(*(.text.mac__rx_off_seq)) }
  ASSERT(SIZEOF(.text.mac__rx_off_seq) <= 48, "блок mac__rx_off_seq не влезает в отведённые ему 48 байт")
  .text.mac_mode__enter_idle_seq 0x00932644 : { KEEP(*(.text.mac_mode__enter_idle_seq)) }
  ASSERT(SIZEOF(.text.mac_mode__enter_idle_seq) <= 192, "блок mac_mode__enter_idle_seq не влезает в отведённые ему 192 байт")
  .text.bi_manager__rx_flow_body 0x00932704 : { KEEP(*(.text.bi_manager__rx_flow_body)) }
  ASSERT(SIZEOF(.text.bi_manager__rx_flow_body) <= 320, "блок bi_manager__rx_flow_body не влезает в отведённые ему 320 байт")
  .text.bi_tx_initiator_wrap 0x00932844 : { KEEP(*(.text.bi_tx_initiator_wrap)) }
  ASSERT(SIZEOF(.text.bi_tx_initiator_wrap) <= 432, "блок bi_tx_initiator_wrap не влезает в отведённые ему 432 байт")
  .text.stub_ret_9329f4 0x009329f4 : { KEEP(*(.text.stub_ret_9329f4)) }
  ASSERT(SIZEOF(.text.stub_ret_9329f4) <= 4, "блок stub_ret_9329f4 не влезает в отведённые ему 4 байт")
  .text.stub_ret_9329f8 0x009329f8 : { KEEP(*(.text.stub_ret_9329f8)) }
  ASSERT(SIZEOF(.text.stub_ret_9329f8) <= 4, "блок stub_ret_9329f8 не влезает в отведённые ему 4 байт")
  .text.tx_rate_select_and_program 0x009329fc : { KEEP(*(.text.tx_rate_select_and_program)) }
  ASSERT(SIZEOF(.text.tx_rate_select_and_program) <= 1028, "блок tx_rate_select_and_program не влезает в отведённые ему 1028 байт")
  .text.beacon_tx__build_slot_bitmap 0x00932e00 : { KEEP(*(.text.beacon_tx__build_slot_bitmap)) }
  ASSERT(SIZEOF(.text.beacon_tx__build_slot_bitmap) <= 156, "блок beacon_tx__build_slot_bitmap не влезает в отведённые ему 156 байт")
  .text.bi_cfg__tick_counters 0x00932e9c : { KEEP(*(.text.bi_cfg__tick_counters)) }
  ASSERT(SIZEOF(.text.bi_cfg__tick_counters) <= 68, "блок bi_cfg__tick_counters не влезает в отведённые ему 68 байт")
  .text.bcon_sweep_step_a 0x00932ee0 : { KEEP(*(.text.bcon_sweep_step_a)) }
  ASSERT(SIZEOF(.text.bcon_sweep_step_a) <= 172, "блок bcon_sweep_step_a не влезает в отведённые ему 172 байт")
  .text.ucode_cmd__bi_config 0x00932f8c : { KEEP(*(.text.ucode_cmd__bi_config)) }
  ASSERT(SIZEOF(.text.ucode_cmd__bi_config) <= 584, "блок ucode_cmd__bi_config не влезает в отведённые ему 584 байт")
  .text.tail_bi_cfg__apply 0x009331d4 : { KEEP(*(.text.tail_bi_cfg__apply)) }
  ASSERT(SIZEOF(.text.tail_bi_cfg__apply) <= 4, "блок tail_bi_cfg__apply не влезает в отведённые ему 4 байт")
  .text.bi_cfg__apply 0x009331d8 : { KEEP(*(.text.bi_cfg__apply)) }
  ASSERT(SIZEOF(.text.bi_cfg__apply) <= 168, "блок bi_cfg__apply не влезает в отведённые ему 168 байт")
  .text.bi_ctrl__program_mac_bcon 0x00933280 : { KEEP(*(.text.bi_ctrl__program_mac_bcon)) }
  ASSERT(SIZEOF(.text.bi_ctrl__program_mac_bcon) <= 84, "блок bi_ctrl__program_mac_bcon не влезает в отведённые ему 84 байт")
  .text.txop_tx_step 0x009332d4 : { KEEP(*(.text.txop_tx_step)) }
  ASSERT(SIZEOF(.text.txop_tx_step) <= 152, "блок txop_tx_step не влезает в отведённые ему 152 байт")
  .text.direct_tx_substep 0x0093336c : { KEEP(*(.text.direct_tx_substep)) }
  ASSERT(SIZEOF(.text.direct_tx_substep) <= 168, "блок direct_tx_substep не влезает в отведённые ему 168 байт")
  .text.tx_ctx__next_slot 0x00933414 : { KEEP(*(.text.tx_ctx__next_slot)) }
  ASSERT(SIZEOF(.text.tx_ctx__next_slot) <= 64, "блок tx_ctx__next_slot не влезает в отведённые ему 64 байт")
  .text.cf_end__send_frame 0x00933454 : { KEEP(*(.text.cf_end__send_frame)) }
  ASSERT(SIZEOF(.text.cf_end__send_frame) <= 112, "блок cf_end__send_frame не влезает в отведённые ему 112 байт")
  .text.direct_tx_rx__program 0x009334c4 : { KEEP(*(.text.direct_tx_rx__program)) }
  ASSERT(SIZEOF(.text.direct_tx_rx__program) <= 164, "блок direct_tx_rx__program не влезает в отведённые ему 164 байт")
  .text.tx_flows__program_mac_tx 0x00933568 : { KEEP(*(.text.tx_flows__program_mac_tx)) }
  ASSERT(SIZEOF(.text.tx_flows__program_mac_tx) <= 608, "блок tx_flows__program_mac_tx не влезает в отведённые ему 608 байт")
  .text.tx_initiator_flow 0x009337c8 : { KEEP(*(.text.tx_initiator_flow)) }
  ASSERT(SIZEOF(.text.tx_initiator_flow) <= 552, "блок tx_initiator_flow не влезает в отведённые ему 552 байт")
  .text.internal_tx_step 0x009339f0 : { KEEP(*(.text.internal_tx_step)) }
  ASSERT(SIZEOF(.text.internal_tx_step) <= 828, "блок internal_tx_step не влезает в отведённые ему 828 байт")
  .text.keep_alive__arm_slot 0x00933d2c : { KEEP(*(.text.keep_alive__arm_slot)) }
  ASSERT(SIZEOF(.text.keep_alive__arm_slot) <= 76, "блок keep_alive__arm_slot не влезает в отведённые ему 76 байт")
  .text.internal_tx__clear_pending 0x00933d78 : { KEEP(*(.text.internal_tx__clear_pending)) }
  ASSERT(SIZEOF(.text.internal_tx__clear_pending) <= 96, "блок internal_tx__clear_pending не влезает в отведённые ему 96 байт")
  .text.bi_rx__send_response 0x00933dd8 : { KEEP(*(.text.bi_rx__send_response)) }
  ASSERT(SIZEOF(.text.bi_rx__send_response) <= 100, "блок bi_rx__send_response не влезает в отведённые ему 100 байт")
  .text.tx__read_tx_result 0x00933e3c : { KEEP(*(.text.tx__read_tx_result)) }
  ASSERT(SIZEOF(.text.tx__read_tx_result) <= 84, "блок tx__read_tx_result не влезает в отведённые ему 84 байт")
  .text.tx_initiator__build_tx_vector 0x00933e90 : { KEEP(*(.text.tx_initiator__build_tx_vector)) }
  ASSERT(SIZEOF(.text.tx_initiator__build_tx_vector) <= 256, "блок tx_initiator__build_tx_vector не влезает в отведённые ему 256 байт")
  .text.mac_counter__program_0008 0x00933f90 : { KEEP(*(.text.mac_counter__program_0008)) }
  ASSERT(SIZEOF(.text.mac_counter__program_0008) <= 268, "блок mac_counter__program_0008 не влезает в отведённые ему 268 байт")
  .text.txop__open_window 0x0093409c : { KEEP(*(.text.txop__open_window)) }
  ASSERT(SIZEOF(.text.txop__open_window) <= 160, "блок txop__open_window не влезает в отведённые ему 160 байт")
  .text.tx_mtp_queue_gate 0x0093413c : { KEEP(*(.text.tx_mtp_queue_gate)) }
  ASSERT(SIZEOF(.text.tx_mtp_queue_gate) <= 496, "блок tx_mtp_queue_gate не влезает в отведённые ему 496 байт")
  .text.mac__current_sector_index 0x0093432c : { KEEP(*(.text.mac__current_sector_index)) }
  ASSERT(SIZEOF(.text.mac__current_sector_index) <= 40, "блок mac__current_sector_index не влезает в отведённые ему 40 байт")
  .text.tx_initiator_substep 0x00934354 : { KEEP(*(.text.tx_initiator_substep)) }
  ASSERT(SIZEOF(.text.tx_initiator_substep) <= 312, "блок tx_initiator_substep не влезает в отведённые ему 312 байт")
  .text.tx_flow_size_step 0x0093448c : { KEEP(*(.text.tx_flow_size_step)) }
  ASSERT(SIZEOF(.text.tx_flow_size_step) <= 480, "блок tx_flow_size_step не влезает в отведённые ему 480 байт")
  .text.tx_initiator_step 0x0093466c : { KEEP(*(.text.tx_initiator_step)) }
  ASSERT(SIZEOF(.text.tx_initiator_step) <= 536, "блок tx_initiator_step не влезает в отведённые ему 536 байт")
  .text.txop_initiator_open_txop_flow 0x00934884 : { KEEP(*(.text.txop_initiator_open_txop_flow)) }
  ASSERT(SIZEOF(.text.txop_initiator_open_txop_flow) <= 900, "блок txop_initiator_open_txop_flow не влезает в отведённые ему 900 байт")
  .text.tx_initiator_rx_step 0x00934c08 : { KEEP(*(.text.tx_initiator_rx_step)) }
  ASSERT(SIZEOF(.text.tx_initiator_rx_step) <= 212, "блок tx_initiator_rx_step не влезает в отведённые ему 212 байт")
  .text.mac_counter__program_400b 0x00934cdc : { KEEP(*(.text.mac_counter__program_400b)) }
  ASSERT(SIZEOF(.text.mac_counter__program_400b) <= 208, "блок mac_counter__program_400b не влезает в отведённые ему 208 байт")
  .text.ucode_cmd_0x19_handler 0x00934dac : { KEEP(*(.text.ucode_cmd_0x19_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x19_handler) <= 56, "блок ucode_cmd_0x19_handler не влезает в отведённые ему 56 байт")
  .text.ucode_cmd__discovery_mode_cfg 0x00934de4 : { KEEP(*(.text.ucode_cmd__discovery_mode_cfg)) }
  ASSERT(SIZEOF(.text.ucode_cmd__discovery_mode_cfg) <= 388, "блок ucode_cmd__discovery_mode_cfg не влезает в отведённые ему 388 байт")
  .text.ucode_cmd_0x00_handler 0x00934f68 : { KEEP(*(.text.ucode_cmd_0x00_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x00_handler) <= 116, "блок ucode_cmd_0x00_handler не влезает в отведённые ему 116 байт")
  .text.txrx_umac_if_long_range_cmd_handler 0x00934fdc : { KEEP(*(.text.txrx_umac_if_long_range_cmd_handler)) }
  ASSERT(SIZEOF(.text.txrx_umac_if_long_range_cmd_handler) <= 80, "блок txrx_umac_if_long_range_cmd_handler не влезает в отведённые ему 80 байт")
  .text.ucode_cmd_0x21_handler 0x0093502c : { KEEP(*(.text.ucode_cmd_0x21_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x21_handler) <= 32, "блок ucode_cmd_0x21_handler не влезает в отведённые ему 32 байт")
  .text.ucode_cmd__rx_off 0x0093504c : { KEEP(*(.text.ucode_cmd__rx_off)) }
  ASSERT(SIZEOF(.text.ucode_cmd__rx_off) <= 28, "блок ucode_cmd__rx_off не влезает в отведённые ему 28 байт")
  .text.ucode_cmd__rx_on 0x00935068 : { KEEP(*(.text.ucode_cmd__rx_on)) }
  ASSERT(SIZEOF(.text.ucode_cmd__rx_on) <= 416, "блок ucode_cmd__rx_on не влезает в отведённые ему 416 байт")
  .text.ucode_cmd_0x05_handler 0x00935208 : { KEEP(*(.text.ucode_cmd_0x05_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x05_handler) <= 412, "блок ucode_cmd_0x05_handler не влезает в отведённые ему 412 байт")
  .text.ucode_cmd_install_key 0x009353a4 : { KEEP(*(.text.ucode_cmd_install_key)) }
  ASSERT(SIZEOF(.text.ucode_cmd_install_key) <= 108, "блок ucode_cmd_install_key не влезает в отведённые ему 108 байт")
  .text.ucode_cmd_0x04_handler 0x00935410 : { KEEP(*(.text.ucode_cmd_0x04_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x04_handler) <= 40, "блок ucode_cmd_0x04_handler не влезает в отведённые ему 40 байт")
  .text.ucode_cmd_0x07_handler 0x00935438 : { KEEP(*(.text.ucode_cmd_0x07_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x07_handler) <= 156, "блок ucode_cmd_0x07_handler не влезает в отведённые ему 156 байт")
  .text.ucode_cmd__queue_delete 0x009354d4 : { KEEP(*(.text.ucode_cmd__queue_delete)) }
  ASSERT(SIZEOF(.text.ucode_cmd__queue_delete) <= 784, "блок ucode_cmd__queue_delete не влезает в отведённые ему 784 байт")
  .text.ucode_cmd_update_aw_ie 0x009357e4 : { KEEP(*(.text.ucode_cmd_update_aw_ie)) }
  ASSERT(SIZEOF(.text.ucode_cmd_update_aw_ie) <= 48, "блок ucode_cmd_update_aw_ie не влезает в отведённые ему 48 байт")
  .text.rx_funcs_substep 0x00935814 : { KEEP(*(.text.rx_funcs_substep)) }
  ASSERT(SIZEOF(.text.rx_funcs_substep) <= 152, "блок rx_funcs_substep не влезает в отведённые ему 152 байт")
  .text.rx_funcs__send_direct_frame 0x009358ac : { KEEP(*(.text.rx_funcs__send_direct_frame)) }
  ASSERT(SIZEOF(.text.rx_funcs__send_direct_frame) <= 116, "блок rx_funcs__send_direct_frame не влезает в отведённые ему 116 байт")
  .text.direct_tx__send_short_frame 0x00935920 : { KEEP(*(.text.direct_tx__send_short_frame)) }
  ASSERT(SIZEOF(.text.direct_tx__send_short_frame) <= 112, "блок direct_tx__send_short_frame не влезает в отведённые ему 112 байт")
  .text.abft__send_ssw_feedback 0x00935990 : { KEEP(*(.text.abft__send_ssw_feedback)) }
  ASSERT(SIZEOF(.text.abft__send_ssw_feedback) <= 96, "блок abft__send_ssw_feedback не влезает в отведённые ему 96 байт")
  .text.tail_direct_tx__send_short_frame 0x009359f0 : { KEEP(*(.text.tail_direct_tx__send_short_frame)) }
  ASSERT(SIZEOF(.text.tail_direct_tx__send_short_frame) <= 4, "блок tail_direct_tx__send_short_frame не влезает в отведённые ему 4 байт")
  .text.tail_direct_tx__send_short_frame_9359f4 0x009359f4 : { KEEP(*(.text.tail_direct_tx__send_short_frame_9359f4)) }
  ASSERT(SIZEOF(.text.tail_direct_tx__send_short_frame_9359f4) <= 12, "блок tail_direct_tx__send_short_frame_9359f4 не влезает в отведённые ему 12 байт")
  .text.bi_mode__load_qset_table 0x00935a00 : { KEEP(*(.text.bi_mode__load_qset_table)) }
  ASSERT(SIZEOF(.text.bi_mode__load_qset_table) <= 76, "блок bi_mode__load_qset_table не влезает в отведённые ему 76 байт")
  .text.bcon_txss_sweep_step 0x00935a4c : { KEEP(*(.text.bcon_txss_sweep_step)) }
  ASSERT(SIZEOF(.text.bcon_txss_sweep_step) <= 904, "блок bcon_txss_sweep_step не влезает в отведённые ему 904 байт")
  .text.bf_substate_sm__step 0x00935dd4 : { KEEP(*(.text.bf_substate_sm__step)) }
  ASSERT(SIZEOF(.text.bf_substate_sm__step) <= 176, "блок bf_substate_sm__step не влезает в отведённые ему 176 байт")
  .text.bf_substate__txss_by_slot 0x00935e84 : { KEEP(*(.text.bf_substate__txss_by_slot)) }
  ASSERT(SIZEOF(.text.bf_substate__txss_by_slot) <= 64, "блок bf_substate__txss_by_slot не влезает в отведённые ему 64 байт")
  .text.set_g_801b64_x2 0x00935ec4 : { KEEP(*(.text.set_g_801b64_x2)) }
  ASSERT(SIZEOF(.text.set_g_801b64_x2) <= 16, "блок set_g_801b64_x2 не влезает в отведённые ему 16 байт")
  .text.ucode_cmd_0x0c_handler 0x00935ed4 : { KEEP(*(.text.ucode_cmd_0x0c_handler)) }
  ASSERT(SIZEOF(.text.ucode_cmd_0x0c_handler) <= 128, "блок ucode_cmd_0x0c_handler не влезает в отведённые ему 128 байт")
  .text.txss__init_sweep 0x00935f54 : { KEEP(*(.text.txss__init_sweep)) }
  ASSERT(SIZEOF(.text.txss__init_sweep) <= 288, "блок txss__init_sweep не влезает в отведённые ему 288 байт")
  .text.txss__prepare_frames 0x00936074 : { KEEP(*(.text.txss__prepare_frames)) }
  ASSERT(SIZEOF(.text.txss__prepare_frames) <= 352, "блок txss__prepare_frames не влезает в отведённые ему 352 байт")
  .text.txss__flow_body 0x009361d4 : { KEEP(*(.text.txss__flow_body)) }
  ASSERT(SIZEOF(.text.txss__flow_body) <= 392, "блок txss__flow_body не влезает в отведённые ему 392 байт")
  .text.bf_substate_sm__is_state_9_11 0x0093635c : { KEEP(*(.text.bf_substate_sm__is_state_9_11)) }
  ASSERT(SIZEOF(.text.bf_substate_sm__is_state_9_11) <= 64, "блок bf_substate_sm__is_state_9_11 не влезает в отведённые ему 64 байт")
  .text.bf_substate__txss_step_by_slot 0x0093639c : { KEEP(*(.text.bf_substate__txss_step_by_slot)) }
  ASSERT(SIZEOF(.text.bf_substate__txss_step_by_slot) <= 64, "блок bf_substate__txss_step_by_slot не влезает в отведённые ему 64 байт")
  .text.txss__init_sweep_b 0x009363dc : { KEEP(*(.text.txss__init_sweep_b)) }
  ASSERT(SIZEOF(.text.txss__init_sweep_b) <= 176, "блок txss__init_sweep_b не влезает в отведённые ему 176 байт")
  .text.txss_rx_step 0x0093648c : { KEEP(*(.text.txss_rx_step)) }
  ASSERT(SIZEOF(.text.txss_rx_step) <= 240, "блок txss_rx_step не влезает в отведённые ему 240 байт")
  .text.txss_flow_step_b 0x0093657c : { KEEP(*(.text.txss_flow_step_b)) }
  ASSERT(SIZEOF(.text.txss_flow_step_b) <= 220, "блок txss_flow_step_b не влезает в отведённые ему 220 байт")
  .text.txss_flow_step 0x00936658 : { KEEP(*(.text.txss_flow_step)) }
  ASSERT(SIZEOF(.text.txss_flow_step) <= 524, "блок txss_flow_step не влезает в отведённые ему 524 байт")
  .text.txss__tx_sector_frame 0x00936864 : { KEEP(*(.text.txss__tx_sector_frame)) }
  ASSERT(SIZEOF(.text.txss__tx_sector_frame) <= 712, "блок txss__tx_sector_frame не влезает в отведённые ему 712 байт")
  .text.uc_tx__is_idle 0x00936b2c : { KEEP(*(.text.uc_tx__is_idle)) }
  ASSERT(SIZEOF(.text.uc_tx__is_idle) <= 32, "блок uc_tx__is_idle не влезает в отведённые ему 32 байт")
  .text.qset1_mask__any_pending 0x00936b4c : { KEEP(*(.text.qset1_mask__any_pending)) }
  ASSERT(SIZEOF(.text.qset1_mask__any_pending) <= 96, "блок qset1_mask__any_pending не влезает в отведённые ему 96 байт")
  .text.background_bi_step 0x00936bac : { KEEP(*(.text.background_bi_step)) }
  ASSERT(SIZEOF(.text.background_bi_step) <= 208, "блок background_bi_step не влезает в отведённые ему 208 байт")
  .text.ucode_pm__stamp_tsf_slots 0x00936c7c : { KEEP(*(.text.ucode_pm__stamp_tsf_slots)) }
  ASSERT(SIZEOF(.text.ucode_pm__stamp_tsf_slots) <= 44, "блок ucode_pm__stamp_tsf_slots не влезает в отведённые ему 44 байт")
  .text.uc_pm__enter_idle 0x00936ca8 : { KEEP(*(.text.uc_pm__enter_idle)) }
  ASSERT(SIZEOF(.text.uc_pm__enter_idle) <= 68, "блок uc_pm__enter_idle не влезает в отведённые ему 68 байт")
  .text.ucode_pm__rx_off_step 0x00936cec : { KEEP(*(.text.ucode_pm__rx_off_step)) }
  ASSERT(SIZEOF(.text.ucode_pm__rx_off_step) <= 84, "блок ucode_pm__rx_off_step не влезает в отведённые ему 84 байт")
  .text.set_g_80058c 0x00936d40 : { KEEP(*(.text.set_g_80058c)) }
  ASSERT(SIZEOF(.text.set_g_80058c) <= 16, "блок set_g_80058c не влезает в отведённые ему 16 байт")
  .text.ucode_pm__set_busy_flag 0x00936d50 : { KEEP(*(.text.ucode_pm__set_busy_flag)) }
  ASSERT(SIZEOF(.text.ucode_pm__set_busy_flag) <= 20, "блок ucode_pm__set_busy_flag не влезает в отведённые ему 20 байт")
  .text.mac__switch_core_and_setup_dma 0x00936d64 : { KEEP(*(.text.mac__switch_core_and_setup_dma)) }
  ASSERT(SIZEOF(.text.mac__switch_core_and_setup_dma) <= 36, "блок mac__switch_core_and_setup_dma не влезает в отведённые ему 36 байт")
  .text.uc_timers__start_defaults 0x00936d88 : { KEEP(*(.text.uc_timers__start_defaults)) }
  ASSERT(SIZEOF(.text.uc_timers__start_defaults) <= 36, "блок uc_timers__start_defaults не влезает в отведённые ему 36 байт")
  .text.uc_timers__start_defaults_b 0x00936dac : { KEEP(*(.text.uc_timers__start_defaults_b)) }
  ASSERT(SIZEOF(.text.uc_timers__start_defaults_b) <= 36, "блок uc_timers__start_defaults_b не влезает в отведённые ему 36 байт")
  .text.umac_if_cmd_handler 0x00936dd0 : { KEEP(*(.text.umac_if_cmd_handler)) }
  ASSERT(SIZEOF(.text.umac_if_cmd_handler) <= 644, "блок umac_if_cmd_handler не влезает в отведённые ему 644 байт")
  .text.ucode_cmd_selective_neighbor_cfg 0x00937054 : { KEEP(*(.text.ucode_cmd_selective_neighbor_cfg)) }
  ASSERT(SIZEOF(.text.ucode_cmd_selective_neighbor_cfg) <= 52, "блок ucode_cmd_selective_neighbor_cfg не влезает в отведённые ему 52 байт")
  .text.stub_ret_937088 0x00937088 : { KEEP(*(.text.stub_ret_937088)) }
  ASSERT(SIZEOF(.text.stub_ret_937088) <= 4, "блок stub_ret_937088 не влезает в отведённые ему 4 байт")
  .text.bitstream__push 0x0093708c : { KEEP(*(.text.bitstream__push)) }
  ASSERT(SIZEOF(.text.bitstream__push) <= 44, "блок bitstream__push не влезает в отведённые ему 44 байт")
  .text.bi_window_transition_prep 0x009370b8 : { KEEP(*(.text.bi_window_transition_prep)) }
  ASSERT(SIZEOF(.text.bi_window_transition_prep) <= 384, "блок bi_window_transition_prep не влезает в отведённые ему 384 байт")
  .text.rx_funcs_copy_step 0x00937238 : { KEEP(*(.text.rx_funcs_copy_step)) }
  ASSERT(SIZEOF(.text.rx_funcs_copy_step) <= 164, "блок rx_funcs_copy_step не влезает в отведённые ему 164 байт")
  .text.mac__program_tx_rate 0x009372dc : { KEEP(*(.text.mac__program_tx_rate)) }
  ASSERT(SIZEOF(.text.mac__program_tx_rate) <= 40, "блок mac__program_tx_rate не влезает в отведённые ему 40 байт")
  .text.shallow_sleep_step 0x00937304 : { KEEP(*(.text.shallow_sleep_step)) }
  ASSERT(SIZEOF(.text.shallow_sleep_step) <= 172, "блок shallow_sleep_step не влезает в отведённые ему 172 байт")
  .text.mac__publish_masks 0x009373b0 : { KEEP(*(.text.mac__publish_masks)) }
  ASSERT(SIZEOF(.text.mac__publish_masks) <= 84, "блок mac__publish_masks не влезает в отведённые ему 84 байт")
  .text.brp__write_slot_txcfg 0x00937404 : { KEEP(*(.text.brp__write_slot_txcfg)) }
  ASSERT(SIZEOF(.text.brp__write_slot_txcfg) <= 68, "блок brp__write_slot_txcfg не влезает в отведённые ему 68 байт")
  .text.rf_sector__program_selected 0x00937448 : { KEEP(*(.text.rf_sector__program_selected)) }
  ASSERT(SIZEOF(.text.rf_sector__program_selected) <= 108, "блок rf_sector__program_selected не влезает в отведённые ему 108 байт")
  .text.bf_metrics__reset_and_stamp 0x009374b4 : { KEEP(*(.text.bf_metrics__reset_and_stamp)) }
  ASSERT(SIZEOF(.text.bf_metrics__reset_and_stamp) <= 28, "блок bf_metrics__reset_and_stamp не влезает в отведённые ему 28 байт")
  .text.peer__aid_mismatch_flag 0x009374d0 : { KEEP(*(.text.peer__aid_mismatch_flag)) }
  ASSERT(SIZEOF(.text.peer__aid_mismatch_flag) <= 32, "блок peer__aid_mismatch_flag не влезает в отведённые ему 32 байт")
  .text.rx_flow_substep 0x009374f0 : { KEEP(*(.text.rx_flow_substep)) }
  ASSERT(SIZEOF(.text.rx_flow_substep) <= 168, "блок rx_flow_substep не влезает в отведённые ему 168 байт")
  .text.obj__set_field18_from_tbl_801130 0x00937598 : { KEEP(*(.text.obj__set_field18_from_tbl_801130)) }
  ASSERT(SIZEOF(.text.obj__set_field18_from_tbl_801130) <= 24, "блок obj__set_field18_from_tbl_801130 не влезает в отведённые ему 24 байт")
  .text.internal_tx__await_rx_frame_a 0x009375b0 : { KEEP(*(.text.internal_tx__await_rx_frame_a)) }
  ASSERT(SIZEOF(.text.internal_tx__await_rx_frame_a) <= 60, "блок internal_tx__await_rx_frame_a не влезает в отведённые ему 60 байт")
  .text.bti_worker__collect_bf_metric 0x009375ec : { KEEP(*(.text.bti_worker__collect_bf_metric)) }
  ASSERT(SIZEOF(.text.bti_worker__collect_bf_metric) <= 404, "блок bti_worker__collect_bf_metric не влезает в отведённые ему 404 байт")
  .text.internal_tx__await_rx_frame_b 0x00937780 : { KEEP(*(.text.internal_tx__await_rx_frame_b)) }
  ASSERT(SIZEOF(.text.internal_tx__await_rx_frame_b) <= 60, "блок internal_tx__await_rx_frame_b не влезает в отведённые ему 60 байт")
  .text.sxd_hal__read_backoff_status 0x009377bc : { KEEP(*(.text.sxd_hal__read_backoff_status)) }
  ASSERT(SIZEOF(.text.sxd_hal__read_backoff_status) <= 92, "блок sxd_hal__read_backoff_status не влезает в отведённые ему 92 байт")
  .text.txss_func__reorder_sectors 0x00937818 : { KEEP(*(.text.txss_func__reorder_sectors)) }
  ASSERT(SIZEOF(.text.txss_func__reorder_sectors) <= 184, "блок txss_func__reorder_sectors не влезает в отведённые ему 184 байт")
  .text.uc_check_mpy_build 0x009378d0 : { KEEP(*(.text.uc_check_mpy_build)) }
  ASSERT(SIZEOF(.text.uc_check_mpy_build) <= 124, "блок uc_check_mpy_build не влезает в отведённые ему 124 байт")
  .text.bf_s11_w5_uc 0x0093794c : { KEEP(*(.text.bf_s11_w5_uc)) }
  ASSERT(SIZEOF(.text.bf_s11_w5_uc) <= 12, "блок bf_s11_w5_uc не влезает в отведённые ему 12 байт")
  .text.bf_b_s0_w5_uc 0x00937958 : { KEEP(*(.text.bf_b_s0_w5_uc)) }
  ASSERT(SIZEOF(.text.bf_b_s0_w5_uc) <= 12, "блок bf_b_s0_w5_uc не влезает в отведённые ему 12 байт")
  .text.bf_b_s0_w7_uc 0x00937964 : { KEEP(*(.text.bf_b_s0_w7_uc)) }
  ASSERT(SIZEOF(.text.bf_b_s0_w7_uc) <= 12, "блок bf_b_s0_w7_uc не влезает в отведённые ему 12 байт")
  .text.bf_s1_w1_uc 0x00937970 : { KEEP(*(.text.bf_s1_w1_uc)) }
  ASSERT(SIZEOF(.text.bf_s1_w1_uc) <= 12, "блок bf_s1_w1_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w2_uc 0x0093797c : { KEEP(*(.text.bf_w_s0_w2_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w2_uc) <= 12, "блок bf_w_s0_w2_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w4_uc 0x00937988 : { KEEP(*(.text.bf_w_s0_w4_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w4_uc) <= 12, "блок bf_w_s0_w4_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s0_w6_uc 0x00937994 : { KEEP(*(.text.bf_w_s0_w6_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s0_w6_uc) <= 12, "блок bf_w_s0_w6_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s15_w6_uc 0x009379a0 : { KEEP(*(.text.bf_w_s15_w6_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s15_w6_uc) <= 12, "блок bf_w_s15_w6_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s2_w2_uc 0x009379ac : { KEEP(*(.text.bf_w_s2_w2_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s2_w2_uc) <= 12, "блок bf_w_s2_w2_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s2_w4_uc 0x009379b8 : { KEEP(*(.text.bf_w_s2_w4_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s2_w4_uc) <= 12, "блок bf_w_s2_w4_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w3_uc 0x009379c4 : { KEEP(*(.text.bf_w_s4_w3_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w3_uc) <= 12, "блок bf_w_s4_w3_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w4_uc 0x009379d0 : { KEEP(*(.text.bf_w_s4_w4_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w4_uc) <= 12, "блок bf_w_s4_w4_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s4_w5_uc 0x009379dc : { KEEP(*(.text.bf_w_s4_w5_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s4_w5_uc) <= 12, "блок bf_w_s4_w5_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s6_w2_uc 0x009379e8 : { KEEP(*(.text.bf_w_s6_w2_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s6_w2_uc) <= 12, "блок bf_w_s6_w2_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s8_w15_uc 0x009379f4 : { KEEP(*(.text.bf_w_s8_w15_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s8_w15_uc) <= 12, "блок bf_w_s8_w15_uc не влезает в отведённые ему 12 байт")
  .text.bf_w_s8_w4_uc 0x00937a00 : { KEEP(*(.text.bf_w_s8_w4_uc)) }
  ASSERT(SIZEOF(.text.bf_w_s8_w4_uc) <= 12, "блок bf_w_s8_w4_uc не влезает в отведённые ему 12 байт")
  .text.cf_end_mtp_step 0x00937a0c : { KEEP(*(.text.cf_end_mtp_step)) }
  ASSERT(SIZEOF(.text.cf_end_mtp_step) <= 376, "блок cf_end_mtp_step не влезает в отведённые ему 376 байт")
  .text.mtp_queue__release_mgmt 0x00937b84 : { KEEP(*(.text.mtp_queue__release_mgmt)) }
  ASSERT(SIZEOF(.text.mtp_queue__release_mgmt) <= 768, "блок mtp_queue__release_mgmt не влезает в отведённые ему 768 байт")
  .text.bf_core_insert_uc 0x00937e84 : { KEEP(*(.text.bf_core_insert_uc)) }
  ASSERT(SIZEOF(.text.bf_core_insert_uc) <= 32, "блок bf_core_insert_uc не влезает в отведённые ему 32 байт")
  .text.epi_937ea4 0x00937ea4 : { KEEP(*(.text.epi_937ea4)) }
  ASSERT(SIZEOF(.text.epi_937ea4) <= 4, "блок epi_937ea4 не влезает в отведённые ему 4 байт")
  .text.bf_u16_core_uc 0x00937ea8 : { KEEP(*(.text.bf_u16_core_uc)) }
  ASSERT(SIZEOF(.text.bf_u16_core_uc) <= 44, "блок bf_u16_core_uc не влезает в отведённые ему 44 байт")
  .text.bf_rmw_word_unaligned_uc 0x00937ed4 : { KEEP(*(.text.bf_rmw_word_unaligned_uc)) }
  ASSERT(SIZEOF(.text.bf_rmw_word_unaligned_uc) <= 88, "блок bf_rmw_word_unaligned_uc не влезает в отведённые ему 88 байт")
  .text.bf_w_core_uc 0x00937f2c : { KEEP(*(.text.bf_w_core_uc)) }
  ASSERT(SIZEOF(.text.bf_w_core_uc) <= 20, "блок bf_w_core_uc не влезает в отведённые ему 20 байт")
  .text.bf_b_core_uc 0x00937f40 : { KEEP(*(.text.bf_b_core_uc)) }
  ASSERT(SIZEOF(.text.bf_b_core_uc) <= 20, "блок bf_b_core_uc не влезает в отведённые ему 20 байт")
  .text.bf_rmw_half_uc 0x00937f54 : { KEEP(*(.text.bf_rmw_half_uc)) }
  ASSERT(SIZEOF(.text.bf_rmw_half_uc) <= 20, "блок bf_rmw_half_uc не влезает в отведённые ему 20 байт")
  .text.uc_log__init 0x00937f68 : { KEEP(*(.text.uc_log__init)) }
  ASSERT(SIZEOF(.text.uc_log__init) <= 164, "блок uc_log__init не влезает в отведённые ему 164 байт")
  .text.uc_buffers__init 0x0093800c : { KEEP(*(.text.uc_buffers__init)) }
  ASSERT(SIZEOF(.text.uc_buffers__init) <= 148, "блок uc_buffers__init не влезает в отведённые ему 148 байт")
  .text.frag_9380a0 0x009380a0 : { KEEP(*(.text.frag_9380a0)) }
  ASSERT(SIZEOF(.text.frag_9380a0) <= 4, "блок frag_9380a0 не влезает в отведённые ему 4 байт")
  .text.uc_isr_vec19 0x009380a4 : { KEEP(*(.text.uc_isr_vec19)) }
  ASSERT(SIZEOF(.text.uc_isr_vec19) <= 32, "блок uc_isr_vec19 не влезает в отведённые ему 32 байт")
  .text.vacated_set_tsf_event 0x00930c28 : { KEEP(*(.text.vacated_set_tsf_event)) }
  .text.vacated_bi__decide_beacon_kind 0x009311a4 : { KEEP(*(.text.vacated_bi__decide_beacon_kind)) }
  /* переписанные на C блоки — в свободный хвост */
  .text.rewritten 0x9380c4 : {
    KEEP(*(.text.bi__decide_beacon_kind)) KEEP(*(.text.bi__decide_beacon_kind.*))
    KEEP(*(.text.set_tsf_event)) KEEP(*(.text.set_tsf_event.*))
    KEEP(*(.text.rw)) KEEP(*(.text.rw.*))
    *(.text .text.*)
    *(EXCLUDE_FILE(*uc_data.o) .rodata EXCLUDE_FILE(*uc_data.o) .rodata.*)
    *(.data .data.*)
    *(.bss .bss.* COMMON)
  }
  .rodata.rewritten : { KEEP(*(.rodata.rw)) KEEP(*(.rodata.rw.*)) }
  ASSERT(. <= 0x00940000, "переписанный код не влезает в свободный хвост")
  .rodata.uc_data 0x00800000 : { KEEP(*(.rodata.uc_data)) }
  PROVIDE(L_930c28 = set_tsf_event);
  PROVIDE(L_9311a4 = bi__decide_beacon_kind);
  /DISCARD/ : { *(.comment) *(.note*) *(.ARC.attributes) }
}
