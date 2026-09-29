/* hwd_dma__set_881c80 @ 0x8c7e64, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_dma.c
 * Зовут его: hwd_dma__program_vring_desc, hwd_dma__set_ring_base
 * Зовёт сам: fw_sysassert_fatal
 * Глобалы (через gp): 0x80032c, 0x800330
 */
	.section .text.hwd_dma__set_881c80,"ax",@progbits
	.global hwd_dma__set_881c80
hwd_dma__set_881c80:
	.global L_8c7e64
L_8c7e64:
	mov_s r1,r0
L_8c7e66:
	ld_s r0,[gp,0x1c0]
L_8c7e68:
	brne r0,0x1,L_8c7e84
L_8c7e6c:
	ld_s r0,[gp,0x1bc]
L_8c7e6e:
	cmp_s r1,r0
L_8c7e70:
	jeq_s [blink]
L_8c7e72:
	mov_s r0,blink
L_8c7e74:
	mov_s r2,0x1018504
L_8c7e7a:
	mov_s r1,0x6
L_8c7e7c:
	bset_s r1,r1,0xc
L_8c7e7e:
	b.d L_8c82c0
L_8c7e82:
	mov_s r3,0xe5
	.global L_8c7e84
L_8c7e84:
	mov_s r0,0x881c80
L_8c7e8a:
	st_s r1,[r0,0x8]
L_8c7e8c:
	st.as r1,[gp,0x6f]
L_8c7e90:
	mov_s r0,0x1
L_8c7e92:
	j_s.d [blink]
L_8c7e94:
	st.as r0,[gp,0x70]
