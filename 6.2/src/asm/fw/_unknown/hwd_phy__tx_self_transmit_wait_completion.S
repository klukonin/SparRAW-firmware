/* hwd_phy__tx_self_transmit_wait_completion @ 0x8d3024, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_self_transmit_wait_completion
hwd_phy__tx_self_transmit_wait_completion:
	.global L_8d3024
L_8d3024:
	push_s blink
L_8d3026:
	mov_s r0,0x884000
L_8d302c:
	ld_s r0,[r0,0x54]
L_8d302e:
	extw_s r0,r0
L_8d3030:
	cmp_s r0,0xffff
L_8d3036:
	mov.eq r0,blink
L_8d303a:
	mov.eq r1,0xdc
L_8d3042:
	bl.eq.d L_8c9b28
L_8d3046:
	bset.eq r1,r1,0xc
L_8d304a:
	b_s L_8d305c
	.global L_8d304c
L_8d304c:
	mov_s r0,0x50
L_8d304e:
	mov lp_count,r0
L_8d3052:
	nop_s
L_8d3054:
	lp L_8d305c
L_8d3058:
	nop_s
L_8d305a:
	nop_s
	.global L_8d305c
L_8d305c:
	mov_s r0,0x884080
L_8d3062:
	ld_s r0,[r0,0x70]
L_8d3064:
	extw.f 0x0,r0
L_8d3068:
	bne_s L_8d304c
L_8d306a:
	b_s L_8d307c
	.global L_8d306c
L_8d306c:
	mov_s r0,0x50
L_8d306e:
	mov lp_count,r0
L_8d3072:
	nop_s
L_8d3074:
	lp L_8d307c
L_8d3078:
	nop_s
L_8d307a:
	nop_s
	.global L_8d307c
L_8d307c:
	mov_s r0,0x884080
L_8d3082:
	ld_s r0,[r0,0x6c]
L_8d3084:
	bmsk.f 0x0,r0,0x15
L_8d3088:
	bne_s L_8d306c
L_8d308a:
	pop_s blink
L_8d308c:
	j_s [blink]
L_8d308e:
	nop_s
